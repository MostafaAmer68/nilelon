import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';

class PriceAndRatingRow extends StatelessWidget {
  const PriceAndRatingRow({
    super.key,
    required this.price,
    required this.rating,
  });
  final String price;
  final String rating;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            price,
            style: AppStylesManager.customTextStyleO2,
          ),
        ),
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
    );
  }
}
