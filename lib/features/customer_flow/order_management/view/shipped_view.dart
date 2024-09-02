import 'package:flutter/material.dart';
import 'package:nilelon/core/widgets/cards/customer_order_management/shipped_card.dart';

import '../../../../core/widgets/scaffold_image.dart';

class ShippedView extends StatelessWidget {
  const ShippedView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldImage(
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
