import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:nilelon/core/constants/assets.dart';
import 'package:nilelon/core/widgets/cards/notification/notify_card.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/shimmer_indicator/build_shimmer.dart';
import 'package:nilelon/features/notification/presentation/cubit/notification_cubit.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/cards/notification/notify_viewed_card.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../../core/data/hive_stroage.dart';
import '../../../../core/resources/appstyles_manager.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/widgets/scaffold_image.dart';
import '../../data/models/notification_data.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({
    super.key,
  });

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  late final NotificationCubit cubit;
  final GlobalKey markAll = GlobalKey();
  List<TargetFocus> targets = [];
  @override
  void initState() {
    cubit = NotificationCubit.get(context);
    if (cubit.notificatios.isEmpty) {
      cubit.getAllNotification();
    }
    if (HiveStorage.get('markAll') == null) {
      _setupTargets();
      _showTutorial();
    }
    super.initState();
  }

  void _setupTargets() {
    targets.add(
      TargetFocus(
        identify: "button",
        keyTarget: markAll,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: const Text(
              'click here to mark all notification read',
              style: TextStyle(
                  color: ColorManager.primaryW,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  void _showTutorial() async {
    TutorialCoachMark(
      targets: targets,
      colorShadow: ColorManager.primaryL,
      textSkip: "SKIP",
      paddingFocus: 10,
      opacityShadow: 0.9,
      onClickTarget: (t) {
        HiveStorage.set('markAll', false);
      },
      onSkip: () {
        HiveStorage.set('markAll', false);
        return true;
      },
    ).show(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return ScaffoldImage(
      appBar: customAppBar(
        key: markAll,
        title: lang.notification,
        context: context,
        icon: Icons.all_inbox,
        onPressed: () {
          NotificationCubit.get(context).markNotifyAsRead('');
        },
        iconColor: ColorManager.primaryO,
      ),
      body: Column(
        children: [
          const DefaultDivider(),
          BlocBuilder<NotificationCubit, NotificationState>(
            builder: (context, state) {
              if (state is NotificationLoading) {
                return buildShimmerIndicatorSmall();
              }

              if (state is NotificationSuccess) {
                if (cubit.notificatios.isEmpty) {
                  return SizedBox(
                    height: 800,
                    child: Image.asset(
                      Assets.assetsImagesNoNotification,
                      width: 300,
                    ),
                  );
                }
                return Expanded(
                  child: GroupedListView<NotificationData, String>(
                    elements: NotificationCubit.get(context).notificatios,
                    order: GroupedListOrder.DESC,
                    groupBy: (NotificationData e) => DateFormat('dd-MM-yyyy')
                        .format(DateFormat('yyyy-MM-dd').parse(e.date)),
                    groupSeparatorBuilder: (String groupByValue) => Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          groupByValue,
                          style: AppStylesManager.customDateStyle
                              .copyWith(fontSize: 14.sp),
                        ),
                      ),
                    ),
                    // itemCount: NotificationCubit.get(context).notificatios.length,
                    itemBuilder: (context, notify) {
                      if (notify.isRead) {
                        return NotifyViewedCard(
                          image: Assets.assetsImagesNotificationsActive,
                          notify: notify,
                        );
                      }
                      return NotifyCard(
                        image: Assets.assetsImagesNotificationsActive,
                        notify: notify,
                      );
                    },
                  ),
                );
              }
              if (state is Notificationfailure) {
                return Center(child: Text(state.err));
              }
              return Image.asset(Assets.assetsImagesNoNotification);
            },
          ),
        ],
      ),
    );
  }
}
