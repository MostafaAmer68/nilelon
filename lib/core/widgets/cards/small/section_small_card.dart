import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/features/closet/presentation/cubit/closet_cubit.dart';
import 'package:nilelon/features/product/domain/models/product_model.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/widgets/price_and_rating_row/price_and_rating_row.dart';

GestureDetector sectionSmallCard(
    {required context,
    required ProductModel product,
    required String closetId}) {
  return GestureDetector(
    onTap: () {
      // navigateTo(
      //     context: context,
      //     screen: ProductDetailsView(
      //       // images: images,
      //       // name: name,
      //       // storeName: storeName,
      //       // rating: rating,
      //       // price: price,
      //       // status: 'Out of Stock',
      //       // reviews: const [],
      //     ));
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
                    image: NetworkImage(product.productImages[0].url),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                  top: 5,
                  right: 5,
                  child: InkWell(
                    onTap: () {
                      ClosetCubit.get(context)
                          .deletFromCloset(closetId, product.id);
                    },
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
                    ),
                  ))
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          PriceAndRatingRow(
              price: '${product.productVariants[0].price} L.E',
              rating: product.rating.toString()),
          const SizedBox(
            height: 4,
          ),
          Text(
            product.name.toString(),
            style: AppStylesManager.customTextStyleG5,
          ),
        ],
      ),
    ),
  );
}
