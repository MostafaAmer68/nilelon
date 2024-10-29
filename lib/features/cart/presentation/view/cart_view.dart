import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/features/auth/domain/model/user_model.dart';
import 'package:nilelon/features/cart/domain/model/cart_item.dart';
import 'package:nilelon/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:nilelon/features/cart/domain/model/delete_request_model.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/footer/cart_footer.dart';
import 'package:nilelon/features/cart/presentation/view/cart_item_cart.dart';
import 'package:nilelon/core/widgets/scaffold_image.dart';
import 'package:nilelon/core/widgets/shimmer_indicator/build_shimmer.dart';
import 'package:nilelon/core/widgets/view_all_row/view_all_row.dart';
import 'package:nilelon/core/utils/navigation.dart';

import '../../../../core/tools.dart';
import '../../../closet/presentation/view/closet_page.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late final CartCubit cubit;
  @override
  void initState() {
    cubit = CartCubit.get(context);
    cubit.getCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    return ScaffoldImage(
      appBar: customAppBar(
        title: lang.cart,
        context: context,
        hasLeading: false,
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const DefaultDivider(),
          const SizedBox(
            height: 8,
          ),
          ViewAllRow(
            isStyled: false,
            text: cubit.cart1.items.isEmpty
                ? ''
                : '${cubit.cart1.items.length} ${lang.items}',
            onPressed: () {
              navigateTo(
                context: context,
                screen: const ClosetPage(),
              );
            },
            buttonText: lang.yourcloset,
          ),
          const SizedBox(
            height: 8,
          ),
          BlocConsumer<CartCubit, CartState>(
            listener: (context, state) {
              if (state is DeleteFromCartSuccess) {
                BotToast.showText(text: S.of(context).itemDeleteCart);
              } else if (state is DeleteFromCartFailure) {
                BotToast.showText(
                  text: state.message,
                );
              } else {}
            },
            builder: (context, state) {
              if (state is CartLoading) {
                return Expanded(
                    child:
                        SingleChildScrollView(child: buildShimmerIndicator()));
              } else if (state is GetCartFailure) {
                return Text(state.message);
              } else if (state is GetCartSuccess ||
                  state is UpdateQuantityCartLoading) {
                log(cubit.cart1.id.toString());
                if (cubit.cart1.items.isEmpty) {
                  return SizedBox(
                    height: screenHeight(context, 0.6),
                    child: Center(
                      child: Text(S.of(context).noProductCart),
                    ),
                  );
                } else {
                  return SizedBox(
                    height: screenHeight(context, 0.5),
                    // width: screenWidth(context, 0.9),5
                    child: ListView.builder(
                      itemCount: cubit.cart1.items.length + 1,
                      padding: const EdgeInsets.only(bottom: 5),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        if (cubit.cart1.items.length == index) {
                          return Column(
                            children: [
                              const SizedBox(height: 20),
                              const DefaultDivider(),
                              Align(
                                alignment: AlignmentDirectional.bottomEnd,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: SizedBox(
                                    width: screenWidth(context, 0.4),
                                    child: OutlinedButton(
                                      onPressed: () {
                                        CartCubit.get(context).emptyCart();
                                      },
                                      style: OutlinedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: const BorderSide(
                                            color: ColorManager.primaryR,
                                          ),
                                        ),
                                        backgroundColor:
                                            ColorManager.scaffoldBG,
                                      ),
                                      child: Text(
                                        lang.emptyCart,
                                        style: const TextStyle(
                                          color: ColorManager.primaryR,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                            ],
                          );
                        }
                        final item = cubit.cart1.items[index];
                        return CartItemWidget(cart: item, index: index);
                      },
                    ),
                  );
                }
              }
              return Text(S.of(context).smothingWent);
            },
          ),
        ],
      ),
      btmBar: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is GetCartSuccess || state is UpdateQuantityCartLoading) {
            return CartFooter(
              visible: cubit.cart1.items.isNotEmpty,
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    super.key,
    required this.cart,
    required this.index,
  });

  final CartItem cart;
  final int index;

  @override
  Widget build(BuildContext context) {
    final cubit = CartCubit.get(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Slidable(
          key: ValueKey(index),
          endActionPane: ActionPane(
              motion: const BehindMotion(),
              extentRatio: 0.3,
              dismissible: DismissiblePane(
                onDismissed: () {
                  BlocProvider.of<CartCubit>(context).deleteFromCart(
                    DeleteRequestModel(
                      color: cart.color,
                      size: cart.size,
                      productId: cubit.cart1.items[index].productId,
                      customrId:
                          HiveStorage.get<UserModel>(HiveKeys.userModel).id,
                    ),
                  );
                },
              ),
              children: [
                Flexible(
                  child: SizedBox(
                    width: 100,
                    child: SlidableAction(
                      // padding: EdgeInsets.symmetric(hor),
                      borderRadius: BorderRadius.circular(15),
                      onPressed: (context) {
                        BlocProvider.of<CartCubit>(context).deleteFromCart(
                          DeleteRequestModel(
                            color: cart.color,
                            size: cubit.cart1.items[index].size,
                            productId: cubit.cart1.items[index].productId,
                            customrId:
                                HiveStorage.get<UserModel>(HiveKeys.userModel)
                                    .id,
                          ),
                        );
                      },
                      // spacing: ,
                      backgroundColor: ColorManager.primaryG4,
                      icon: Iconsax.trash,
                      foregroundColor: ColorManager.primaryW,
                      label: lang(context).delete,
                    ),
                  ),
                ),
              ]),
          child: CartItemCard(
            cart: cart,
          ),
        )
      ],
    );
  }
}
