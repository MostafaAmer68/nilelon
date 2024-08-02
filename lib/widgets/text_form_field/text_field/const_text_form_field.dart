import 'package:flutter/material.dart';
import 'package:nilelon/resources/appstyles_manager.dart';

class ConstTextFieldBuilder extends StatelessWidget {
  const ConstTextFieldBuilder({
    super.key,
    required this.label,
    required this.width,
    this.color,
    this.prefixWidget,
    this.height,
    this.style,
    this.textAlign,
    this.disabledBorder,
    this.textAlignVertical,
  });
  final String label;
  final double width;
  final Color? color;
  final Widget? prefixWidget;
  final double? height;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextAlignVertical? textAlignVertical;
  final BorderSide? disabledBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: const Color(0xFFFBF9F9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x33726363),
            blurRadius: 16,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      width: width,
      height: height,
      child: TextFormField(
        textAlign: textAlign ?? TextAlign.start,
        textAlignVertical: textAlignVertical ?? TextAlignVertical.center,
        style: TextStyle(
          color: color,
        ),
        readOnly: true,
        enabled: false,
        // autofocus: false,
        decoration: InputDecoration(
          prefixIcon: prefixWidget,
          border: OutlineInputBorder(
            borderSide: disabledBorder ?? BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: disabledBorder ?? BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          label: Center(
              child: Text(label,
                  style: style ?? AppStylesManager.customTextStyleG2)),
        ),
      ),
    );
  }
}
