import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/utils/navigation.dart';
import 'package:nilelon/features/closet/presentation/view/closet_view.dart';
import 'package:nilelon/features/customer_flow/notification/notification_view.dart';
import 'package:svg_flutter/svg.dart';

class HomeCustomAppBar extends StatelessWidget {
  const HomeCustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 12.sp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 30.w,
            height: 30.w,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/1-Nilelon f logo d.png'))),
          ),
          Container(
            width: 90.w,
            height: 30.w,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/nilelonEcommerce.png'))),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              navigateTo(
                  context: context,
                  screen: const NotificationView(
                    noNotification: false,
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
                      child: SvgPicture.asset('assets/images/Notification.svg'),
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
          const SizedBox(
            width: 12,
          ),
          GestureDetector(
            onTap: () {
              navigateTo(context: context, screen: const ClosetView());
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
              child: SvgPicture.asset('assets/images/Closet.svg'),
            ),
          )
        ],
      ),
    );
  }
}
