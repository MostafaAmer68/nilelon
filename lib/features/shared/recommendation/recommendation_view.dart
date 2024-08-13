import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/data/hive_stroage.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/resources/const_functions.dart';
import 'package:nilelon/resources/appstyles_manager.dart';
import 'package:nilelon/utils/navigation.dart';
import 'package:nilelon/widgets/button/button_builder.dart';
import 'package:nilelon/features/customer_flow/layout/customer_bottom_tab_bar.dart';

class RecommendationView extends StatelessWidget {
  const RecommendationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryW,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipPath(
                clipper: OvalBottomBorderClipper(),
                child: Container(
                  width: screenWidth(context, 1),
                  height: 65.sp,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      begin: Alignment(1.00, -0.10),
                      end: Alignment(-1, 0.1),
                      colors: ColorManager.gradientColors,
                    ),
                    color: ColorManager.primaryW,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/nilelonWLogo.png'),
                        Container(
                          height: 38.sp,
                          width: 110.sp,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/nilelonEcommerce.png',
                                  ),
                                  fit: BoxFit.fitHeight)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0.sp),
                child: Column(
                  children: [
                    imageContainer(
                      context,
                      'assets/images/shop_for_women.png',
                      'Shop for Women',
                      () {
                        HiveStorage.set(HiveKeys.shopFor, 'Female');
                        navigateAndRemoveUntil(
                          context: context,
                          screen: const CustomerBottomTabBar(),
                        );
                      },
                    ),
                    SizedBox(
                      height: 16.sp,
                    ),
                    imageContainer(
                      context,
                      'assets/images/shop_for_man.png',
                      'Shop for Man',
                      () {
                        HiveStorage.set(HiveKeys.shopFor, 'Male');
                        navigateAndRemoveUntil(
                          context: context,
                          screen: const CustomerBottomTabBar(),
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
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
            width: 140.sp,
            style: AppStylesManager.customTextStyleW2.copyWith(fontSize: 12.sp),
          ),
        ),
      ],
    );
  }
}
