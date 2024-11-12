import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/constants/assets.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/features/store_flow/notification/notification_tab_bar.dart';
import 'package:svg_flutter/svg.dart';

import '../../../features/notification/presentation/pages/notification_view.dart';
import '../../../features/profile/presentation/pages/profile_guest_page.dart';
import '../../data/hive_stroage.dart';

class MarketCustomAppBar extends StatelessWidget {
  const MarketCustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 12.sp),
      child: Row(
        children: [
          SizedBox(
            width: 30.w,
            height: 30.w,
            child: SvgPicture.asset(Assets.assetsImagesLogo),
          ),
          GestureDetector(
            onTap: () {
              navigateTo(
                  context: context,
                  screen: HiveStorage.get(HiveKeys.userModel) != null
                      ? const NotificationView()
                      : const ProfileGuestPage(
                          hasLeading: true,
                        ));
            },
            child: Container(
              width: 1.sw > 600 ? 40 : 40,
              height: 1.sw > 600 ? 40 : 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: ColorManager.primaryO,
                    blurRadius: 0,
                    offset: Offset(5, 5),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Center(
                    child: SizedBox(
                      width: 1.sw > 600 ? 40 : 30,
                      height: 1.sw > 600 ? 40 : 30,
                      child: SvgPicture.asset(Assets.assetsImagesNotification),
                    ),
                  ),
                  Positioned(
                    left: 4,
                    child: Container(
                      width: 1.sw > 600 ? 16 : 14,
                      height: 1.sw > 600 ? 16 : 14,
                      decoration: BoxDecoration(
                          color: ColorManager.primaryR,
                          borderRadius: BorderRadius.circular(16)),
                      child: const Center(
                        child: Text(
                          '0',
                          style: TextStyle(color: Colors.white, fontSize: 8),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              navigateTo(context: context, screen: const NotificationTabBar());
            },
            child: SizedBox(
              width: 1.sw > 600 ? 40 : 30,
              height: 1.sw > 600 ? 40 : 30,
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      navigateTo(
                          context: context,
                          screen: HiveStorage.get(HiveKeys.userModel) != null
                              ? const NotificationTabBar()
                              : const ProfileGuestPage(
                                  hasLeading: true,
                                ));
                    },
                    child: Container(
                      width: 1.sw > 600 ? 40 : 40,
                      height: 1.sw > 600 ? 40 : 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: ColorManager.primaryO,
                            blurRadius: 0,
                            offset: Offset(5, 5),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Center(
                            child: SizedBox(
                              width: 1.sw > 600 ? 40 : 30,
                              height: 1.sw > 600 ? 40 : 30,
                              child: SvgPicture.asset(
                                  Assets.assetsImagesNotification),
                            ),
                          ),
                          Positioned(
                            left: 4,
                            child: Container(
                              width: 1.sw > 600 ? 16 : 14,
                              height: 1.sw > 600 ? 16 : 14,
                              decoration: BoxDecoration(
                                  color: ColorManager.primaryR,
                                  borderRadius: BorderRadius.circular(16)),
                              child: const Center(
                                child: Text(
                                  '0',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 4,
                    child: Container(
                      width: 1.sw > 600 ? 16 : 14,
                      height: 1.sw > 600 ? 16 : 14,
                      decoration: BoxDecoration(
                          color: ColorManager.primaryR,
                          borderRadius: BorderRadius.circular(16)),
                      child: const Center(
                        child: Text(
                          '0',
                          style: TextStyle(color: Colors.white, fontSize: 8),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
