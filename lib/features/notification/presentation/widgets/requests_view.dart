import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/widgets/cards/notification/notify_gradient_card.dart';
import 'package:nilelon/features/notification/presentation/cubit/notification_cubit.dart';

import '../../../../core/widgets/scaffold_image.dart';

class RequestsView extends StatelessWidget {
  const RequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldImage(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: ListView.builder(
          itemCount: NotificationCubit.get(context).notificatios.length,
          itemBuilder: (context, index) {
            final notification =
                NotificationCubit.get(context).notificatios[index];
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: NotifyGradientCard(
                  image: 'assets/images/Package.png', notify: notification),
            );
          },
        ),
      ),
    );
  }
}
