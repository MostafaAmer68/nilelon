import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/tools.dart';
import 'package:nilelon/core/widgets/button/button_builder.dart';
import 'package:nilelon/core/widgets/price_and_rating_row/price_and_rating_row.dart';
import 'package:nilelon/core/widgets/replacer/image_replacer.dart';
import 'package:svg_flutter/svg.dart';

import '../../../../features/closet/presentation/view/closet_sheet_bar_view.dart';
import '../../../../features/product/domain/models/product_model.dart';
import '../../../constants/assets.dart';
import '../../../data/hive_stroage.dart';

GestureDetector wideCard({required ProductModel product, required context}) {
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
            height: 1.sw > 600 ? 250 : 195,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: ColorManager.gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: ColorManager.primaryO10,
                  blurRadius: 0,
                  offset: Offset(6, 6),
                  spreadRadius: 0,
                )
              ],
            ),
          ),
          Positioned.fill(
            child: Container(
              clipBehavior: Clip.antiAlias,
              height: 1.sw > 600 ? 250 : 195,
              margin: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: const Color(0xFFF7FDFF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: imageReplacer(
                      url: product.productImages.first.url,
                      width: 140,
                      height: 140,
                      radius: 16,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                product.name,
                                style: AppStylesManager.customTextStyleO3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Visibility(
                                visible: !HiveStorage.get(HiveKeys.isStore),
                                child: InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      backgroundColor: ColorManager.primaryW,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30),
                                        ),
                                      ),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      builder: (context) => ClosetSheetBarView(
                                          productId: product.id),
                                    );
                                  },
                                  child: !product.isInCloset
                                      ? Container(
                                          width: 30.w,
                                          height: 30.w,
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.orange.shade300
                                                    .withOpacity(1),
                                                offset: const Offset(3, 3),
                                                blurRadius: 5,
                                              ),
                                            ],
                                          ),
                                          child: SvgPicture.asset(
                                            Assets.assetsImagesHanger,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Image.asset(
                                          Assets.assetsImagesClosetFollowing,
                                          fit: BoxFit.cover,
                                          width: 40,
                                        ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            '${product.productVariants.first.price} ${lang(context).le}',
                            style: AppStylesManager.customTextStyleBl2,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            children: [
                              Text(
                                product.storeName,
                                style: AppStylesManager.customTextStyleB4,
                              ),
                              Icon(
                                Icons.star,
                                color: ColorManager.primaryO2,
                                size: 20.r,
                              ),
                              Text(
                                product.rating.toString(),
                                style: AppStylesManager.customTextStyleG,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 40.h,
                                width: screenWidth(context, 0.12),
                                decoration: BoxDecoration(
                                  color: ColorManager.primaryG8,
                                  borderRadius: BorderRadius.circular(7),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: ColorManager.primaryO,
                                      blurRadius: 0,
                                      offset: Offset(4, 4),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Iconsax.shopping_cart,
                                    color: ColorManager.primaryB2,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                              const SizedBox(width: 10),
                              ButtonBuilder(
                                text: lang(context).buy,
                                ontap: () {},
                                frameColor: ColorManager.gradientBoxColors[1],
                                width: screenWidth(context, 0.30),
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
