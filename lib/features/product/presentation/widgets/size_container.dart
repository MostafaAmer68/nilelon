import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';

Container sizeContainer(
  BuildContext context,
  String size,
) {
  return Container(
    height: 46.h,
    width: 80.h,
    decoration: BoxDecoration(
      color: ColorManager.primaryW,
      border: Border.all(
        color: ColorManager.primaryB2,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Center(
      child: Text(
        size,
        style: AppStylesManager.customTextStyleB3.copyWith(
          fontSize: 1.sw > 600 ? 24 : 16,
        ),
      ),
    ),
  );
}
