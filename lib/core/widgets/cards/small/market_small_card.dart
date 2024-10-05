import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/price_and_rating_row/price_and_rating_row.dart';
import 'package:nilelon/core/widgets/replacer/image_replacer.dart';
import 'package:nilelon/features/product/domain/models/product_model.dart';
import 'package:nilelon/features/product/presentation/pages/product_details_store_page.dart';

GestureDetector marketSmallCard(
    {required context, required ProductModel product}) {
  return GestureDetector(
    onTap: () {
      navigateTo(
          context: context,
          screen: ProductStoreDetailsView(
            productId: product.id,
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
          SizedBox(
            height: 150.h,
            // decoration: BoxDecoration(
            //     image: DecorationImage(
            //         image: ,
            //         fit: BoxFit.fill)),
            child: imageReplacer(
              url: product.productImages.first.url,
              fit: BoxFit.fill,
              width: 1.sw > 600 ? 270 : 200,
              height: 1.sw > 600 ? 300 : 220,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          PriceAndRatingRow(
              price: '${product.productVariants.first.price} L.E',
              rating: product.rating.toString()),
          const SizedBox(
            height: 4,
          ),
          Text(
            product.name,
            style: AppStylesManager.customTextStyleG5,
          ),
        ],
      ),
    ),
  );
}
