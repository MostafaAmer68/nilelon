import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/constants/assets.dart';
import 'package:nilelon/core/widgets/cards/notification/notify_card.dart';
import 'package:nilelon/core/widgets/cards/notification/notify_viewed_card.dart';

import '../../../../core/widgets/scaffold_image.dart';
import '../cubit/notification_cubit.dart';

class UpdatesView extends StatelessWidget {
  const UpdatesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldImage(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: ListView.builder(
          itemCount: NotificationCubit.get(context).notificatios.length,
          itemBuilder: (context, index) {
            final notify = NotificationCubit.get(context).notificatios[index];
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  NotifyCard(
                    image: Assets.assetsImagesArrived2,
                    notify: notify,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
