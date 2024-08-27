import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';

Padding filterContainer(String name, bool isSelected) {
  return isSelected
      ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Container(
            // height: 20,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: ColorManager.primaryB2,
                border: Border.all(color: ColorManager.primaryB2)),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
              ),
              child: Center(
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: AppStylesManager.customTextStyleW4,
                ),
              ),
            ),
          ),
        )
      : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Container(
            // height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: ColorManager.primaryB2)),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
              ),
              child: Center(
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: AppStylesManager.customTextStyleB3.copyWith(
                      fontSize: 1.sw > 600 ? 20 : 12,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        );
}
