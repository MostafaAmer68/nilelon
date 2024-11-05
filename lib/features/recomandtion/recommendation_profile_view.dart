import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/features/shared/recommendation/presentation/cubit/recommendation_cubit.dart';

import '../../core/utils/navigation.dart';
import '../../core/widgets/scaffold_image.dart';
import '../layout/customer_bottom_tab_bar.dart';

class RecommendationProfileView extends StatelessWidget {
  const RecommendationProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return ScaffoldImage(
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
                    if (HiveStorage.get(HiveKeys.userModel) != null) {
                      RecommendationCubit.get(context)
                          .setRecommendation('Female', context);
                    }
                    navigateAndRemoveUntil(
                      context: context,
                      screen: const CustomerBottomTabBar(),
                    );
                    HiveStorage.set(HiveKeys.shopFor, 'Female');
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
                    if (HiveStorage.get(HiveKeys.userModel) != null) {
                      RecommendationCubit.get(context)
                          .setRecommendation('Male', context);
                    }
                    navigateAndRemoveUntil(
                      context: context,
                      screen: const CustomerBottomTabBar(),
                    );
                    HiveStorage.set(HiveKeys.shopFor, 'Male');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector imageContainer(
    BuildContext context,
    image,
    buttomText,
    onTap,
  ) {
    return
        // Stack(
        //   alignment: Alignment.centerLeft,
        //   children: [
        GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth(context, 1),
        height: 300.sp,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image:
              DecorationImage(image: AssetImage(image), fit: BoxFit.fitWidth),
        ),
      ),
    );
    // ,
    //     Positioned(
    //       bottom: 20,
    //       left: 16,
    //       child: ButtonBuilder(
    //         text: buttomText,
    //         ontap: onTap,
    //         width: 160,
    //         style: AppStylesManager.customTextStyleW2.copyWith(fontSize: 14),
    //       ),
    //     ),
    //   ],
    // );
  }
}
