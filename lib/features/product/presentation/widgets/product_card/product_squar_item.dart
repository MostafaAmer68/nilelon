import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/features/product/domain/models/product_model.dart';

import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/price_and_rating_row/price_and_rating_row.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_cubit.dart';
import 'package:nilelon/features/product/presentation/pages/product_details_page.dart';
import 'package:nilelon/features/promo/presentation/cubit/promo_cubit.dart';
import 'package:svg_flutter/svg.dart';

import '../../../../../core/constants/assets.dart';
import '../../../../auth/domain/model/user_model.dart';
import '../../../../closet/presentation/view/closet_sheet_bar_view.dart';
import '../../../../refund/presentation/widgets/custom_check_box.dart';
import '../../pages/product_details_store_page.dart';
import '../../../../../core/color_const.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/tools.dart';
import '../../../../../core/widgets/replacer/image_replacer.dart';

GestureDetector productSquarItem(
    {required context,
    required ProductModel product,
    bool isSelectable = false,
    bool isSelected = false,
    Function(bool value)? onTap}) {
  final price = product.productVariants
      .firstWhere(
        (e) => e.price != 0,
        orElse: () => product.productVariants.first,
      )
      .price;
  final PromoCubit cubit = PromoCubit.get(context);
  final ProductsCubit pcubit = ProductsCubit.get(context);
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
        borderRadius:
            BorderRadius.circular(4), // Updated to match rounded corners
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
      width: 1.sw > 600
          ? 270
          : 1.sw < 400
              ? 155
              : 200,
      // height: 1.sw > 600 ? 300 : 220,
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
              imageSection(product),
              Positioned(
                top: 10.h,
                right: 10.w,
                child: isSelectable
                    ? GradientCheckBox(
                        value: cubit.selectedProducts.contains(product),
                        onChanged: onTap!,
                      )
                    : Visibility(
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
                              builder: (context) =>
                                  ClosetSheetBarView(productId: product.id),
                            );
                          },
                          child: !product.isInCloset
                              ? Container(
                                  width: 35.w,
                                  height: 35.w,
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
                              : SvgPicture.asset(
                                  Assets.assetsImagesClosetFollowing,
                                  fit: BoxFit.cover,
                                  width: 50,
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

Container imageSection(ProductModel product) {
  return Container(
    height: 150.h, // Adjusted to fit the design
    width: double.infinity,
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(0),
      ),
    ),
    child: imageReplacer(
        url: product.productImages.isEmpty
            ? ''
            : product.productImages.first.url),
  );
}
