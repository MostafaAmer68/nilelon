import 'package:flutter/material.dart';
import 'package:nilelon/resources/appstyles_manager.dart';
import 'package:nilelon/resources/color_manager.dart';

class OutlinedButtonBuilder extends StatelessWidget {
  const OutlinedButtonBuilder(
      {super.key,
      required this.text,
      required this.ontap,
      this.width,
      this.height,
      this.style,
      this.buttonColor,
      this.isLoading,
      this.frameColor,
      this.withIcon,
      this.iconData});

  final String text;
  final VoidCallback ontap;
  final double? width;
  final double? height;
  final TextStyle? style;
  final bool? isLoading;
  final bool? withIcon;
  final IconData? iconData;
  final Color? buttonColor;
  final Color? frameColor;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: ontap,
      child: isLoading == true
          ? Center(
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
            )
          : withIcon == true
              ? Center(
                  child: Container(
                    width: width ?? screenWidth * 0.44,
                    height: height ?? screenHeight * 0.07,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: frameColor ?? ColorManager.primaryB2),
                      borderRadius: BorderRadius.circular(10),
                      color: buttonColor ?? ColorManager.primaryW,
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            iconData,
                            color: ColorManager.primaryB2,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            text,
                            style: style ??
                                AppStylesManager.customTextStyleW2
                                    .copyWith(color: ColorManager.primaryB2),
                          ),
                        ],
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
                          color: frameColor ?? ColorManager.primaryB2),
                      borderRadius: BorderRadius.circular(10),
                      color: buttonColor ?? ColorManager.primaryW,
                    ),
                    child: Center(
                      child: Text(
                        text,
                        style: style ??
                            AppStylesManager.customTextStyleW2
                                .copyWith(color: ColorManager.primaryB2),
                      ),
                    ),
                  ),
                ),
    );
  }
}
