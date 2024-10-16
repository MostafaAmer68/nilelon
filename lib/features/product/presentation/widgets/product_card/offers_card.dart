import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/widgets/button/button_builder.dart';
import 'package:nilelon/features/product/domain/models/product_model.dart';

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
        borderRadius: BorderRadius.circular(12),
        color: ColorManager.primaryW,
        boxShadow: const [
          BoxShadow(
            color: Color(0x263D4665),
            blurRadius: 16,
            offset: Offset(0, 1),
            spreadRadius: 0,
          )
        ],
      ),
      width: screenWidth(context, 0.42),
      height: 1.sw > 600 ? 310 : 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: screenWidth(context, 0.16),
            height: 30.h,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(14),
                    bottomRight: Radius.circular(14)),
                color: ColorManager.primaryO),
            child: Center(
                child: Text(
              '${product.productVariants.first.discountRate}%',
              style: AppStylesManager.customTextStyleW4,
            )),
          ),
          SizedBox(
            height: 8.h,
          ),
          Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                width: screenWidth(context, 0.38),
                height: 130.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                        image: NetworkImage(product.productImages[0].url),
                        fit: BoxFit.fill)),
              ),
              Positioned(
                  top: 5,
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
                        image: product.isInCloset
                            ? const DecorationImage(
                                image: AssetImage(
                                  'assets/images/closet_following.png',
                                ),
                                fit: BoxFit.cover, // Changed to contain
                              )
                            : const DecorationImage(
                                image: AssetImage(
                                  'assets/images/hanger.png',
                                ),
                                fit: BoxFit.cover, // Changed to contain
                              )),
                  ))
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            product.name,
              overflow: TextOverflow.ellipsis,
            style: AppStylesManager.customTextStyleBl9,
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
                Text(
                  ' L.E',
                  style: AppStylesManager.customTextStyleO2
                      .copyWith(fontWeight: FontWeight.w500),
                ),
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
                    gradient: const LinearGradient(
                      begin: Alignment(1.00, -0.10),
                      end: Alignment(-1, 0.1),
                      colors: ColorManager.gradientColors,
                    ),
                    color: ColorManager.primaryW,
                    borderRadius: BorderRadius.circular(12)),
                child: IconButton(
                  icon: Icon(
                    Iconsax.shopping_cart,
                    color: ColorManager.primaryW,
                    size: 14.r,
                  ),
                  onPressed: () {},
                ),
              ),
              ButtonBuilder(
                text: 'Buy',
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
