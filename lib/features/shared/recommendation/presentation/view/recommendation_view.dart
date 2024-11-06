import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/constants/assets.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/features/shared/recommendation/presentation/cubit/recommendation_cubit.dart';

import '../../../../../core/utils/navigation.dart';
import '../../../../../core/widgets/scaffold_image.dart';
import '../../../../layout/customer_bottom_tab_bar.dart';

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
                          Image.asset(Assets.assetsImagesNilelonWLogo),
                          Container(
                            height: 38.sp,
                            width: 110.sp,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    Assets.assetsImagesNilelonEcommerce,
                                  ),
                                  fit: BoxFit.fitHeight),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                ClipRRect(
                  // borderRadius: BorderRadius.circular(15),
                  child: InkWell(
                    onTap: () {
                      if (HiveStorage.get(HiveKeys.userModel) != null) {
                        RecommendationCubit.get(context)
                            .setRecommendation('Female', context);
                        HiveStorage.set(HiveKeys.shopFor, 'Female');
                      } else {
                        navigateAndRemoveUntil(
                          context: context,
                          screen: const CustomerBottomTabBar(),
                        );
                        HiveStorage.set(HiveKeys.shopFor, 'Female');
                      }
                    },
                    child: Image.asset(
                      width: screenWidth(context, 0.95),
                      Assets.assetsImagesShopForWomen,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                ClipRRect(
                  // borderRadius: BorderRadius.circular(15),
                  child: InkWell(
                    onTap: () {
                      if (HiveStorage.get(HiveKeys.userModel) != null) {
                        RecommendationCubit.get(context)
                            .setRecommendation('Male', context);
                        HiveStorage.set(HiveKeys.shopFor, 'Male');
                      } else {
                        navigateAndRemoveUntil(
                          context: context,
                          screen: const CustomerBottomTabBar(),
                        );
                        HiveStorage.set(HiveKeys.shopFor, 'Male');
                      }
                    },
                    child: Image.asset(
                      width: screenWidth(context, 0.95),
                      Assets.assetsImagesShopForMan,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
