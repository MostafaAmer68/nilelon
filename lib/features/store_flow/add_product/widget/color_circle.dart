import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/features/store_flow/add_product/widget/color_circle_checked_item.dart';
import 'package:nilelon/features/store_flow/add_product/widget/color_circle_item.dart';
import 'package:nilelon/resources/color_manager.dart';

GestureDetector colorCircle(void Function() onTap, int color,
    int? selectedIndex, int index, bool isEditable) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.only(right: 14),
      child: isEditable && (selectedIndex == null || selectedIndex != index)
          ? colorCircleCheckedItem(color)
          : isEditable
              ? Container(
                  width: 40.h,
                  height: 40.h,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(
                      color: ColorManager.primaryO,
                      width: 2,
                    ),
                  ),
                  child: colorCircleCheckedItem(color),
                )
              : selectedIndex == null || selectedIndex != index
                  ? colorCircleItem(color)
                  : Container(
                      width: 40.h,
                      height: 40.h,
                      padding: EdgeInsets.all(2.sp),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(
                          color: ColorManager.primaryO,
                          width: 2,
                        ),
                      ),
                      child: colorCircleItem(color),
                    ),
    ),
  );
}
