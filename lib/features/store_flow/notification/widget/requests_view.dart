import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/widgets/cards/notification/notify_gradient_card.dart';

class RequestsView extends StatelessWidget {
  const RequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryW,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: ListView.builder(
            itemCount: 9,
            itemBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: NotifyGradientCard(
                    image: 'assets/images/Package.png',
                    title: 'You Have New Order.',
                    time: '11:56 AM'),
              );
            }),
      ),
    );
  }
}
