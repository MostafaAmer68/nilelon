import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/tools.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/button/outlined_button_builder.dart';
import 'package:nilelon/features/auth/domain/model/user_model.dart';
import 'package:nilelon/features/cart/domain/model/add_cart_request_model.dart';
import 'package:nilelon/features/cart/domain/model/cart_item.dart';
import 'package:nilelon/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:nilelon/features/layout/customer_bottom_tab_bar.dart';
import 'package:nilelon/features/order/presentation/pages/checkout_view.dart';
import 'package:nilelon/features/product/domain/models/product_model.dart';
import 'package:nilelon/core/widgets/button/button_builder.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/features/promo/presentation/cubit/promo_cubit.dart';
import 'package:svg_flutter/svg.dart';

import '../../../generated/l10n.dart';
import '../../constants/assets.dart';

class AddToFooter extends StatelessWidget {
  const AddToFooter({super.key, this.visible = true, required this.product});
  final bool visible;
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Container(
        height: 100,
        color: ColorManager.primaryW,
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OutlinedButtonBuilder(
              text: S.of(context).buyNow,
              ontap: () {
                if (HiveStorage.get(HiveKeys.isStore)) {
                  BotToast.showText(text: lang(context).youAreStore);
                  return;
                }
                if (HiveStorage.get(HiveKeys.userModel) != null) {
                  PromoCubit.get(context).deliveryPrice = 0;
                  PromoCubit.get(context).totalPrice = 0;
                  PromoCubit.get(context).orderTotal = 0;
                  PromoCubit.get(context).discount = 0;
                  PromoCubit.get(context).newPrice = 0;
                  PromoCubit.get(context).tempTotalPrice = 0;
                  CartCubit.get(context).tempCartItems.clear();
                  CartCubit.get(context).tempCartItems.add(
                        CartItem(
                            quantity:
                                product.productVariants.first.quantity.toInt(),
                            size: product.productVariants
                                .firstWhere((e) => e.price != 0)
                                .size,
                            color: product.productVariants
                                .firstWhere((e) => e.price != 0)
                                .color,
                            price: product.productVariants
                                .firstWhere((e) => e.price != 0)
                                .price,
                            productName: product.name,
                            productId: product.id,
                            productImages: product.productImages,
                            cartId: ''),
                      );
                  PromoCubit.get(context).totalPrice = product.productVariants
                      .firstWhere((e) => e.price != 0)
                      .price;
                  PromoCubit.get(context).newPrice = product.productVariants
                      .firstWhere((e) => e.price != 0)
                      .price;
                  PromoCubit.get(context).orderTotal = product.productVariants
                      .firstWhere((e) => e.price != 0)
                      .price;
                  PromoCubit.get(context).tempTotalPrice = product
                      .productVariants
                      .firstWhere((e) => e.price != 0)
                      .price;
                  log(PromoCubit.get(context).totalPrice.toString());
                  if (PromoCubit.get(context).totalPrice > 0 &&
                      PromoCubit.get(context).tempTotalPrice > 0) {
                    navigateTo(
                        context: context,
                        screen: const CheckOutView(isBuNow: true));
                  }
                } else {
                  navigateTo(
                      context: context,
                      screen: const CustomerBottomTabBar(index: 3));
                }
              },
              buttonColor: ColorManager.primaryW,
              frameColor: ColorManager.gradientColors.first,
              style: AppStylesManager.customTextStyleB4,
            ),
            BlocConsumer<CartCubit, CartState>(
              listener: (context, state) {
                if (state is CartSuccess) {
                  BotToast.showCustomText(
                    duration: const Duration(seconds: 4),
                    toastBuilder: (_) => Card(
                      color: Colors.black87,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              S.of(context).productAddedToCart,
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(width: 10),
                            TextButton(
                              onPressed: () {
                                BotToast.closeAllLoading();

                                navigateAndRemoveUntil(
                                    context: context,
                                    screen: const CustomerBottomTabBar(
                                      index: 1,
                                    ));

                                BotToast.cleanAll();
                              },
                              child: Text(
                                S.of(context).viewCart,
                                style: const TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (state is GetCartFailure) {
                  BotToast.showText(text: state.message);
                }
              },
              builder: (context, state) {
                return GradientButtonBuilder(
                  isIcon: true,
                  icon: SvgPicture.asset(Assets.assetsImagesAddTOCart),
                  text: state is CartLoading
                      ? S.of(context).loading
                      : S.of(context).addToCart,
                  ontap: () {
                    if (HiveStorage.get(HiveKeys.isStore)) {
                      BotToast.showText(text: lang(context).youAreStore);
                      return;
                    }
                    if (HiveStorage.get(HiveKeys.userModel) != null) {
                      if (product.id.isNotEmpty) {
                        if (CartCubit.get(context).selectedSize.isNotEmpty &&
                            CartCubit.get(context).selectedColor.isNotEmpty) {
                          CartCubit.get(context).addToCart(
                            AddToCartModel(
                              quantity: CartCubit.get(context).counter,
                              size: CartCubit.get(context).selectedSize,
                              color: CartCubit.get(context).selectedColor,
                              productId: product.id,
                              customerId:
                                  HiveStorage.get<UserModel>(HiveKeys.userModel)
                                      .id,
                            ),
                          );
                        } else {
                          BotToast.showText(text: lang(context).smothingWent);
                        }
                      } else {
                        BotToast.showText(text: lang(context).smothingWent);
                      }
                    } else {
                      navigateTo(
                          context: context,
                          screen: const CustomerBottomTabBar(index: 3));
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
