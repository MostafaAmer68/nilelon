import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/button/button_builder.dart';
import 'package:nilelon/core/widgets/price_and_rating_row/price_and_rating_row.dart';
import 'package:nilelon/features/product/presentation/pages/product_details_view.dart';
import 'package:svg_flutter/svg.dart';

GestureDetector wideCard({required void Function() onTap, required context}) {
  List<String> images = ['assets/images/cloth1.png'];
  String name = 'Cream Hoodie';
  String storeName = 'By Nagham';
  String rating = '4.8';
  String price = '370.90';
  return GestureDetector(
    onTap: () {
      // navigateTo(
      //     context: context,
      //     screen: ProductDetailsView(
      //       product: model,
      //     ));
    },
    child: SizedBox(
      width: screenWidth(context, 0.9),
      child: Stack(
        children: [
          Container(
            height: 1.sw > 600 ? 250 : 160,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: ColorManager.gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: ColorManager.primaryO,
                  blurRadius: 0,
                  offset: Offset(10, 10),
                  spreadRadius: 0,
                )
              ],
            ),
          ),
          Positioned.fill(
            child: Container(
              clipBehavior: Clip.antiAlias,
              height: 1.sw > 600 ? 250 : 160,
              margin: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: const Color(0xFFF7FDFF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: screenWidth(context, 0.34),
                    height: 1.sw > 600 ? 250 : 170,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(images[0]), fit: BoxFit.cover)),
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
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  name,
                                  style: AppStylesManager.customTextStyleBl7,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              GestureDetector(
                                onTap: onTap,
                                child: Container(
                                  width: 20.w,
                                  height: 20.w,
                                  padding: const EdgeInsets.all(4),
                                  decoration: const ShapeDecoration(
                                    shadows: [
                                      BoxShadow(
                                        color: Color(0x47F59022),
                                        blurRadius: 8,
                                        offset: Offset(0, 2),
                                        spreadRadius: 0,
                                      )
                                    ],
                                    color: Colors.white,
                                    shape: OvalBorder(),
                                  ),
                                  child: SvgPicture.asset(
                                      'assets/images/hanger.svg'),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            storeName,
                            style: AppStylesManager.customTextStyleG5,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          PriceAndRatingRow(
                              price: '$price L.E', rating: rating),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 40.h,
                                width: screenWidth(context, 0.12),
                                decoration: BoxDecoration(
                                    color: ColorManager.primaryG8,
                                    borderRadius: BorderRadius.circular(12)),
                                child: IconButton(
                                  icon: const Icon(
                                    Iconsax.shopping_cart,
                                    color: ColorManager.primaryB2,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                              ButtonBuilder(
                                text: 'Buy',
                                ontap: () {},
                                width: screenWidth(context, 0.33),
                                height: 40.h,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
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
