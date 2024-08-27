import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/resources/color_manager.dart';

class GradientDotActive extends StatelessWidget {
  const GradientDotActive({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24.w,
      height: 6.w,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: ColorManager.gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }
}
