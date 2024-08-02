import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/resources/const_functions.dart';
import 'package:nilelon/resources/appstyles_manager.dart';
import 'package:nilelon/utils/navigation.dart';
import 'package:nilelon/widgets/price_and_rating_row/price_and_rating_row.dart';
import 'package:nilelon/features/customer_flow/products_view/product_details/view/product_details_view.dart';

GestureDetector sectionSmallCard({required context}) {
  List<String> images = ['assets/images/saveToCloset.png'];
  String name = 'T-Shirt';
  String storeName = 'By Nagham';
  String rating = '4.8';
  String price = '370.90';
  return GestureDetector(
    onTap: () {
      navigateTo(
          context: context,
          screen: ProductDetailsView(
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
      width: screenWidth(context, 0.4),
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                height: 160,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(images[0]), fit: BoxFit.fill)),
              ),
              Positioned(
                  top: 5,
                  right: 5,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: ColorManager.primaryO),
                    child: const Icon(
                      Iconsax.trash,
                      color: ColorManager.primaryW,
                      size: 18,
                    ),
                  ))
            ],
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
