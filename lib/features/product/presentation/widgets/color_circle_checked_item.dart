import 'package:flutter/material.dart';
import 'package:nilelon/core/resources/color_manager.dart';

Container colorCircleCheckedItem(int color) {
  return Container(
    width: 32,
    height: 32,
    decoration: BoxDecoration(
      boxShadow: const [
        BoxShadow(
          color: Color(0x33726363),
          blurRadius: 8,
          offset: Offset(0, 4),
          spreadRadius: 0,
        )
      ],
      color: Color(color),
      shape: BoxShape.circle,
    ),
    child: const Icon(
      Icons.check_rounded,
      color: ColorManager.primaryG14,
    ),
  );
}
