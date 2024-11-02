import 'package:flutter/material.dart';
import 'package:nilelon/core/constants/assets.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/widgets/replacer/image_replacer.dart';

import '../../../../core/resources/color_manager.dart';

class GanderFilterItem extends StatelessWidget {
  const GanderFilterItem({
    super.key,
    required this.name,
    required this.isSelected,
    required this.onTap,
  });
  final String name;
  final bool isSelected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Container(
              decoration: !isSelected
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: ColorManager.primaryB2))
                  : BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: ColorManager.primaryW,
                      boxShadow: const [
                        BoxShadow(
                          color: ColorManager.primaryO2,
                          offset: Offset(5, 5),
                        ),
                      ],
                      border: Border.all(color: ColorManager.primaryL),
                    ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Center(
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: AppStylesManager.customTextStyleB4,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class KnitwearBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Draw shadow
    final shadowPaint = Paint()
      ..color = Colors.orange.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    final shadowRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(8, 8, size.width - 16, size.height - 16),
      Radius.circular(60),
    );

    canvas.drawRRect(shadowRect, shadowPaint);

    // Draw white background with blue border
    final backgroundPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final backgroundRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(60),
    );

    canvas.drawRRect(backgroundRect, backgroundPaint);

    final borderPaint = Paint()
      ..color = Colors.blueAccent
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    canvas.drawRRect(backgroundRect, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
