import 'package:flutter/material.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';

class AnalyticsBigCard extends StatelessWidget {
  const AnalyticsBigCard({
    super.key,
    required this.title,
    required this.number,
    required this.average,
    this.isOrange = true,
  });
  final String title;
  final int number;
  final int average;
  final bool isOrange;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth(context, 0.45),
      height: screenHeight(context, 0.25),
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        shadows: const [
          BoxShadow(
            color: Color(0x33726363),
            blurRadius: 16,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStylesManager.customTextStyleBl12,
          ),
          const SizedBox(
            height: 28,
          ),
          Center(
            child: Text(
              '$number',
              style: isOrange
                  ? AppStylesManager.customTextStyleO6
                  : AppStylesManager.customTextStyleL5,
            ),
          ),
          const SizedBox(
            height: 28,
          ),
          Center(
            child: Text(
              'Market Average : $average',
              style: AppStylesManager.customTextStyleG8,
            ),
          )
        ],
      ),
    );
  }
}
