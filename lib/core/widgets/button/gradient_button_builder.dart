import 'package:flutter/material.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';

class GradientButtonBuilder extends StatelessWidget {
  const GradientButtonBuilder({
    super.key,
    required this.text,
    required this.ontap,
    this.width,
    this.height,
    this.isLoading,
    this.style,
    this.isIcon = false,
    this.isActivated = true,
    this.icon,
  });

  final String text;
  final VoidCallback ontap;
  final double? width;
  final bool isIcon;
  final double? height;
  final bool? isLoading;
  final TextStyle? style;
  final Widget? icon;
  final bool isActivated;

  @override
  Widget build(BuildContext context) {
    return isActivated
        ? GestureDetector(
            onTap: ontap,
            child: Center(
              child: isLoading == null || isLoading == false
                  ? Container(
                      width: width ?? screenWidth(context, 0.44),
                      height: height ?? screenHeight(context, 0.07),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                          begin: Alignment(1.00, -0.10),
                          end: Alignment(-1, 0.1),
                          colors: ColorManager.gradientColors,
                        ),
                        color: ColorManager.primaryW,
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (isIcon) ...[
                              icon ?? const SizedBox(),
                              const SizedBox(width: 10),
                            ],
                            Text(
                              text,
                              style:
                                  style ?? AppStylesManager.customTextStyleW2,
                            ),
                          ],
                        ),
                      ),
                    )
                  : Center(
                      child: Container(
                        width: width ?? screenWidth(context, 0.44),
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
            ),
          )
        : SizedBox(
            width: width ?? screenWidth(context, 0.44),
            height: height ?? screenHeight(context, 0.07),
            child: Stack(
              children: [
                Container(
                  width: width ?? screenWidth(context, 0.44),
                  height: height ?? screenHeight(context, 0.07),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      begin: Alignment(1.00, -0.10),
                      end: Alignment(-1, 0.1),
                      colors: ColorManager.gradientColors,
                    ),
                    color: ColorManager.primaryW,
                  ),
                  child: Center(
                    child: Text(
                      text,
                      style: style ?? AppStylesManager.customTextStyleW2,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: height ?? screenHeight(context, 0.07),
                  color: ColorManager.primaryW.withOpacity(0.5),
                )
              ],
            ),
          );
  }
}
