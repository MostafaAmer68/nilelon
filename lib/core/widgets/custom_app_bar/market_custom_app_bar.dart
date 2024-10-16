import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/constants/assets.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/features/store_flow/notification/notification_tab_bar.dart';

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
          Container(
            width: 30.w,
            height: 30.w,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Assets.assetsImagesLogo))),
          ),
          Container(
            width: 90.w,
            height: 30.w,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Assets.assetsImagesNilelonEcommerce))),
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
                  SizedBox(
                    width: 1.sw > 600 ? 40 : 30,
                    height: 1.sw > 600 ? 40 : 30,
                    child: Image.asset(Assets.assetsImagesNotifications),
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
