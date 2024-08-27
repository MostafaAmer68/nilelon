import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/features/product/presentation/widgets/color_circle_checked_item.dart';
import 'package:nilelon/features/product/presentation/widgets/color_circle_item.dart';
import 'package:nilelon/core/resources/color_manager.dart';

GestureDetector colorCircle(void Function() onTap, String color,
    int? selectedIndex, int index, bool isEditable) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.only(right: 14),
      child: isEditable && (selectedIndex == null || selectedIndex != index)
          ? colorCircleCheckedItem(int.parse(color))
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
                  child: colorCircleCheckedItem(int.parse(color)),
                )
              : selectedIndex == null || selectedIndex != index
                  ? colorCircleItem(int.parse(color))
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
                      child: colorCircleItem(int.parse(color)),
                    ),
    ),
  );
}
