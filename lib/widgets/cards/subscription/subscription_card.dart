import 'package:flutter/material.dart';
import 'package:nilelon/resources/appstyles_manager.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/resources/const_functions.dart';
import 'package:nilelon/widgets/button/rounded_button.dart';

class SubscriptionCard extends StatelessWidget {
  const SubscriptionCard({
    super.key,
    required this.image,
    required this.title,
    required this.month,
    required this.price,
    required this.textColor,
    required this.ontap,
  });
  final String image;
  final String title;
  final int month;
  final int price;
  final Color textColor;
  final void Function() ontap;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: screenWidth(context, 0.92),
      height: 160,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStylesManager.customTextStyleG22,
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              const SizedBox(
                width: 4,
              ),
              const Icon(
                Icons.circle,
                color: ColorManager.primaryG22,
                size: 6,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                '$month Months',
                style: AppStylesManager.customTextStyleG23,
              )
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            children: [
              const SizedBox(
                width: 4,
              ),
              const Icon(
                Icons.circle,
                color: ColorManager.primaryG22,
                size: 6,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                '$price L.E',
                style: AppStylesManager.customTextStyleG23,
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RoundedButtonBuilder(
                text: 'Subscribe',
                ontap: ontap,
                textColor: textColor,
              ),
            ],
          )
        ],
      ),
    );
  }
}
