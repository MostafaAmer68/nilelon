import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';

import '../../color_const.dart';

Future successCreationDialog(
    {required BuildContext context,
    required String highlightedText,
    required String regularText,
    required String buttonText,
    required void Function() ontap,
    bool? isDismissible}) {
  return showModalBottomSheet(
    isDismissible: isDismissible ?? true,
    enableDrag: isDismissible ?? true,
    context: context,
    builder: (BuildContext context) {
      return Container(
        // height: 800.h,
        width: screenWidth(context, 1),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: colorConst
                        .map(
                          (e) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 1),
                            width: 10.w,
                            height: 10.w,
                            decoration: BoxDecoration(
                              color: e,
                              shape: BoxShape.circle,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(height: 10),
                Image.asset(
                  'assets/images/success_creation.png',
                  width: 300.w,
                ),
                SizedBox(height: 10.h),
                Text(
                  highlightedText,
                  style: AppStylesManager.customTextStyleBl4,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.h),
                Text(
                  regularText,
                  style: AppStylesManager.customTextStyleG4,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.h),
                GradientButtonBuilder(
                  text: buttonText,
                  ontap: ontap,
                  height: 60.h,
                  style: AppStylesManager.customTextStyleW,
                  width: screenWidth(context, 1),
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      );
    },
  );
}
