import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/features/shared/recommendation/presentation/cubit/recommendation_cubit.dart';

import '../../../../../core/widgets/scaffold_image.dart';

class RecommendationView extends StatelessWidget {
  const RecommendationView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldImage(
      body: SafeArea(
        child: BlocListener<RecommendationCubit, RecommendationState>(
          listener: (context, state) {},
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
                          RecommendationCubit.get(context)
                              .setRecommendation('Female', context);
                          HiveStorage.set(HiveKeys.shopFor, 'Female');
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
                          RecommendationCubit.get(context)
                              .setRecommendation('Male', context);
                          HiveStorage.set(HiveKeys.shopFor, 'Male');
                          
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  InkWell imageContainer(
    BuildContext context,
    image,
    buttomText,
    onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            width: screenWidth(context, 1),
            height: 300.sp,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                  image: AssetImage(image), fit: BoxFit.fitWidth),
            ),
          ),
          // Positioned(
          //   bottom: 20,
          //   left: 16,
          //   child: ButtonBuilder(
          //     text: buttomText,
          //     ontap: onTap,
          //     width: 140.sp,
          //     style: AppStylesManager.customTextStyleW2.copyWith(fontSize: 12.sp),
          //   ),
          // ),
        ],
      ),
    );
  }
}