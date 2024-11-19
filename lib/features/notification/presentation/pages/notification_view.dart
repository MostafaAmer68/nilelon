import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/core/constants/assets.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/shimmer_indicator/build_shimmer.dart';
import 'package:nilelon/features/notification/presentation/cubit/notification_cubit.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/cards/notification/notify_gradient_card.dart';
import 'package:nilelon/core/widgets/cards/notification/notify_viewed_card.dart';
import 'package:nilelon/core/widgets/cards/notification/notify_card.dart';

import '../../../../core/widgets/scaffold_image.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({
    super.key,
  });

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  late final NotificationCubit cubit;
  @override
  void initState() {
    cubit = NotificationCubit.get(context);
    cubit.getAllNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return ScaffoldImage(
      appBar: customAppBar(title: lang.notification, context: context),
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
                  return Image.asset(Assets.assetsImagesNoNotification);
                }
                return Expanded(
                  child: ListView.builder(
                    // shrinkWrap: true,
                    itemCount: cubit.notificatios.length,
                    itemBuilder: (context, index) {
                      final notification = cubit.notificatios[index];
                      return NotifyViewedCard(
                        image: Assets.assetsImagesArrived2,
                        title: notification.message,
                        type: notification.type,
                        time: notification.date,
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
