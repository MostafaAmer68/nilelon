import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../color_const.dart';

class DontsWidget extends StatelessWidget {
  const DontsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: colorConst
            .map(
              (e) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 1),
                width: 10.w,
                height: 10.w,
                decoration: BoxDecoration(
                  color: e,
                  shape: BoxShape.circle,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
