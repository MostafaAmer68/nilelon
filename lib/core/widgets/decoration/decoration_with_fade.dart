import 'package:flutter/material.dart';

ShapeDecoration decorationWithFade() {
  return ShapeDecoration(
    color: const Color(0xFFFBF9F9),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    shadows: const [
      BoxShadow(
        color: Color(0x33726363),
        blurRadius: 24,
        offset: Offset(0, 1),
        spreadRadius: 0,
      )
    ],
  );
}
