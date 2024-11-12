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

GestureDetector offersCard({required context, required ProductModel product}) {
  final price = product.productVariants
      .firstWhere(
        (e) => e.price != 0,
        orElse: () => product.productVariants.first,
      )
      .price;
  var priceAfterDiscount = product.productVariants.first.price *
      (product.productVariants.first.discountRate / 100);
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
      width: screenWidth(context, 0.42),
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
                  '${product.productVariants.first.discountRate}%',
                  style: AppStylesManager.customTextStyleW4,
                )),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 15),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: colorConst
              //         .map(
              //           (e) => Container(
              //             margin: const EdgeInsets.symmetric(horizontal: 3),
              //             width: 10,
              //             height: 10,
              //             decoration: BoxDecoration(
              //               color: e,
              //               shape: BoxShape.circle,
              //             ),
              //           ),
              //         )
              //         .toList(),
              //   ),
              // ),
            ],
          ),
          const SizedBox(height: 10),
          Stack(
            alignment: Alignment.topRight,
            children: [
              Center(
                child: Container(
                  width: screenWidth(context, 0.38),
                  height: 130.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: imageReplacer(url: product.productImages.first.url),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 25,
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
                    width: 35.w, // Increased size to match the image
                    height: 35.w,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.shade300.withOpacity(1),
                          offset: const Offset(
                              3, 3), // Adjusted shadow to be more subtle
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: !product.isInCloset
                        ? SizedBox(
                            // width: 20,
                            child: SvgPicture.asset(
                              Assets.assetsImagesHanger,
                              width: 30,
                              // height: ,

                              fit: BoxFit.cover,
                            ),
                          )
                        : Image.asset(
                            Assets.assetsImagesClosetFollowing,
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
                  '$price ${lang(context).le}',
                  style: AppStylesManager.customTextStyleO3
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      '$priceAfterDiscount ${lang(context).le}',
                      style: AppStylesManager.customTextStyleG,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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
              Expanded(
                child: GradientButtonBuilder(
                  text: lang(context).buy,
                  ontap: () {
                    if (HiveStorage.get(HiveKeys.isStore)) {
                      BotToast.showText(text: lang(context).youAreStore);
                      return;
                    }
                    if (HiveStorage.get(HiveKeys.userModel) != null) {
                      CartCubit.get(context).tempCartItems.clear();
                      CartCubit.get(context).tempCartItems.add(CartItem(
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
                          context: context, screen: const CheckOutView());
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
          )
        ],
      ),
    ),
  );
}
