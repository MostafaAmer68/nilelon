import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:svg_flutter/svg.dart';

GestureDetector signWithContainer(String image,void Function() onTap) {
  return GestureDetector(onTap: onTap,
    child: Container(
      width: 80.sp,
      height: 40.sp,
      padding: EdgeInsets.all(8.sp),
      decoration: BoxDecoration(
          color: ColorManager.primaryW,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ColorManager.primaryG3)),
      child: SvgPicture.asset(image),
    ),
  );
}
