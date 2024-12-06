import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/tools.dart';
import 'package:nilelon/core/widgets/button/button_builder.dart';
import 'package:nilelon/core/widgets/replacer/image_replacer.dart';
import 'package:nilelon/features/cart/domain/model/add_cart_request_model.dart';
import 'package:nilelon/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:svg_flutter/svg.dart';

import '../../../../features/auth/domain/model/user_model.dart';
import '../../../../features/cart/domain/model/cart_item.dart';
import '../../../../features/closet/presentation/view/closet_sheet_bar_view.dart';
import '../../../../features/layout/customer_bottom_tab_bar.dart';
import '../../../../features/order/presentation/pages/checkout_view.dart';
import '../../../../features/product/domain/models/product_model.dart';
import '../../../../features/product/presentation/pages/product_details_page.dart';
import '../../../../features/product/presentation/pages/product_details_store_page.dart';
import '../../../../features/promo/presentation/cubit/promo_cubit.dart';
import '../../../../generated/l10n.dart';
import '../../../constants/assets.dart';
import '../../../data/hive_stroage.dart';
import '../../../utils/navigation.dart';

class WideCard extends StatelessWidget {
  const WideCard({
    super.key,
    required this.product,
  });
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    return GestureDetector(
      onTap: () {
        navigateTo(
          context: context,
          screen: !HiveStorage.get(HiveKeys.isStore)
              ? ProductDetailsView(productId: product.id)
              : ProductStoreDetailsView(productId: product.id),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFF7FDFF),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: ColorManager.primaryO10,
              blurRadius: 0,
              offset: Offset(6, 6),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: imageReplacer(
                url: product.productImages.first.url,
                // height: 125,
                width: 140,
                radius: 16,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Expanded(
                    flex: !HiveStorage.get(HiveKeys.isStore) ? 1 : 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            product.name,
                            style: AppStylesManager.customTextStyleO3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Visibility(
                          visible: !HiveStorage.get(HiveKeys.isStore),
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: ColorManager.primaryW,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                builder: (context) =>
                                    ClosetSheetBarView(productId: product.id),
                              );
                            },
                            child: Container(
                              clipBehavior: Clip.none,
                              width: 30.w,
                              height: 30.w,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: product.isInCloset ? null : Colors.white,
                                gradient: product.isInCloset
                                    ? const LinearGradient(
                                        colors: ColorManager.gradientColors)
                                    : null,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        Colors.orange.shade300.withOpacity(1),
                                    offset: const Offset(3, 3),
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: !product.isInCloset
                                  ? SvgPicture.asset(
                                      Assets.assetsImagesHanger,
                                      fit: BoxFit.cover,
                                    )
                                  : SvgPicture.asset(
                                      Assets.assetsImagesActiveCloset,
                                      fit: BoxFit.cover,
                                      width: 60,
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: !HiveStorage.get(HiveKeys.isStore) ? 1 : 1,
                    child: Text(
                      '${product.productVariants.first.price} ${lang(context).le}',
                      style: AppStylesManager.customTextStyleBl2,
                    ),
                  ),
                  Expanded(
                    flex: !HiveStorage.get(HiveKeys.isStore) ? 1 : 1,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            product.storeName,
                            style: AppStylesManager.customTextStyleB4,
                          ),
                        ),
                        Icon(
                          Icons.star,
                          color: ColorManager.primaryO2,
                          size: 20.r,
                        ),
                        Text(
                          product.rating.toString(),
                          style: AppStylesManager.customTextStyleG,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Visibility(
                    visible: !HiveStorage.get(HiveKeys.isStore),
                    child: Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Container(
                            height: 40.h,
                            width: screenWidth(context, 0.12),
                            decoration: BoxDecoration(
                              color: product.productVariants.isEmpty
                                  ? ColorManager.primaryG4
                                  : product.productVariants.first.quantity == 0
                                      ? ColorManager.primaryG4
                                      : ColorManager.primaryG8,
                              borderRadius: BorderRadius.circular(7),
                              boxShadow: const [
                                BoxShadow(
                                  color: ColorManager.primaryO,
                                  blurRadius: 0,
                                  offset: Offset(4, 4),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: BlocConsumer<CartCubit, CartState>(
                              listener: (context, state) {
                                if (state is CartSuccess) {
                                  isLoading = false;
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
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            const SizedBox(width: 10),
                                            TextButton(
                                              onPressed: () {
                                                BotToast.closeAllLoading();

                                                navigateTo(
                                                    context: context,
                                                    screen:
                                                        const CustomerBottomTabBar(
                                                      index: 1,
                                                    ));

                                                BotToast.cleanAll();
                                              },
                                              child: Text(
                                                S.of(context).viewCart,
                                                style: const TextStyle(
                                                    color: Colors.blue),
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
                                return isLoading
                                    ? const Padding(
                                        padding: EdgeInsets.all(12),
                                        child: CircularProgressIndicator(),
                                      )
                                    : IconButton(
                                        icon: const Icon(
                                          Iconsax.shopping_cart,
                                          color: ColorManager.primaryB2,
                                        ),
                                        onPressed: () {
                                          if (product.productVariants.first
                                                  .quantity ==
                                              0) {
                                            return;
                                          }
                                          isLoading = true;
                                          if (HiveStorage.get(
                                              HiveKeys.isStore)) {
                                            BotToast.showText(
                                                text:
                                                    lang(context).youAreStore);
                                            return;
                                          }
                                          if (HiveStorage.get(
                                                  HiveKeys.userModel) !=
                                              null) {
                                            if (product.id.isNotEmpty) {
                                              CartCubit.get(context).addToCart(
                                                AddToCartModel(
                                                  quantity: 1,
                                                  size: product.productVariants
                                                      .firstWhere(
                                                          (e) => e.price != 0)
                                                      .size,
                                                  color: product.productVariants
                                                      .firstWhere(
                                                          (e) => e.price != 0)
                                                      .color,
                                                  productId: product.id,
                                                  customerId: HiveStorage.get<
                                                              UserModel>(
                                                          HiveKeys.userModel)
                                                      .id,
                                                ),
                                              );
                                            } else {
                                              BotToast.showText(
                                                  text: lang(context)
                                                      .smothingWent);
                                            }
                                          } else {
                                            navigateTo(
                                                context: context,
                                                screen:
                                                    const CustomerBottomTabBar(
                                                        index: 3));
                                          }
                                        },
                                      );
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ButtonBuilder(
                              isActivated:
                                  product.productVariants.first.quantity != 0,
                              text: lang(context).buy,
                              ontap: () {
                                if (product.productVariants.first.quantity ==
                                    0) {
                                  return;
                                }
                                if (HiveStorage.get(HiveKeys.isStore)) {
                                  BotToast.showText(
                                      text: lang(context).youAreStore);
                                  return;
                                }
                                if (HiveStorage.get(HiveKeys.userModel) !=
                                    null) {
                                  PromoCubit.get(context).deliveryPrice = 0;
                                  PromoCubit.get(context).totalPrice = 0;
                                  PromoCubit.get(context).orderTotal = 0;
                                  PromoCubit.get(context).discount = 0;
                                  PromoCubit.get(context).newPrice = 0;
                                  PromoCubit.get(context).tempTotalPrice = 0;
                                  CartCubit.get(context).tempCartItems.clear();
                                  CartCubit.get(context).tempCartItems.add(
                                        CartItem(
                                            quantity: product
                                                .productVariants.first.quantity
                                                .toInt(),
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
                                            productImages:
                                                product.productImages,
                                            cartId: ''),
                                      );
                                  PromoCubit.get(context).totalPrice = product
                                      .productVariants
                                      .firstWhere((e) => e.price != 0)
                                      .price;
                                  PromoCubit.get(context).newPrice = product
                                      .productVariants
                                      .firstWhere((e) => e.price != 0)
                                      .price;
                                  PromoCubit.get(context).orderTotal = product
                                      .productVariants
                                      .firstWhere((e) => e.price != 0)
                                      .price;
                                  PromoCubit.get(context).tempTotalPrice =
                                      product.productVariants
                                          .firstWhere((e) => e.price != 0)
                                          .price;
                                  if (PromoCubit.get(context).totalPrice > 0 &&
                                      PromoCubit.get(context).tempTotalPrice >
                                          0) {
                                    navigateTo(
                                        context: context,
                                        screen:
                                            const CheckOutView(isBuNow: true));
                                  }
                                } else {
                                  navigateTo(
                                      context: context,
                                      screen:
                                          const CustomerBottomTabBar(index: 3));
                                }
                              },
                              frameColor: ColorManager.gradientBoxColors[1],
                              // width: screenWidth(context, 0.30),
                              height: 40.h,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: !HiveStorage.get(HiveKeys.isStore) ? 1.w : 15.h,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 12,
            ),
          ],
        ),
      ),
    );
  }
}
