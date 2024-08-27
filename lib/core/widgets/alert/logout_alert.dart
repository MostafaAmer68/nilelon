import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/core/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/button/button_builder.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/features/shared/welcomePage/welcome_page.dart';

Future logoutAlert(context) => showDialog(
    context: context,
    builder: (BuildContext context) {
      final lang = S.of(context);

      return AlertDialog(
        content: SizedBox(
          height: 90.h,
          child: Column(
            children: [
              SizedBox(
                height: 24.h,
              ),
              Text(
                lang.areYouSureYouWantToLogout,
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
              GradientButtonBuilder(
                  text: lang.yes,
                  width: screenWidth(context, 0.32),
                  height: screenHeight(context, 0.06),
                  ontap: () {
                    HiveStorage.clear();
                    HiveStorage.set(HiveKeys.skipOnboarding, true);
                    navigateAndRemoveUntil(
                        context: context, screen: const ShopOrSellView());
                  }),
            ],
          ),
        ],
      );
    });
