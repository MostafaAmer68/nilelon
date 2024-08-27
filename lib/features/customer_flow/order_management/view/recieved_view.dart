import 'package:flutter/material.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/widgets/cards/customer_order_management/recieved_card.dart';

class RecievedView extends StatelessWidget {
  const RecievedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryW,
      body: ListView.builder(
          itemCount: 9,
          itemBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: RecievedCard(),
            );
          }),
    );
  }
}
