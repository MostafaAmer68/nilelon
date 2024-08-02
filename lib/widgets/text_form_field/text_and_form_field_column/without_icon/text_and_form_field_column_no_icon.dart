import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/resources/const_functions.dart';
import 'package:nilelon/resources/appstyles_manager.dart';
import 'package:nilelon/widgets/text_form_field/text_field/text_form_field_builder.dart';

class TextAndFormFieldColumnNoIcon extends StatelessWidget {
  const TextAndFormFieldColumnNoIcon({
    super.key,
    required this.title,
    required this.label,
    required this.controller,
    required this.type,
    this.height,
    this.desc,
    this.maxlines = true,
    this.fieldHeight,
  });
  final String title;
  final String label;
  final double? height;
  final double? fieldHeight;
  final TextEditingController controller;
  final TextInputType type;
  final String? desc;
  final bool? maxlines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: AppStylesManager.customTextStyleBl5,
            ),
            Text(
              desc ?? "",
              style: AppStylesManager.customTextStyleG8,
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        TextFormFieldBuilder(
          label: label,
          controller: controller,
          type: type,
          width: screenWidth(context, 0.92),
          noIcon: true,
          maxlines: maxlines,
          height: fieldHeight,
        ),
        SizedBox(
          height: height ?? 40.h,
        ),
      ],
    );
  }
}
