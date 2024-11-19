import 'package:flutter/material.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';

class AnalyticsSmallCard extends StatelessWidget {
  const AnalyticsSmallCard({
    super.key,
    required this.title,
    required this.number,
    required this.average,
    this.isOrange = false,
  });
  final String title;
  final int number;
  final int average;
  final bool isOrange;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth(context, 0.45),
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        // color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        gradient: isOrange
            ? const LinearGradient(
                begin: Alignment(-0.66, -0.75),
                end: Alignment(0.66, 0.75),
                colors: ColorManager.gradientBoxColors5,
              )
            : const LinearGradient(
                begin: Alignment(-0.66, -0.75),
                end: Alignment(0.66, 0.75),
                colors: ColorManager.gradientBoxColors4,
              ),
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: AppStylesManager.customTextStyleW10,
          ),
          const SizedBox(
            height: 2,
          ),
          isOrange
              ? Center(
                  child: Text(
                    '$number \$',
                    style: AppStylesManager.customTextStyleW9,
                  ),
                )
              : Center(
                  child: Text(
                    '$number',
                    style: AppStylesManager.customTextStyleW9,
                  ),
                ),
          const SizedBox(
            height: 2,
          ),
          isOrange
              ? Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Market Average : $average \$',
                    style: AppStylesManager.customTextStyleW11,
                  ),
                )
              : Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Market Average : $average',
                    style: AppStylesManager.customTextStyleW11,
                  ),
                )
        ],
      ),
    );
  }
}
