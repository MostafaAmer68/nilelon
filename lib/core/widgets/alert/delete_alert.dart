import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/widgets/button/outlined_button_builder.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/donts_widget.dart';
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
          shadowColor: ColorManager.primaryO,
          elevation: 5,
          backgroundColor: ColorManager.primaryW,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          content: SizedBox(
            height: 90.h,
            child: Column(
              children: [
                const DontsWidget(),
                const SizedBox(
                  height: 10,
                ),
                const DefaultDivider(),
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
                Expanded(
                  child: OutlinedButtonBuilder(
                      text: lang.no,
                      height: screenHeight(context, 0.06),
                      buttonColor: Colors.transparent,
                      frameColor: ColorManager.primaryB2,
                      ontap: () {
                        navigatePop(context: context);
                      }),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ButtonBuilder(
                    text: lang.yes,
                    buttonColor: ColorManager.primaryR,
                    height: screenHeight(context, 0.06),
                    ontap: ontap,
                  ),
                ),
              ],
            ),
          ],
        );
      });
}
