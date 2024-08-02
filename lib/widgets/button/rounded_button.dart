import 'package:flutter/material.dart';
import 'package:nilelon/resources/appstyles_manager.dart';
import 'package:nilelon/resources/color_manager.dart';

class RoundedButtonBuilder extends StatelessWidget {
  const RoundedButtonBuilder({
    super.key,
    required this.text,
    required this.ontap,
    this.style,
    required this.textColor,
  });

  final String text;
  final VoidCallback ontap;
  final Color textColor;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: ontap,
      child: Center(
        child: Container(
          width: screenWidth * 0.3,
          height: screenHeight * 0.04,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.circular(50),
              color: ColorManager.primaryW),
          child: Center(
            child: Text(
              text,
              style: style ??
                  AppStylesManager.customTextStyleW2
                      .copyWith(color: textColor, fontSize: 12),
            ),
          ),
        ),
      ),
    );
  }
}
