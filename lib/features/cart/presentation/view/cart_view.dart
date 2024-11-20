import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/widgets/button/outlined_button_builder.dart';
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
import '../../../layout/customer_bottom_tab_bar.dart';

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
  void dispose() {
    // cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    return PopScope(
      canPop: false,
      onPopInvoked: (s) {
        navigateAndRemoveUntil(
            context: context,
            screen: const CustomerBottomTabBar(
              index: 0,
            ));
      },
      child: ScaffoldImage(
        appBar: customAppBar(
          title: lang.cart,
          context: context,
          leadingOnPressed: () {
            navigateAndRemoveUntil(
                context: context,
                screen: const CustomerBottomTabBar(
                  index: 0,
                ));
          },
          hasLeading: false,
        ),
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const DefaultDivider(),
            const SizedBox(
              height: 8,
            ),
            BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                return ViewAllRow(
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
                );
              },
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
                  return Expanded(child: buildShimmerIndicator());
                } else if (state is GetCartFailure) {
                  return Text(state.message);
                } else if (state is GetCartSuccess ||
                    state is UpdateQuantityCartLoading) {
                  if (cubit.cart1.items.isEmpty) {
                    return SizedBox(
                      height: screenHeight(context, 0.6),
                      child: Center(
                        child: Text(S.of(context).noProductCart),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: cubit.cart1.items.length + 1,
                      padding: const EdgeInsets.only(bottom: 5),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        if (cubit.cart1.items.length == index) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 20),
                              const DefaultDivider(),
                              Align(
                                alignment: AlignmentDirectional.bottomEnd,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    right: 38,
                                    top: 15,
                                  ),
                                  child: SizedBox(
                                    width: screenWidth(context, 0.3),
                                    child: OutlinedButtonBuilder(
                                      ontap: () {
                                        CartCubit.get(context).emptyCart();
                                      },
                                      frameColor: ColorManager.primaryR,
                                      style: AppStylesManager.customTextStyleR,
                                      height: 40.w,
                                      text: lang.emptyCart,
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
    return Slidable(
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
                  customrId: HiveStorage.get<UserModel>(HiveKeys.userModel).id,
                ),
              );
            },
          ),
          children: [
            SlidableAction(
              // padding: EdgeInsets.symmetric(hor),
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) {
                BlocProvider.of<CartCubit>(context).deleteFromCart(
                  DeleteRequestModel(
                    color: cart.color,
                    size: cubit.cart1.items[index].size,
                    productId: cubit.cart1.items[index].productId,
                    customrId:
                        HiveStorage.get<UserModel>(HiveKeys.userModel).id,
                  ),
                );
              },
              // spacing: ,
              backgroundColor: ColorManager.primaryG4,
              icon: Iconsax.trash,
              foregroundColor: ColorManager.primaryW,
              label: lang(context).delete,
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CartItemCard(
          cart: cart,
        ),
      ),
    );
  }
}
