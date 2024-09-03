import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/core/widgets/scaffold_image.dart';

import '../../../../../core/resources/appstyles_manager.dart';

class OrderedSuccessPage extends StatelessWidget {
  const OrderedSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldImage(
      body: Column(
        children: [
          Image.asset(
            'assets/images/invoice.png',
            width: screenWidth(context, 0.5),
          ),
          const SizedBox(height: 20),
          Text(
            'Thank you for ordering!',
            style: AppStylesManager.customTextStyleBl13
                .copyWith(fontSize: 25.sp, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            'You can download your receipt to view your order details.',
            style: AppStylesManager.customTextStyleG,
          ),
          const SizedBox(height: 300),
          GradientButtonBuilder(text: 'Download Receipt', ontap: () {}),
        ],
      ),
    );
  }
}
