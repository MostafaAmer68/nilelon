import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/button/button_builder.dart';

Future deleteAlert(
  context,
  String text,
  void Function() ontap,
) {
  final lang = S.of(context);

  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 90.h,
            child: Column(
              children: [
                SizedBox(
                  height: 24.h,
                ),
                Text(
                  text,
                  style: AppStylesManager.customTextStyleBl8,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonBuilder(
                    text: lang.no,
                    width: screenWidth(context, 0.32),
                    height: screenHeight(context, 0.06),
                    buttonColor: Colors.transparent,
                    frameColor: ColorManager.primaryB2,
                    style: AppStylesManager.customTextStyleB4,
                    ontap: () {
                      navigatePop(context: context);
                    }),
                SizedBox(
                  width: 12.w,
                ),
                ButtonBuilder(
                  text: lang.yes,
                  buttonColor: ColorManager.primaryR,
                  frameColor: ColorManager.primaryR,
                  width: screenWidth(context, 0.32),
                  height: screenHeight(context, 0.06),
                  ontap: ontap,
                ),
              ],
            ),
          ],
        );
      });
}
