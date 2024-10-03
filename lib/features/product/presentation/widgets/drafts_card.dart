import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/features/product/domain/models/product_data/draft_product_model.dart';
import 'package:nilelon/features/product/presentation/pages/product_preivew_darft_page.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/utils/navigation.dart';

class DraftsCard extends StatelessWidget {
  const DraftsCard({
    super.key,
    required this.draft,
    required this.onTap,
    required this.indexSelection,
  });
  final DraftProductModel draft;
  final int indexSelection;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0.sp),
      child: GestureDetector(
        onTap: () {
          navigateAndReplace(
            context: context,
            screen: PreviewDraftProductPage(
              product: draft,
            ),
          );
        },
        child: Container(
          height: 1.sw > 600 ? 180 : 140,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: ColorManager.primaryW,
              boxShadow: const [
                BoxShadow(
                  color: ColorManager.primaryG6,
                  blurRadius: 10,
                  offset: Offset(0, 2),
                  spreadRadius: 0,
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  width: screenWidth(context, 0.25),
                  height: 120.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                        image: AssetImage('assets/images/non image.png'),
                        fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                SizedBox(
                  width: screenWidth(context, 0.48),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Black T-shirt',
                        style: AppStylesManager.customTextStyleBl5,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'T-shirt',
                        style: AppStylesManager.customTextStyleG18,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Lorem ipsum dolor sit amet consectetur. Lorem aenean eget ',
                        style: AppStylesManager.customTextStyleG19,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    padding: EdgeInsets.all(4.sp),
                    decoration: BoxDecoration(
                        color: ColorManager.primaryO,
                        borderRadius: BorderRadius.circular(20)),
                    child: Icon(
                      Iconsax.trash,
                      color: ColorManager.primaryW,
                      size: 18.r,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
