import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/constants/assets.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/features/closet/presentation/view/closet_sheet_bar_view.dart';
import 'package:nilelon/features/notification/presentation/cubit/notification_cubit.dart';
import 'package:nilelon/features/notification/presentation/pages/notification_view.dart';
import 'package:nilelon/features/profile/presentation/pages/profile_guest_page.dart';
import 'package:svg_flutter/svg.dart';

class HomeCustomAppBar extends StatefulWidget {
  const HomeCustomAppBar({
    super.key,
  });

  @override
  State<HomeCustomAppBar> createState() => _HomeCustomAppBarState();
}

class _HomeCustomAppBarState extends State<HomeCustomAppBar> {
  @override
  void initState() {
    NotificationCubit.get(context).getAllNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 12.sp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 30.w,
            height: 30.w,
            child: SvgPicture.asset(Assets.assetsImagesLogo),
          ),
          SizedBox(
            width: 90.w,
            height: 30.w,
            child: Image.asset(Assets.assetsImagesNilelonEcommerce),
          ),
          const Spacer(),
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
                clipBehavior: Clip.none,
                children: [
                  Center(
                    child: SizedBox(
                      width: 1.sw > 600 ? 40 : 30,
                      height: 1.sw > 600 ? 40 : 30,
                      child: SvgPicture.asset(Assets.assetsImagesNotification),
                    ),
                  ),
                  BlocBuilder<NotificationCubit, NotificationState>(
                    builder: (context, state) {
                      return Visibility(
                        visible: NotificationCubit.get(context)
                            .notificatios
                            .any((e) => !e.isRead),
                        child: Positioned(
                          left: -5,
                          top: -5,
                          child: Center(
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor: ColorManager.primaryR,
                              child: Text(
                                NotificationCubit.get(context)
                                    .notificatios
                                    .where((e) => !e.isRead)
                                    .length
                                    .toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
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
              if (HiveStorage.get(HiveKeys.userModel) != null) {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: ColorManager.primaryW,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  builder: (context) => const ClosetSheetBarView(),
                );
              } else {
                navigateTo(
                    context: context,
                    screen: const ProfileGuestPage(
                      hasLeading: true,
                    ));
              }
            },
            child: Container(
              width: 1.sw > 600 ? 40 : 40,
              height: 1.sw > 600 ? 40 : 40,
              padding: const EdgeInsets.all(4),
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
              child: SvgPicture.asset(
                Assets.assetsImagesCloset,
              ),
            ),
          )
        ],
      ),
    );
  }
}
