import 'package:flutter/material.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/widgets/cards/customer_order_management/shipped_card.dart';

class ShippedView extends StatelessWidget {
  const ShippedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryW,
      body: ListView.builder(
          itemCount: 9,
          itemBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ShippedCard(),
            );
          }),
    );
  }
}
