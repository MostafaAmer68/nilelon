import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/features/product/presentation/pages/product_details_view.dart';

GestureDetector marketOffersCard({required context}) {
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
      width: 220.w,
      height: 1.sw > 600 ? 310 : 245,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: screenWidth(context, 0.16),
            height: 35.h,
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
          const SizedBox(
            height: 8,
          ),
          Container(
            width: 200.w,
            height: 130.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                    image: AssetImage(images[0]), fit: BoxFit.fill)),
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
            padding: const EdgeInsets.symmetric(horizontal: 8),
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
        ],
      ),
    ),
  );
}
