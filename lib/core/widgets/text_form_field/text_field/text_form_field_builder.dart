import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import 'package:gradient_icon/gradient_icon.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/widgets/decoration/decoration_with_fade.dart';

class TextFormFieldBuilder extends StatelessWidget {
  const TextFormFieldBuilder({
    super.key,
    required this.label,
    this.onchanged,
    required this.controller,
    required this.type,
    required this.width,
    this.suffix,
    this.onpressed,
    this.obsecure = false,
    this.color,
    this.validator,
    this.readOnly = false,
    this.prefix,
    this.isIcon = true,
    this.prefixWidget,
    this.height,
    this.noIcon = false,
    this.maxlines = true,
    this.textAlign,
    this.disabledBorder,
    this.textAlignVer,
    this.maxLength,
    this.inputFormater,
  });

  final String label;
  final Function(String)? onchanged;
  final bool? obsecure;
  final bool? isIcon;
  final bool? noIcon;
  final VoidCallback? onpressed;
  final Widget? suffix;
  final IconData? prefix;
  final Widget? prefixWidget;
  final TextEditingController? controller;
  final TextInputType? type;
  final double? width;
  final double? height;
  final Color? color;
  final String? Function(String?)? validator;
  final bool? maxlines;
  final bool readOnly;
  final TextAlign? textAlign;
  final TextAlignVertical? textAlignVer;
  final BorderSide? disabledBorder;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormater;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decorationWithFade(),
      width: width,
      height: height,
      child: TextFormField(
        textAlign: textAlign ?? TextAlign.start,
        maxLines: maxlines! ? 1 : null,
        expands: maxlines! ? false : true,
        controller: controller,
        obscureText: obsecure!,
        textAlignVertical: textAlignVer ?? TextAlignVertical.top,
        style: TextStyle(color: color),
        validator: validator,
        readOnly: readOnly,
        inputFormatters: inputFormater,
        onChanged: onchanged,
        keyboardType: type,
        maxLength: maxLength,
        decoration: InputDecoration(
          // fillColor: AppStyles.primaryW,
          // focusColor: ,
          disabledBorder: OutlineInputBorder(
            borderSide: disabledBorder ?? BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: GradientOutlineInputBorder(
            gradient: const LinearGradient(colors: ColorManager.gradientColors),
            borderRadius: BorderRadius.circular(12),
            width: 2,
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: ColorManager.primaryR),
            borderRadius: BorderRadius.circular(12),
          ),
          border: OutlineInputBorder(
            borderSide: disabledBorder ?? BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          suffixIcon: suffix,
          prefixIcon: noIcon!
              ? null
              : isIcon!
                  ? GradientIcon(
                      size: 20.sp,
                      icon: prefix!,
                      gradient: const LinearGradient(
                        colors: ColorManager.gradientColors,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ))
                  : InkWell(
                      onTap: onpressed ?? () {},
                      child: prefixWidget,
                    ),
          hintText: label,
          hintStyle: color == null
              ? AppStylesManager.customTextStyleG2
              : TextStyle(
                  color: color,
                ),
        ),
      ),
    );
  }
}
