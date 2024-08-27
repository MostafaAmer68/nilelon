import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/widgets/text_form_field/text_field/text_form_field_builder.dart';

class TextAndFormFieldColumnNoIconHide extends StatefulWidget {
  const TextAndFormFieldColumnNoIconHide({
    super.key,
    required this.title,
    required this.label,
    required this.controller,
    required this.type,
    this.spaceSize,
  });
  final String title;
  final String label;
  final TextEditingController controller;
  final TextInputType type;
  final double? spaceSize;
  @override
  State<TextAndFormFieldColumnNoIconHide> createState() =>
      _TextAndFormFieldColumnNoIconHideState();
}

class _TextAndFormFieldColumnNoIconHideState
    extends State<TextAndFormFieldColumnNoIconHide> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: AppStylesManager.customTextStyleBl5,
        ),
        const SizedBox(
          height: 12,
        ),
        TextFormFieldBuilder(
          label: widget.label,
          controller: widget.controller,
          type: widget.type,
          obsecure: showPassword,
          width: screenWidth(context, 0.92),
          noIcon: true,
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
          height: widget.spaceSize ?? 40,
        ),
      ],
    );
  }
}
