import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/resources/appstyles_manager.dart';
import 'package:nilelon/utils/navigation.dart';
import 'package:nilelon/widgets/price_and_rating_row/price_and_rating_row.dart';
import 'package:nilelon/features/store_flow/product_details/view/store_product_details_view.dart';

GestureDetector marketSmallCard({required context}) {
  List<String> images = ['assets/images/saveToCloset.png'];
  String name = 'T-Shirt';
  String storeName = 'By Nagham';
  String rating = '4.8';
  String price = '370.90';
  return GestureDetector(
    onTap: () {
      navigateTo(
          context: context,
          screen: StoreProductDetailsView(
            images: images,
            name: name,
            storeName: storeName,
            rating: rating,
            price: price,
            status: 'Out of Stock',
            reviews: const [],
          ));
    },
    child: Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      width: 1.sw > 600 ? 270 : 200,
      height: 1.sw > 600 ? 300 : 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150.h,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(images[0]), fit: BoxFit.fill)),
          ),
          const SizedBox(
            height: 8,
          ),
          PriceAndRatingRow(price: '$price L.E', rating: rating),
          const SizedBox(
            height: 4,
          ),
          Text(
            name,
            style: AppStylesManager.customTextStyleG5,
          ),
        ],
      ),
    ),
  );
}
