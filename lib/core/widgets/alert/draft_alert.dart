import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/button/button_builder.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';

Future draftAlert(context, void Function() ontap) => showDialog(
    context: context,
    builder: (BuildContext context) {
      final lang = S.of(context);

      return AlertDialog(
        content: SizedBox(
          height: 145.h,
          child: Column(
            children: [
              SizedBox(
                height: 24.h,
              ),
              Text(
                lang.areYouSureYouWantToAddThisProductToYourDrafts,
                style: AppStylesManager.customTextStyleBl8,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 12.h,
              ),
              Text(
                lang.ifYouLogoutOrUnistallTheAppAllYourDraftsWillBeGone,
                style: AppStylesManager.customTextStyleG8,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 12.h,
              ),
              Text(
                lang.youCanFindYourDraftsInAddProductPage,
                style: AppStylesManager.customTextStyleG14,
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
              GradientButtonBuilder(
                  text: lang.yes,
                  width: screenWidth(context, 0.32),
                  height: screenHeight(context, 0.06),
                  ontap: ontap),
            ],
          ),
        ],
      );
    });
