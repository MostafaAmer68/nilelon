import 'package:flutter/material.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';

class AnalyticsSmallCard extends StatelessWidget {
  const AnalyticsSmallCard({
    super.key,
    required this.title,
    required this.number,
    required this.average,
    this.isGreen = false,
  });
  final String title;
  final int number;
  final int average;
  final bool isGreen;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth(context, 0.45),
      height: screenHeight(context, 0.115),
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
            style: AppStylesManager.customTextStyleBl13,
          ),
          const SizedBox(
            height: 2,
          ),
          isGreen
              ? Center(
                  child: Text(
                    '$number \$',
                    style: AppStylesManager.customTextStyleGR,
                  ),
                )
              : Center(
                  child: Text(
                    '$number',
                    style: AppStylesManager.customTextStyleL4,
                  ),
                ),
          const SizedBox(
            height: 2,
          ),
          isGreen
              ? Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Market Average : $average \$',
                    style: AppStylesManager.customTextStyleG20,
                  ),
                )
              : Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Market Average : $average',
                    style: AppStylesManager.customTextStyleG20,
                  ),
                )
        ],
      ),
    );
  }
}
