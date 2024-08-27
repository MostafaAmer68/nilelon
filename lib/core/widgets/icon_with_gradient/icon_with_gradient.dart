import 'package:flutter/material.dart';
import 'package:nilelon/core/resources/color_manager.dart';

ShaderMask iconWithGradient(IconData icon) {
  return ShaderMask(
    blendMode: BlendMode.srcIn,
    shaderCallback: (Rect bounds) => const RadialGradient(
      center: Alignment.topCenter,
      stops: [.5, 1],
      colors: ColorManager.gradientColors,
    ).createShader(bounds),
    child: Icon(
      icon,
    ),
  );
}
