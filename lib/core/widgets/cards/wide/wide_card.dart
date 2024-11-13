import 'dart:developer';

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
import 'package:nilelon/core/widgets/price_and_rating_row/price_and_rating_row.dart';
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
        log(product.name, name: 'wide');
        log(product.id, name: 'wide id');
        navigateTo(
          context: context,
          screen: !HiveStorage.get(HiveKeys.isStore)
              ? ProductDetailsView(productId: product.id)
              : ProductStoreDetailsView(productId: product.id),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
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
            imageReplacer(
              url: product.productImages.first.url,
              height: 140,
              width: 140,
              radius: 16,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 10),
            Expanded(
              // flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        product.name,
                        style: AppStylesManager.customTextStyleO3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Visibility(
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
                            child: !product.isInCloset
                                ? Container(
                                    width: 30.w,
                                    height: 30.w,
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.orange.shade300
                                              .withOpacity(1),
                                          offset: const Offset(3, 3),
                                          blurRadius: 5,
                                        ),
                                      ],
                                    ),
                                    child: SvgPicture.asset(
                                      Assets.assetsImagesHanger,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Image.asset(
                                    Assets.assetsImagesClosetFollowing,
                                    fit: BoxFit.cover,
                                    width: 40,
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(
                  //   height: 4,
                  // ),
                  Text(
                    '${product.productVariants.first.price} ${lang(context).le}',
                    style: AppStylesManager.customTextStyleBl2,
                  ),

                  Row(
                    children: [
                      Text(
                        product.storeName,
                        style: AppStylesManager.customTextStyleB4,
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
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Container(
                        height: 40.h,
                        width: screenWidth(context, 0.12),
                        decoration: BoxDecoration(
                          color: ColorManager.primaryG8,
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
                                      isLoading = true;
                                      if (HiveStorage.get(HiveKeys.isStore)) {
                                        BotToast.showText(
                                            text: lang(context).youAreStore);
                                        return;
                                      }
                                      if (HiveStorage.get(HiveKeys.userModel) !=
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
                                              customerId:
                                                  HiveStorage.get<UserModel>(
                                                          HiveKeys.userModel)
                                                      .id,
                                            ),
                                          );
                                        } else {
                                          BotToast.showText(
                                              text: lang(context).smothingWent);
                                        }
                                      } else {
                                        navigateTo(
                                            context: context,
                                            screen: const CustomerBottomTabBar(
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
                          text: lang(context).buy,
                          ontap: () {
                            if (HiveStorage.get(HiveKeys.isStore)) {
                              BotToast.showText(
                                  text: lang(context).youAreStore);
                              return;
                            }
                            if (HiveStorage.get(HiveKeys.userModel) != null) {
                              CartCubit.get(context).tempCartItems.clear();
                              CartCubit.get(context).tempCartItems.add(CartItem(
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
                                  productImages: product.productImages,
                                  cartId: ''));
                              PromoCubit.get(context).totalPrice = product
                                  .productVariants
                                  .firstWhere((e) => e.price != 0)
                                  .price;
                              PromoCubit.get(context).tempTotalPrice = product
                                  .productVariants
                                  .firstWhere((e) => e.price != 0)
                                  .price;
                              navigateTo(
                                  context: context,
                                  screen: const CheckOutView());
                            } else {
                              navigateTo(
                                  context: context,
                                  screen: const CustomerBottomTabBar(index: 3));
                            }
                          },
                          frameColor: ColorManager.gradientBoxColors[1],
                          // width: screenWidth(context, 0.30),
                          height: 40.h,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
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
