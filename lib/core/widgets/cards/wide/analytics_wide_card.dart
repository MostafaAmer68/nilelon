import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/tools.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/price_and_rating_row/price_and_rating_row.dart';
import 'package:nilelon/core/widgets/replacer/image_replacer.dart';
import 'package:nilelon/features/product/presentation/pages/product_details_store_page.dart';
import 'package:nilelon/features/store_flow/analytics/domain/model/analytics_response_model.dart';

GestureDetector analyticsWideCard(
    {required context, required ProductBetSeller product}) {
  return GestureDetector(
    onTap: () {
      navigateTo(
        context: context,
        screen: ProductStoreDetailsView(
          productId: product.productId,
        ),
      );
    },
    child: Expanded(
      child: SizedBox(
        width: screenWidth(context, 0.92),
        // height: 1.sw > 600 ? 100 : 100,
        child: Container(
          // height: 1.sw > 600 ? 100 : 100,
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
          child: Positioned.fill(
            child: Container(
              clipBehavior: Clip.antiAlias,
              height: 1.sw > 600 ? 220 : 145,
              margin: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: const Color(0xFFF7FDFF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: imageReplacer(
                      url: product.productIMages,
                      width: screenWidth(context, 0.31),
                      height: 1.sw > 600 ? 220 : 145,
                      radius: 10,
                    ),
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
                            'product.name',
                            style: AppStylesManager.customTextStyleBl7,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // soldItemsRow(soldItems),
                          const SizedBox(
                            height: 4,
                          ),
                          const Spacer(),
                          PriceAndRatingRow(
                            price: '${product.price} ${lang(context).le}',
                            rating: product.rating.toString(),
                          ),
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
        ),
      ),
    ),
  );
}

Row soldItemsRow(String soldItems) {
  return Row(
    children: [
      Text(
        'Sold Items: ',
        style: AppStylesManager.customTextStyleBl11,
      ),
      Text(
        soldItems,
        style: AppStylesManager.customTextStyleO,
      ),
    ],
  );
}
