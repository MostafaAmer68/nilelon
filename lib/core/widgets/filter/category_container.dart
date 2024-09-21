import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/widgets/replacer/image_replacer.dart';

import '../oval_shape.dart';

categoryContainer({
  required BuildContext context,
  required String image,
  required String name,
  required bool isSelected,
}) {
  return Padding(
    padding:  EdgeInsets.symmetric(horizontal: 20, vertical: 10.h),
    child: CustomPaint(
      painter: CirclePainter(),
      child: isSelected
          ? Container(
              clipBehavior: Clip.none,
              width: 100.h,
              height: 200.h,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.shade300.withOpacity(1),
                    offset: const Offset(10, 10),
                    blurRadius: 0,
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  imageReplacer(
                    url: image, // Use your own image path here
                    height: 50,
                    width: 50,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    name,
                    style: AppStylesManager.customTextStyleBl3,
                  ),
                ],
              ),
            )
          : Container(
              width: 100.h,
              height: 200.h,
              clipBehavior: Clip.none,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.shade300.withOpacity(0.7),
                    offset: const Offset(10, 10),
                    blurRadius: 0,
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  imageReplacer(
                    url: image, // Use your own image path here
                    height: 50,
                    width: 50,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    name,
                    style: AppStylesManager.customTextStyleBl3,
                  ),
                ],
              ),
            ),
    ),
  );
}
