import 'package:flutter/material.dart';
import 'package:nilelon/core/widgets/cards/customer_order_management/inprogress_card.dart';

import '../../../../core/widgets/scaffold_image.dart';

class InProgressView extends StatelessWidget {
  const InProgressView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldImage(
      body: ListView.builder(
          itemCount: 9,
          itemBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: InProgressCard(),
            );
          }),
    );
  }
}
