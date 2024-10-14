import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/constants/assets.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/features/closet/presentation/view/closet_Page.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/alert/logout_alert.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/replacer/image_replacer.dart';
import 'package:nilelon/features/order/presentation/pages/order_customer_tab_bar.dart';
import 'package:nilelon/features/profile/presentation/widgets/profile_list_view.dart';
import 'package:nilelon/features/customer_flow/recommendation_profile/recommendation_profile_view.dart';
import 'package:nilelon/features/profile/presentation/pages/settings_view.dart';

import '../../../../core/widgets/scaffold_image.dart';
import '../../../auth/domain/model/user_model.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return ScaffoldImage(
      appBar: customAppBar(
          title: lang.profile,
          context: context,
          hasIcon: false,
          hasLeading: false),
      body: Column(
        children: [
          const DefaultDivider(),
          Container(
            // padding: EdgeInsets.all(16.0.sp),
            margin: EdgeInsets.all(16.0.sp),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16.0.sp),
                  decoration: BoxDecoration(
                    color: ColorManager.primaryW,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: imageReplacer(
                          url: HiveStorage.get<UserModel>(HiveKeys.userModel)
                              .getUserData<CustomerModel>()
                              .profilePic,
                          width: 60,
                          height: 60,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        'Hi, ${HiveStorage.get<UserModel>(HiveKeys.userModel).getUserData<CustomerModel>().name}',
                        style: AppStylesManager.customTextStyleBl8
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
                  decoration: BoxDecoration(
                    color: ColorManager.primaryW,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      ProfileListTile(
                        name: lang.ordersManagement,
                        image: Assets.assetsImagesBag,
                        onTap: () {
                          navigateTo(
                              context: context,
                              screen: const OrderManegementTabBar());
                        },
                      ),
                      ProfileListTile(
                        name: lang.myCloset,
                        image: Assets.assetsImagesCloset,
                        onTap: () {
                          navigateTo(
                              context: context, screen: const ClosetPage());
                        },
                      ),
                      ProfileListTile(
                        name: lang.recommendations,
                        image: Assets.assetsImagesRecommendation,
                        onTap: () {
                          navigateTo(
                              context: context,
                              screen: const RecommendationProfileView());
                        },
                      ),
                      ProfileListTile(
                        name: lang.settings,
                        image: Assets.assetsImagesSettings,
                        onTap: () {
                          navigateTo(
                              context: context, screen: const SettingsView());
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
                  decoration: BoxDecoration(
                    color: ColorManager.primaryW,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ProfileListTile(
                    name: lang.logout,
                    image: 'assets/images/logout.svg',
                    isRed: true,
                    onTap: () {
                      logoutAlert(context);
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
