import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:svg_flutter/svg.dart';

class ViewAllRow extends StatelessWidget {
  const ViewAllRow(
      {super.key,
      this.text,
      this.onPressed,
      this.buttonText,
      this.buttonWidget,
      this.noButton = false,
      this.noText = false,
      this.noPadding = false,
      this.style,
      this.noTextIcon = true,
      this.assetName,
      this.isStyled = true});
  final String? text;
  final void Function()? onPressed;
  final String? buttonText;
  final Widget? buttonWidget;
  final bool noButton;
  final bool isStyled;
  final bool noText;
  final bool noTextIcon;
  final bool noPadding;
  final TextStyle? style;
  final String? assetName;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: noPadding
          ? EdgeInsets.zero
          : EdgeInsets.only(left: 16.sp, right: 16.sp, bottom: 8.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          noText
              ? Container()
              : noTextIcon
                  ? Text(
                      text!,
                      style: style ?? AppStylesManager.customTextStyleBl6,
                    )
                  : Row(
                      children: [
                        SizedBox(
                            width: 20.w,
                            height: 20.w,
                            child: SvgPicture.asset(assetName!)),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          text!,
                          style: style ?? AppStylesManager.customTextStyleBl6,
                        ),
                      ],
                    ),
          noButton
              ? Container()
              : GestureDetector(
                  onTap: onPressed,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 10,
                    ),
                    decoration: isStyled
                        ? BoxDecoration(
                            color: ColorManager.primaryW,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                color: ColorManager.primaryY,
                                offset: Offset(5, 5),
                              ),
                            ],
                          )
                        : null,
                    child: buttonWidget ??
                        Row(
                          children: [
                            Text(
                              buttonText ?? S.of(context).viewAll,
                              style: AppStylesManager.customTextStyleO,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: ColorManager.primaryO,
                              size: 12.r,
                            )
                          ],
                        ),
                  )),
        ],
      ),
    );
  }
}
