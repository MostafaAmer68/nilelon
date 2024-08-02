import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/data/hive_stroage.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/resources/appstyles_manager.dart';
import 'package:nilelon/utils/navigation.dart';
import 'package:nilelon/widgets/alert/logout_alert.dart';
import 'package:nilelon/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/widgets/divider/default_divider.dart';
import 'package:nilelon/features/customer_flow/closet/view/closet_view.dart';
import 'package:nilelon/features/customer_flow/order_management/widgets/top_tab_bar.dart';
import 'package:nilelon/features/customer_flow/profile/widget/profile_list_view.dart';
import 'package:nilelon/features/customer_flow/recommendation_profile/recommendation_profile_view.dart';
import 'package:nilelon/features/customer_flow/settings/settings_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Scaffold(
      backgroundColor: ColorManager.primaryW,
      appBar: customAppBar(
          title: lang.profile,
          context: context,
          hasIcon: false,
          hasLeading: false),
      body: Column(
        children: [
          const DefaultDivider(),
          Padding(
            padding: EdgeInsets.all(16.0.sp),
            child: Column(
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/profile.png'),
                      radius: 28,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      'Hi, ${HiveStorage.get(HiveKeys.name)}',
                      style: AppStylesManager.customTextStyleBl8
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                ProfileListTile(
                  name: lang.ordersManagement,
                  image: 'assets/images/bag.svg',
                  onTap: () {
                    navigateTo(
                        context: context,
                        screen: const OrderManegementTabBar());
                  },
                ),
                ProfileListTile(
                  name: lang.myCloset,
                  image: 'assets/images/Closet.svg',
                  onTap: () {
                    navigateTo(context: context, screen: const ClosetView());
                  },
                ),
                ProfileListTile(
                  name: lang.recommendations,
                  image: 'assets/images/Recommendation.svg',
                  onTap: () {
                    navigateTo(
                        context: context,
                        screen: const RecommendationProfileView());
                  },
                ),
                ProfileListTile(
                  name: lang.settings,
                  image: 'assets/images/Settings.svg',
                  onTap: () {
                    navigateTo(context: context, screen: const SettingsView());
                  },
                ),
                ProfileListTile(
                  name: lang.logout,
                  image: 'assets/images/logout.svg',
                  isRed: true,
                  onTap: () {
                    logoutAlert(context);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
