import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/core/helper.dart';
import 'package:nilelon/features/product/domain/models/product_data/draft_product_model.dart';
import 'package:nilelon/features/product/presentation/pages/product_add_page.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/utils/navigation.dart';

class DraftsCard extends StatefulWidget {
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
  State<DraftsCard> createState() => _DraftsCardState();
}

class _DraftsCardState extends State<DraftsCard> {
  File image = File('');
  decodeImage() async {
    image = await convertBase64ToImage(
        widget.draft.product.variants.first.images.first);
    setState(() {});
  }

  @override
  void initState() {
    decodeImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0.sp),
      child: GestureDetector(
        onTap: () {
          navigateTo(
            context: context,
            screen: AddProductView(
              categoryId: widget.draft.product.categoryID,
              draft: widget.draft,
            ),
          );
        },
        child: Container(
          height: 1.sw > 600 ? 130 : 110,
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
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                SizedBox(
                  width: screenWidth(context, 0.25),
                  height: 140.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      image,
                      fit: BoxFit.cover,
                    ),
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
                        widget.draft.product.name,
                        style: AppStylesManager.customTextStyleBl5,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        HiveStorage.get<List>(HiveKeys.categories)
                            .firstWhere(
                                (e) => e.id == widget.draft.product.categoryID)
                            .name,
                        style: AppStylesManager.customTextStyleG18,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        widget.draft.product.description,
                        style: AppStylesManager.customTextStyleG19,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: widget.onTap,
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
