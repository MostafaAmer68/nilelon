import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/features/product/domain/models/product_model.dart';

import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/pop_ups/add_to_closet_popup.dart';
import 'package:nilelon/core/widgets/price_and_rating_row/price_and_rating_row.dart';
import 'package:nilelon/features/product/presentation/pages/product_details_view.dart';

import '../../../color_const.dart';
import '../../../resources/color_manager.dart';

GestureDetector productSquarItem({
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
        borderRadius:
            BorderRadius.circular(15), // Updated to match rounded corners
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: ColorManager.primaryO,
            blurRadius: 0, // Increased blur radius for a softer shadow
            offset: Offset(
                0, 10), // Adjusted offset to match the shadow in the image
            spreadRadius: 0,
          )
        ],
      ),
      width: 1.sw > 600 ? 270 : 200,
      height: 1.sw > 600
          ? 300
          : 230, // Adjusted height to match the aspect ratio in the image
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                height: 150.h, // Adjusted to fit the design
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(15)), // Added to match the image
                  image: DecorationImage(
                    image: model.productImages.isEmpty
                        ? const AssetImage(
                            'assets/images/1-Nilelon f logo d.png')
                        : NetworkImage(model.productImages[0].url)
                            as ImageProvider,
                    fit: BoxFit
                        .cover, // Changed to cover to maintain aspect ratio
                  ),
                ),
              ),
              Positioned(
                top: 10.h,
                right: 10.w, // Added right positioning
                child: InkWell(
                  onTap: () {
                    addToClosetDialog(context, model.id);
                  },
                  child: Container(
                    width: 35.w, // Increased size to match the image
                    height: 35.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.shade300.withOpacity(1),
                          offset: const Offset(
                              3, 3), // Adjusted shadow to be more subtle
                          blurRadius: 5,
                        ),
                      ],
                      image: const DecorationImage(
                        image: AssetImage(
                          'assets/images/closet_following.png',
                        ),
                        fit: BoxFit.contain, // Changed to contain
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 8.0), // Added padding to match image layout
            child: PriceAndRatingRow(
                price: '${model.productVariants[0].price} L.E',
                rating: model.rating.toString()),
          ),
          const SizedBox(
            height: 4,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 8.0), // Added padding to match image layout
            child: Text(
              model.name,
              style: AppStylesManager.customTextStyleG5,
            ),
          ),
        ],
      ),
    ),
  );
}

GestureDetector smallCard({required context, required}) {
  List<String> images = ['assets/images/saveToCloset.png'];
  String name = 'T-Shirt';
  String rating = '4.8';
  String price = '333.90';
  return GestureDetector(
    onTap: () {},
    child: Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(15), // Updated to match rounded corners
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.orange.shade300.withOpacity(1),
            blurRadius: 20, // Increased blur radius for a softer shadow
            offset: Offset(
                0, 10), // Adjusted offset to match the shadow in the image
            spreadRadius: 0,
          ),
        ],
      ),
      width: 1.sw > 600 ? 270 : 200,
      height: 1.sw > 600
          ? 300
          : 300, // Adjusted height to match the aspect ratio in the image
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                height: 150.h, // Adjusted to fit the design
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(15)), // Added to match the image
                  image: DecorationImage(
                    image: AssetImage(images[0]),
                    fit: BoxFit
                        .cover, // Changed to cover to maintain aspect ratio
                  ),
                ),
              ),
              Positioned(
                top: 10.h,
                right: 10.w, // Added right positioning
                child: Container(
                  width: 35.w, // Increased size to match the image
                  height: 35.w,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange,
                        offset:
                            Offset(3, 3), // Adjusted shadow to be more subtle
                        blurRadius: 5,
                      ),
                    ],
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/closet_following.png',
                      ),
                      fit: BoxFit.contain, // Changed to contain
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 8.0), // Added padding to match image layout
            child: PriceAndRatingRow(price: '$price L.E', rating: rating),
          ),
          const SizedBox(
            height: 4,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 8.0), // Added padding to match image layout
            child: Text(
              name,
              style: AppStylesManager.customTextStyleG5,
            ),
          ),
        ],
      ),
    ),
  );
}
