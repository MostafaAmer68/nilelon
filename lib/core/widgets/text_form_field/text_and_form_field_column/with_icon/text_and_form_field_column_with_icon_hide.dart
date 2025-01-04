import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/widgets/text_form_field/text_field/text_form_field_builder.dart';
import 'package:svg_flutter/svg.dart';

class TextAndFormFieldColumnWithIconHide extends StatefulWidget {
  const TextAndFormFieldColumnWithIconHide({
    super.key,
    required this.title,
    required this.label,
    required this.image,
    required this.controller,
    this.validator,
    this.onChange,
    required this.type,
    this.spaceHeight,
    this.desc,
  });
  final String title;
  final String label;
  final String image;
  final TextEditingController controller;
  final TextInputType type;
  final String? Function(String? value)? validator;
  final Function(String value)? onChange;
  final double? spaceHeight;
  final String? desc;

  @override
  State<TextAndFormFieldColumnWithIconHide> createState() =>
      _TextAndFormFieldColumnWithIconHideState();
}

class _TextAndFormFieldColumnWithIconHideState
    extends State<TextAndFormFieldColumnWithIconHide> {
  bool showPassword = true;
  onpressed() {
    setState(
      () {
        showPassword = !showPassword;
      },
    );
  }

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
                widget.title,
                style: AppStylesManager.customTextStyleBl5,
              ),
              Text(
                widget.desc ?? "",
                style: AppStylesManager.customTextStyleG8,
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          TextFormFieldBuilder(
            label: widget.label,
            validator: widget.validator,
            controller: widget.controller,
            type: widget.type,
            onchanged: widget.onChange,
            width: screenWidth(context, 0.92),
            isIcon: false,
            obsecure: showPassword,
            prefixWidget: Container(
                width: 20.sp,
                height: 20.sp,
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(widget.image)),
            suffix: IconButton(
              onPressed: onpressed,
              icon: showPassword
                  ? const Icon(
                      Iconsax.eye,
                      color: ColorManager.primaryG,
                    )
                  : const Icon(
                      Iconsax.eye_slash,
                      color: ColorManager.primaryG,
                    ),
            ),
          ),
          SizedBox(
            height: widget.spaceHeight ?? 30,
          ),
        ],
      ),
    );
  }
}
