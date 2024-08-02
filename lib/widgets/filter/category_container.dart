import 'package:flutter/material.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/resources/const_functions.dart';
import 'package:nilelon/resources/appstyles_manager.dart';

Container categoryContainer({
  required BuildContext context,
  required String image,
  required String name,
  required bool isSelected,
}) {
  return isSelected
      ? Container(
          decoration: BoxDecoration(
              color: ColorManager.primaryB5,
              borderRadius: BorderRadius.circular(16)),
          width: screenWidth(context, 0.22),
          height: screenWidth(context, 0.22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: screenWidth(context, 0.22),
                height: screenWidth(context, 0.22),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  // color: AppStyles.primaryB5,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset(image),
              ),
              Text(
                name,
                style: AppStylesManager.customTextStyleBl3,
              )
            ],
          ),
        )
      : Container(
          decoration: BoxDecoration(
              color: ColorManager.primaryW,
              borderRadius: BorderRadius.circular(16)),
          width: screenWidth(context, 0.20),
          height: screenWidth(context, 0.20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: screenWidth(context, 0.20),
                height: screenWidth(context, 0.20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  // color: AppStyles.primaryB5,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset(image),
              ),
              Text(
                name,
                style: AppStylesManager.customTextStyleBl3,
              )
            ],
          ),
        );
}
