import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/core/constants/assets.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/core/widgets/replacer/image_replacer.dart';
import 'package:nilelon/features/cart/domain/model/cart_item.dart';
import 'package:nilelon/features/order/presentation/pages/checkout_view.dart';
import 'package:nilelon/features/product/domain/models/product_model.dart';
import 'package:svg_flutter/svg_flutter.dart';

import '../../../../../generated/l10n.dart';
import '../../../../auth/domain/model/user_model.dart';
import '../../../../cart/domain/model/add_cart_request_model.dart';
import '../../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../../closet/presentation/view/closet_sheet_bar_view.dart';
import '../../../../layout/customer_bottom_tab_bar.dart';
import '../../../../promo/presentation/cubit/promo_cubit.dart';
import '../../pages/product_details_page.dart';
import '../../pages/product_details_store_page.dart';
import '../../../../../core/data/hive_stroage.dart';
import '../../../../../core/tools.dart';
import '../../../../../core/utils/navigation.dart';

GestureDetector offersCard({
  required context,
  required ProductModel product,
}) {
  final price = product.productVariants
      .firstWhere(
        (e) => e.price != 0,
        orElse: () => product.productVariants.first,
      )
      .price;

  final discount = product.productVariants
      .firstWhere(
        (e) => e.discountRate != 0,
        orElse: () => product.productVariants.first,
      )
      .discountRate;
  var priceAfterDiscount = product.productVariants
      .firstWhere(
        (e) => e.price != 0,
        orElse: () => product.productVariants.first,
      )
      .newPrice;
  log(priceAfterDiscount.toString());
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
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(4), // Updated to match rounded corners
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: ColorManager.primaryO3,
            blurRadius: 0,
            offset: Offset(-8, 7),
            spreadRadius: 0,
          )
        ],
      ),
      width: screenWidth(context, 0.50),
      height: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: screenWidth(context, 0.16),
                height: 30.h,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      // bottomLeft: Radius.circular(14),
                      bottomRight: Radius.circular(14),
                    ),
                    color: ColorManager.primaryO),
                child: Center(
                    child: Text(
                  '${double.parse(('${discount * 100}')).toStringAsFixed(0)}%',
                  style: AppStylesManager.customTextStyleW4,
                )),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Stack(
            alignment: Alignment.topRight,
            children: [
              imageReplacer(
                url: product.productImages.first.url,
                height: 140.w,
                width: 300.w,
                fit: BoxFit.cover,
              ),
              Visibility(
                visible: !HiveStorage.get(HiveKeys.isStore),
                child: Positioned(
                  top: 0,
                  right: 15,
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        // isScrollControlled: true,

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
                      width: 35.w,
                      height: 35.w,
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
                            color: Colors.orange.shade300.withOpacity(1),
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
              )
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Center(
            child: Text(
              product.name,
              overflow: TextOverflow.ellipsis,
              style: AppStylesManager.customTextStyleB4,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Text(
                  '$priceAfterDiscount ${lang(context).le}',
                  style: AppStylesManager.customTextStyleO3
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      '$price ${lang(context).le}',
                      style: AppStylesManager.customTextStyleG5,
                    ),
                    const SizedBox(
                      width: 50,
                      height: 12,
                      child: Divider(
                        thickness: 1,
                        color: ColorManager.primaryG2,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Visibility(
            visible: !HiveStorage.get(HiveKeys.isStore),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(width: 13),
                Container(
                  height: 30.h,
                  width: 30.h,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 233, 242, 245),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: BlocConsumer<CartCubit, CartState>(
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
                                      // BotToast.remove()

                                      navigateTo(
                                          context: context,
                                          screen: const CustomerBottomTabBar(
                                            index: 1,
                                          ));

                                      BotToast.cleanAll();
                                    },
                                    child: Text(
                                      S.of(context).viewCart,
                                      style:
                                          const TextStyle(color: Colors.blue),
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
                      if (state is CartLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return IconButton(
                        icon: Icon(
                          Iconsax.shopping_cart,
                          color: ColorManager.primaryB,
                          size: 14.r,
                        ),
                        onPressed: () {
                          if (product.productVariants
                                  .firstWhere(
                                    (e) => e.price != 0,
                                    orElse: () => product.productVariants.first,
                                  )
                                  .quantity ==
                              0) {
                            return;
                          }
                          CartCubit.get(context).addToCart(
                            AddToCartModel(
                              quantity: 1,
                              size: product.productVariants.first.size,
                              color: product.productVariants.first.color,
                              productId: product.id,
                              customerId:
                                  HiveStorage.get<UserModel>(HiveKeys.userModel)
                                      .id,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: GradientButtonBuilder(
                    isActivated: product.productVariants
                            .firstWhere(
                              (e) => e.price != 0,
                              orElse: () => product.productVariants.first,
                            )
                            .quantity !=
                        0,
                    text: lang(context).buy,
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
                                  quantity: 1,
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
                        PromoCubit.get(context).tempTotalPrice = product
                            .productVariants
                            .firstWhere((e) => e.price != 0)
                            .price;
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
                    width: 110.h,
                    height: 30.h,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}
