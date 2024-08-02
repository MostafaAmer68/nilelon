import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/data/hive_stroage.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/resources/const_functions.dart';
import 'package:nilelon/resources/appstyles_manager.dart';
import 'package:nilelon/utils/navigation.dart';
import 'package:nilelon/widgets/button/button_builder.dart';
import 'package:nilelon/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/features/customer_flow/layout/customer_bottom_tab_bar.dart';

class RecommendationProfileView extends StatelessWidget {
  const RecommendationProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Scaffold(
      backgroundColor: ColorManager.primaryW,
      appBar: customAppBar(
          title: lang.recommendations, context: context, hasIcon: false),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                imageContainer(
                  context,
                  'assets/images/shop_for_women.png',
                  'Shop for Women',
                  () {
                    HiveStorage.set(HiveKeys.shopFor, 'Shop for Women');
                    navigateAndRemoveUntil(
                      context: context,
                      screen: const CustomerBottomTabBar(),
                    );
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                imageContainer(
                  context,
                  'assets/images/shop_for_man.png',
                  'Shop for Man',
                  () {
                    HiveStorage.set(HiveKeys.shopFor, 'Shop for Man');
                    navigateAndRemoveUntil(
                      context: context,
                      screen: const CustomerBottomTabBar(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Stack imageContainer(
    BuildContext context,
    image,
    buttomText,
    onTap,
  ) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          width: screenWidth(context, 1),
          height: 300.sp,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image:
                DecorationImage(image: AssetImage(image), fit: BoxFit.fitWidth),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 16,
          child: ButtonBuilder(
            text: buttomText,
            ontap: onTap,
            width: 160,
            style: AppStylesManager.customTextStyleW2.copyWith(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
