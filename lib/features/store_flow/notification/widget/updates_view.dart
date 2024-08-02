import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/widgets/cards/notification/notify_card.dart';
import 'package:nilelon/widgets/cards/notification/notify_viewed_card.dart';

class UpdatesView extends StatelessWidget {
  const UpdatesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryW,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    NotifyCard(
                        image: 'assets/images/arrived2.png',
                        title: 'Package 43901 has arrived to Customer',
                        time: '10:30 AM'),
                    SizedBox(
                      height: 16,
                    ),
                    NotifyViewedCard(
                      image: 'assets/images/Feedback.png',
                      title: ' You Received New Feedback. Check it Now! ',
                      time: '11:56 AM',
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
