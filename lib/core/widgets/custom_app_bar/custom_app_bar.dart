import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/features/search/presentation/pages/search_view.dart';

AppBar customAppBar(
    {required String title,
    required BuildContext context,
    IconData? icon,
    GlobalKey? key,
    void Function()? onPressed,
    void Function()? leadingOnPressed,
    bool hasLeading = true,
    Color color = ColorManager.black,
    Color iconColor = ColorManager.black,
    bool hasIcon = true}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: hasLeading
        ? IconButton(
            onPressed: leadingOnPressed ?? () => navigatePop(context: context),
            icon: Icon(
              Icons.arrow_back,
              color: color,
            ))
        : Container(),
    title: Text(
      title,
      style: AppStylesManager.customTextStyleBl6.copyWith(color: color),
    ),
    centerTitle: true,
    actions: [
      hasIcon
          ? IconButton(
              key: key,
              onPressed: onPressed ??
                  () {
                    navigateTo(context: context, screen: const SearchPage());
                  },
              icon: Icon(
                icon ?? Iconsax.search_normal,
                color: iconColor,
              ),
            )
          : Container(),
    ],
  );
}
