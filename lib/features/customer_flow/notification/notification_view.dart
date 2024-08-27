import 'package:flutter/material.dart';
import 'package:nilelon/core/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/cards/notification/notify_gradient_card.dart';
import 'package:nilelon/core/widgets/cards/notification/notify_viewed_card.dart';
import 'package:nilelon/core/widgets/cards/notification/notify_card.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key, required this.noNotification});
  final bool noNotification;
  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Scaffold(
      backgroundColor: ColorManager.primaryW,
      appBar: customAppBar(title: lang.notification, context: context),
      body: Column(
        children: [
          const SizedBox(
            height: 4,
            child: Divider(
              color: ColorManager.primaryG8,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: noNotification
                  ? Container(
                      width: screenWidth(context, 0.5),
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/noNotification.png'))),
                    )
                  : const Column(
                      children: [
                        NotifyGradientCard(
                          image: 'assets/images/cloth1.png',
                          title: '20% Discount on this item, Don’t miss it.',
                          time: '11:56 AM',
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        NotifyCard(
                          image: 'assets/images/Arrived.png',
                          title: 'Your package is being packed by the sender',
                          time: '11:56 AM',
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        NotifyViewedCard(
                          image: 'assets/images/arrived2.png',
                          title: 'Your package has arrived at your destination',
                          time: '11:56 AM',
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
