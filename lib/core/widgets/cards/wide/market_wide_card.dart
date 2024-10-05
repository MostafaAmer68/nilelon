import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/price_and_rating_row/price_and_rating_row.dart';
import 'package:nilelon/features/product/presentation/pages/product_details_store_page.dart';

GestureDetector marketWideCard({required context}) {
  List<String> images = ['assets/images/cloth1.png'];
  String name = 'Cream Hoodie';
  String storeName = 'By Nagham';
  String rating = '4.8';
  String price = '370.90';
  return GestureDetector(
    onTap: () {
      navigateTo(
          context: context,
          screen: ProductStoreDetailsView(
            productId: '',
          ));
    },
    child: SizedBox(
      width: screenWidth(context, 0.9),
      child: Stack(
        children: [
          Container(
            height: 1.sw > 600 ? 200 : 125,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: ColorManager.gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: ColorManager.primaryG6,
                  blurRadius: 10,
                  offset: Offset(0, 2),
                  spreadRadius: 0,
                )
              ],
            ),
          ),
          Positioned.fill(
            child: Container(
              clipBehavior: Clip.antiAlias,
              height: 1.sw > 600 ? 200 : 125,
              margin: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: const Color(0xFFF7FDFF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: screenWidth(context, 0.31),
                    height: 1.sw > 600 ? 220 : 150,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(images[0]), fit: BoxFit.fill)),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: AppStylesManager.customTextStyleBl7,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            storeName,
                            style: AppStylesManager.customTextStyleG5,
                          ),
                          const Spacer(),
                          PriceAndRatingRow(
                              price: '$price L.E', rating: rating),
                          const SizedBox(
                            height: 4,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
