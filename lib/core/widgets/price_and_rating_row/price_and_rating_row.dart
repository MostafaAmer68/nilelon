import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';

class PriceAndRatingRow extends StatelessWidget {
  const PriceAndRatingRow({
    super.key,
    required this.price,
    required this.rating,
    this.style,
  });
  final String price;
  final String rating;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          price,
          style: style ?? AppStylesManager.customTextStyleBl2,
        ),
        Row(
          children: [
            Icon(
              Icons.star,
              color: ColorManager.primaryO2,
              size: 20.r,
            ),
            Text(
              rating,
              style: AppStylesManager.customTextStyleG6,
            ),
          ],
        ),
      ],
    );
  }
}
