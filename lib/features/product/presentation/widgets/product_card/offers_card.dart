import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/core/constants/assets.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/widgets/button/button_builder.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/core/widgets/replacer/image_replacer.dart';
import 'package:nilelon/features/product/domain/models/product_model.dart';
import 'package:svg_flutter/svg_flutter.dart';

import '../../../../../core/color_const.dart';
import '../../../../auth/domain/model/user_model.dart';
import '../../pages/product_details_page.dart';
import '../../pages/product_details_store_page.dart';
import '../../../../../core/data/hive_stroage.dart';
import '../../../../../core/tools.dart';
import '../../../../../core/utils/navigation.dart';

GestureDetector offersCard({required context, required ProductModel product}) {
  return GestureDetector(
    onTap: () {
      navigateTo(
        context: context,
        screen:
            product.storeId != HiveStorage.get<UserModel>(HiveKeys.userModel).id
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
      height: 1.sw > 600 ? 310 : 280,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: colorConst
                      .map(
                        (e) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: e,
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
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
                child: Container(
                  width: 35.w, // Increased size to match the image
                  height: 35.w,
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
                  '${product.productVariants.firstWhere((e) => e.price != 0).price} ${lang(context).le}',
                  style: AppStylesManager.customTextStyleO3
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                // Text(
                //   ' L.E',
                //   style: AppStylesManager.customTextStyleO2
                //       .copyWith(fontWeight: FontWeight.w500),
                // ),
                const Spacer(),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      (product.productVariants.first.price *
                              (product.productVariants.first.discountRate /
                                  100))
                          .toString(),
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
                    // gradient: const LinearGradient(
                    //   begin: Alignment(1.00, -0.10),
                    //   end: Alignment(-1, 0.1),
                    //   colors: ColorManager.gradientColors,
                    // ),
                    color: Color.fromARGB(255, 233, 242, 245),
                    borderRadius: BorderRadius.circular(12)),
                child: IconButton(
                  icon: Icon(
                    Iconsax.shopping_cart,
                    color: ColorManager.primaryB,
                    size: 14.r,
                  ),
                  onPressed: () {},
                ),
              ),
              GradientButtonBuilder(
                text: lang(context).buy,
                ontap: () {},
                width: 110.h,
                height: 30.h,
              )
            ],
          )
        ],
      ),
    ),
  );
}
