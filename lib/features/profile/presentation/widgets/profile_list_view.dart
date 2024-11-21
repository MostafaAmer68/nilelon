import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:svg_flutter/svg.dart';

class ProfileListTile extends StatelessWidget {
  const ProfileListTile({
    super.key,
    required this.name,
    required this.image,
    required this.onTap,
    this.trailingWidget,
    this.isRed = false,
  });
  final String name;
  final String image;
  final void Function() onTap;
  final Widget? trailingWidget;
  final bool isRed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        title: Text(
          name,
          style: isRed
              ? AppStylesManager.customTextStyleBl9.copyWith(
                  color: ColorManager.primaryR,
                )
              : AppStylesManager.customTextStyleBl9,
        ),
        horizontalTitleGap: 7,
        trailing: trailingWidget ??
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: isRed ? ColorManager.primaryR : ColorManager.primaryBL2,
            ),
        leading: SizedBox(
          width: 20.w,
          height: 20.w,
          child: SvgPicture.asset(image),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 4.h),
      ),
    );
  }
}
