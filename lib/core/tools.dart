import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

SliverGridDelegateWithFixedCrossAxisCount get gridDelegate =>
    SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 1.sw > 600 ? 3 : 2,
      crossAxisSpacing: 1.sw > 600 ? 14 : 16.0,
      mainAxisExtent: 1.sw > 600 ? 300 : 270,
      mainAxisSpacing: 1.sw > 600 ? 16 : 12,
    );