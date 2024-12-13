import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:nilelon/core/constants/assets.dart';
import 'package:nilelon/core/widgets/cards/notification/notify_card.dart';

import '../../../../core/resources/appstyles_manager.dart';
import '../../../../core/widgets/scaffold_image.dart';
import '../../data/models/notification_data.dart';
import '../cubit/notification_cubit.dart';

class UpdatesView extends StatelessWidget {
  const UpdatesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldImage(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
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
                style:
                    AppStylesManager.customDateStyle.copyWith(fontSize: 14.sp),
              ),
            ),
          ),
          // itemCount: NotificationCubit.get(context).notificatios.length,
          itemBuilder: (context, notify) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: NotifyCard(
                  image: Assets.assetsImagesPackageAccept, notify: notify),
            );
          },
        ),
      ),
    );
  }
}
