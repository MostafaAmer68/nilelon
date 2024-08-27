import 'package:flutter/material.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';

class ButtonBuilder extends StatelessWidget {
  const ButtonBuilder({
    super.key,
    required this.text,
    required this.ontap,
    this.width,
    this.height,
    this.style,
    this.buttonColor,
    this.isLoading,
    this.frameColor,
    this.isActivated = true,
  });

  final String text;
  final VoidCallback ontap;
  final double? width;
  final double? height;
  final TextStyle? style;
  final bool? isLoading;

  final Color? buttonColor;
  final Color? frameColor;
  final bool isActivated;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return isActivated
        ? GestureDetector(
            onTap: ontap,
            child: isLoading == null || isLoading == false
                ? Center(
                    child: Container(
                      width: width ?? screenWidth * 0.44,
                      height: height ?? screenHeight * 0.07,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: frameColor ??
                                buttonColor ??
                                ColorManager.primaryB2),
                        borderRadius: BorderRadius.circular(10),
                        color: buttonColor ?? ColorManager.primaryB2,
                      ),
                      child: Center(
                        child: Text(
                          text,
                          style: style ?? AppStylesManager.customTextStyleW2,
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: Container(
                      width: width ?? screenWidth * 0.44,
                      height: height ?? 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: ColorManager.primaryG3,
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
          )
        : Center(
            child: Container(
              width: width ?? screenWidth * 0.44,
              height: height ?? screenHeight * 0.07,
              decoration: BoxDecoration(
                border: Border.all(
                    color: frameColor != null
                        ? frameColor!.withOpacity(0)
                        : buttonColor != null
                            ? buttonColor!.withOpacity(0)
                            : ColorManager.primaryB2.withOpacity(0)),
                borderRadius: BorderRadius.circular(10),
                color: buttonColor ?? ColorManager.primaryB2.withOpacity(0.5),
              ),
              child: Center(
                child: Text(
                  text,
                  style: style ?? AppStylesManager.customTextStyleW2,
                ),
              ),
            ),
          );
  }
}
