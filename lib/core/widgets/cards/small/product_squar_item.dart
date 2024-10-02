import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/features/auth/domain/model/user_model.dart';
import 'package:nilelon/features/cart/domain/model/add_cart_request_model.dart';
import 'package:nilelon/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:nilelon/features/product/domain/models/product_model.dart';

import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/pop_ups/add_to_closet_popup.dart';
import 'package:nilelon/core/widgets/price_and_rating_row/price_and_rating_row.dart';
import 'package:nilelon/features/product/presentation/pages/product_details_view.dart';

import '../../../color_const.dart';
import '../../../resources/color_manager.dart';
import '../../button/button_builder.dart';

GestureDetector productSquarItem({
  required context,
  required ProductModel model,
}) {
  return GestureDetector(
    onTap: () {
      navigateTo(
        context: context,
        screen: ProductDetailsView(
          productId: model.id,
        ),
      );
    },
    child: Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(10), // Updated to match rounded corners
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: ColorManager.primaryO3,
            blurRadius: 0, // Increased blur radius for a softer shadow
            offset: Offset(
                -7, 7), // Adjusted offset to match the shadow in the image
            spreadRadius: 0,
          )
        ],
      ),
      width: 1.sw > 600 ? 270 : 200,
      height: 1.sw > 600
          ? 300
          : 280, // Adjusted height to match the aspect ratio in the image
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
          Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                height: 150.h, // Adjusted to fit the design
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(0)), // Added to match the image
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
                      image: model.isInCloset
                          ? const DecorationImage(
                              image: AssetImage(
                                'assets/images/closet_following.png',
                              ),
                              fit: BoxFit.contain, // Changed to contain
                            )
                          : const DecorationImage(
                              image: AssetImage(
                                'assets/images/hanger.png',
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
              style: AppStylesManager.customTextStyleG3,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 30.h,
                width: 30.h,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment(1.00, -0.10),
                      end: Alignment(-1, 0.1),
                      colors: ColorManager.gradientColors,
                    ),
                    color: ColorManager.primaryW,
                    borderRadius: BorderRadius.circular(12)),
                child: BlocConsumer<CartCubit, CartState>(
                  listener: (context, state) {
                    if (state is CartSuccess) {
                      BotToast.showText(text: 'Product Added to cart');
                    }
                  },
                  builder: (context, state) {
                    return state is CartLoading
                        ? const CircularProgressIndicator()
                        : IconButton(
                            icon: Icon(
                              Iconsax.shopping_cart,
                              color: ColorManager.primaryW,
                              size: 14.r,
                            ),
                            onPressed: () {
                              CartCubit.get(context).addToCart(
                                AddToCartModel(
                                  quantity: 1,
                                  size: model.productVariants.first.size,
                                  color: model.productVariants.first.color,
                                  productId: model.id,
                                  customerId: HiveStorage.get<UserModel>(
                                          HiveKeys.userModel)
                                      .id,
                                ),
                              );
                            },
                          );
                  },
                ),
              ),
              ButtonBuilder(
                text: 'Buy',
                ontap: () {},
                width: 110.h,
                height: 30.h,
              )
            ],
          )
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
            offset: const Offset(
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
                  borderRadius: const BorderRadius.vertical(
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
