import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/core/service/background_service.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/button/button_builder.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/features/shared/welcomePage/welcome_page.dart';

import '../../resources/color_manager.dart';
import '../divider/default_divider.dart';
import '../donts_widget.dart';

Future logoutAlert(context) => showDialog(
    context: context,
    builder: (BuildContext context) {
      final lang = S.of(context);

      return AlertDialog(
        shadowColor: ColorManager.primaryO,
        elevation: 5,
        backgroundColor: ColorManager.primaryW,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                  width: screenWidth(context, 0.30),
                  height: screenHeight(context, 0.06),
                  ontap: () {
                    navigatePop(context: context);
                  }),
              SizedBox(
                width: 5.w,
              ),
              GradientButtonBuilder(
                text: lang.yes,
                width: screenWidth(context, 0.30),
                height: screenHeight(context, 0.06),
                ontap: () {
                  service.invoke('stop');
                  HiveStorage.clear();
                  const FlutterSecureStorage().deleteAll();
                  HiveStorage.set(HiveKeys.skipOnboarding, true);
                  navigateAndRemoveUntil(
                      context: context, screen: const ShopOrSellView());
                },
              ),
            ],
          ),
        ],
      );
    });
