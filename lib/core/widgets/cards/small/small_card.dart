import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/features/product/domain/models/product_model.dart';

import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/pop_ups/add_to_closet_popup.dart';
import 'package:nilelon/core/widgets/price_and_rating_row/price_and_rating_row.dart';
import 'package:nilelon/features/product/presentation/pages/product_details_view.dart';

import '../../../resources/color_manager.dart';

GestureDetector smallCardC({
  required context,
  required ProductModel model,
}) {
  return GestureDetector(
    onTap: () {
      navigateTo(
        context: context,
        screen: ProductDetailsView(
          product: model,
        ),
      );
    },
    child: Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: ColorManager.primaryO,
            blurRadius: 0,
            offset: Offset(7, 7),
            spreadRadius: 0,
          )
        ],
      ),
      width: 1.sw > 600 ? 270 : 200,
      height: 1.sw > 600 ? 300 : 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                height: 150.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: model.productImages.isEmpty
                        ? const AssetImage(
                            'assets/images/1-Nilelon f logo d.png')
                        : NetworkImage(model.productImages[0].url),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                  top: 10.h,
                  child: InkWell(
                    onTap: () {
                      addToClosetDialog(context, model.id);
                    },
                    child: Container(
                      width: 24.w,
                      height: 24.w,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/closet_following.png'),
                            fit: BoxFit.fill),
                      ),
                    ),
                  ))
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          PriceAndRatingRow(
              price: '${model.productVariants[0].price} L.E',
              rating: model.rating.toString()),
          const SizedBox(
            height: 4,
          ),
          Text(
            model.name,
            style: AppStylesManager.customTextStyleG5,
          ),
        ],
      ),
    ),
  );
}

GestureDetector smallCard({required context, required}) {
  List<String> images = ['assets/images/saveToCloset.png'];
  String name = 'T-Shirt';
  String storeName = 'By Nagham';
  String rating = '4.8';
  String price = '370.90';
  return GestureDetector(
    onTap: () {},
    child: Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      width: 1.sw > 600 ? 270 : 200,
      height: 1.sw > 600 ? 300 : 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                height: 150.h,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(images[0]), fit: BoxFit.fill)),
              ),
              Positioned(
                  top: 10.h,
                  child: Container(
                    width: 24.w,
                    height: 24.w,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/closet_following.png'),
                            fit: BoxFit.fill)),
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
