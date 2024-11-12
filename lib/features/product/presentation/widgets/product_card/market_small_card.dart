import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/tools.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/price_and_rating_row/price_and_rating_row.dart';
import 'package:nilelon/core/widgets/replacer/image_replacer.dart';
import 'package:nilelon/features/product/domain/models/product_model.dart';
import 'package:nilelon/features/product/presentation/pages/product_details_store_page.dart';

import '../../../../../core/color_const.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../pages/product_details_page.dart';
import '../../../../../core/data/hive_stroage.dart';

GestureDetector marketSmallCard(
    {required context, required ProductModel product}) {
  final price = product.productVariants
      .firstWhere(
        (e) => e.price != 0,
        orElse: () => product.productVariants.first,
      )
      .price;
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
        borderRadius: BorderRadius.circular(4),
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
      width: 1.sw > 600 ? 270 : 200,
      height: 1.sw > 600 ? 300 : 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: colorConst
                  .map(
                    (e) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      width: 10.w,
                      height: 10.w,
                      decoration: BoxDecoration(
                        color: e,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 150.h,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: PriceAndRatingRow(
              price: '$price ${lang(context).le}',
              rating: product.rating.toString(),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              product.name,
              overflow: TextOverflow.ellipsis,
              style: AppStylesManager.customTextStyleG3,
            ),
          ),
        ],
      ),
    ),
  );
}
