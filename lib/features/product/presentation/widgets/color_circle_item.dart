import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Container colorCircleItem(int color) {
  return Container(
    width: 32.h,
    height: 32.h,
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
  );
}
