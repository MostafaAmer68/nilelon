import 'package:flutter/material.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';

class AnalyticsBigCard extends StatelessWidget {
  const AnalyticsBigCard({
    super.key,
    required this.title,
    required this.number,
    required this.average,
    required this.index,
  });
  final String title;
  final int number;
  final int average;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth(context, 0.45),
      height: screenHeight(context, 0.2),
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        // color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        gradient: index == 0
            ? const LinearGradient(
                begin: Alignment(-0.41, -0.91),
                end: Alignment(0.41, 0.91),
                colors: ColorManager.gradientBoxColors,
              )
            : index == 1
                ? const LinearGradient(
                    begin: Alignment(-0.32, -0.95),
                    end: Alignment(0.32, 0.95),
                    colors: ColorManager.gradientBoxColors2,
                  )
                : const LinearGradient(
                    begin: Alignment(-0.79, -0.61),
                    end: Alignment(0.79, 0.61),
                    colors: ColorManager.gradientBoxColors3,
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
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                title,
                style: AppStylesManager.customTextStyleW6,
              ),
            ),
            const SizedBox(
              height: 13,
            ),
            Text(
              '$number',
              style: AppStylesManager.customTextStyleW7,
            ),
            // const SizedBox(
            //   height: 28,
            // ),
            Text(
              'Market Average : $average',
              style: AppStylesManager.customTextStyleW8,
            )
          ],
        ),
      ),
    );
  }
}
