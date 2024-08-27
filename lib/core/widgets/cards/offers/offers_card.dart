import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/button/button_builder.dart';
import 'package:nilelon/features/product/presentation/pages/product_details_view.dart';

GestureDetector offersCard({required context}) {
  List<String> images = ['assets/images/saveToCloset.png'];
  String name = 'T-Shirt';
  String storeName = 'By Nagham';
  String rating = '4.8';
  String price = '370.90';
  String priceDisc = '400.90';
  String discount = '20';
  return GestureDetector(
    onTap: () {
      // navigateTo(
      //     context: context,
      //     screen: ProductDetailsView(
      //       images: images,
      //       name: name,
      //       storeName: storeName,
      //       rating: rating,
      //       price: price,
      //       status: 'Out of Stock',
      //       reviews: const [],
      //     ));
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
      height: 1.sw > 600 ? 310 : 245,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
              '$discount%',
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
                        image: AssetImage(images[0]), fit: BoxFit.fill)),
              ),
              Positioned(
                  top: 5,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/closet_following.png'),
                            fit: BoxFit.fill)),
                  ))
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            name,
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
                  price,
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
                      priceDisc,
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
