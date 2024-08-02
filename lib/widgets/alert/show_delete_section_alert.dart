import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/resources/const_functions.dart';
import 'package:nilelon/resources/appstyles_manager.dart';
import 'package:nilelon/utils/navigation.dart';
import 'package:nilelon/widgets/button/button_builder.dart';
import 'package:nilelon/widgets/button/outlined_button_builder.dart';

Future showDeleteSectionAlert(context) => showDialog(
    context: context,
    builder: (BuildContext context) {
      final lang = S.of(context);

      return AlertDialog(
        content: SizedBox(
          height: 70.h,
          child: Column(
            children: [
              SizedBox(
                height: 16.h,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Are you sure you want to remove\n',
                      style: AppStylesManager.customTextStyleBl8,
                    ),
                    TextSpan(
                      text: 'T-Shirt',
                      style: AppStylesManager.customTextStyleO3,
                    ),
                    TextSpan(
                      text: ' Section ?',
                      style: AppStylesManager.customTextStyleBl8,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButtonBuilder(
                  text: lang.no,
                  width: screenWidth(context, 0.32),
                  height: screenHeight(context, 0.06),
                  ontap: () {
                    navigatePop(context: context);
                  }),
              SizedBox(
                width: 12.w,
              ),
              ButtonBuilder(
                  buttonColor: ColorManager.primaryR,
                  text: lang.yes,
                  width: screenWidth(context, 0.32),
                  height: screenHeight(context, 0.06),
                  ontap: () {
                    navigatePop(context: context);
                  }),
            ],
          ),
        ],
      );
    });
