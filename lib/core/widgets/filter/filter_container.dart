import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';

filterContainer(String name, bool isSelected) {
  return isSelected
      ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Center(
            child: Stack(
              children: [
                // Shadow Container
                Container(
                  width: 145,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  margin:
                      const EdgeInsets.only(left: 10, top: 10), // Shadow offset
                ),
                // Main Container
                Container(
                  width: 150,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    // border: Border.all(color: Colors.cyanAccent, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      name,
                      style: AppStylesManager.customTextStyleB3.copyWith(
                          fontSize: 1.sw > 600 ? 20 : 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Center(
            child: Stack(
              children: [
                // Shadow Container
                Container(
                  width: 145,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.orange.withAlpha(98),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  margin:
                      const EdgeInsets.only(left: 10, top: 10), // Shadow offset
                ),
                // Main Container
                Container(
                  width: 150,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    // border: Border.all(color: Colors.cyanAccent, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      name,
                      style: AppStylesManager.customTextStyleB3.copyWith(
                          fontSize: 1.sw > 600 ? 20 : 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
}
