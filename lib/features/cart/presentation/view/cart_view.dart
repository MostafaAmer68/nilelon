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
import 'package:nilelon/features/closet/presentation/view/closet_Page.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/footer/cart_footer.dart';
import 'package:nilelon/features/product/presentation/widgets/product_card/cart_item_cart.dart';
import 'package:nilelon/core/widgets/scaffold_image.dart';
import 'package:nilelon/core/widgets/shimmer_indicator/build_shimmer.dart';
import 'package:nilelon/core/widgets/view_all_row/view_all_row.dart';
import 'package:nilelon/core/utils/navigation.dart';

import '../../../../core/tools.dart';

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
        children: [
          const DefaultDivider(),
          const SizedBox(
            height: 8,
          ),
          ViewAllRow(
            text: '',
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
                if (cubit.cart.items.isEmpty) {
                  return Text(S.of(context).noProductCart);
                } else {
                  return Column(
                    children: [
                      SizedBox(
                        height: screenHeight(context, 0.4),
                        // width: screenWidth(context, 0.9),
                        child: ListView.builder(
                          itemCount: cubit.cart.items.length,
                          padding: const EdgeInsets.only(bottom: 5),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final cartItem = cubit.cart.items[index];
                            return CartItemWidget(cart: cartItem, index: index);
                          },
                        ),
                      ),
                      const Divider(),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SizedBox(
                            width: screenWidth(context, 0.4),
                            child: OutlinedButton(
                              onPressed: () {
                                CartCubit.get(context).emptyCart();
                              },
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(
                                    color: ColorManager.primaryR,
                                  ),
                                ),
                                backgroundColor: ColorManager.scaffoldBG,
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
              }
              return Text(S.of(context).smothingWent);
            },
          ),
        ],
      ),
      persistentFooterButtons: [
        BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is GetCartSuccess || state is UpdateQuantityCartLoading) {
              return CartFooter(
                visible: cubit.cart.items.isNotEmpty,
              );
            }
            return const SizedBox();
          },
        ),
      ],
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
              dismissible: DismissiblePane(onDismissed: () {
                BlocProvider.of<CartCubit>(context).deleteFromCart(
                  DeleteRequestModel(
                    color: cart.color,
                    size: cart.size,
                    productId: cubit.cart.items[index].productId,
                    customrId:
                        HiveStorage.get<UserModel>(HiveKeys.userModel).id,
                  ),
                );
              }),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    BlocProvider.of<CartCubit>(context).deleteFromCart(
                      DeleteRequestModel(
                        color: cart.color,
                        size: cubit.cart.items[index].size,
                        productId: cubit.cart.items[index].productId,
                        customrId:
                            HiveStorage.get<UserModel>(HiveKeys.userModel).id,
                      ),
                    );
                  },
                  backgroundColor: ColorManager.primaryO,
                  icon: Iconsax.trash,
                  foregroundColor: ColorManager.primaryW,
                  label: lang(context).delete,
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
