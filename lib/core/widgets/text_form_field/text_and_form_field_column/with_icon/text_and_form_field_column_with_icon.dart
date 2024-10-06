import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/widgets/text_form_field/text_field/text_form_field_builder.dart';
import 'package:svg_flutter/svg.dart';

class TextAndFormFieldColumnWithIcon extends StatelessWidget {
  const TextAndFormFieldColumnWithIcon({
    super.key,
    required this.title,
    required this.label,
    required this.image,
    required this.controller,
    this.validator,
    required this.type,
    this.spaceHeight,
    this.desc,
  });
  final String title;
  final String label;
  final String image;
  final TextEditingController controller;
  final TextInputType type;
  final double? spaceHeight;
  final String? Function(String? value)? validator;
  final String? desc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
            validator: validator,
            width: screenWidth(context, 1),
            isIcon: false,
            prefixWidget: Container(
                width: 20,
                height: 20,
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(image)),
          ),
          SizedBox(
            height: spaceHeight ?? 30,
          ),
        ],
      ),
    );
  }
}
