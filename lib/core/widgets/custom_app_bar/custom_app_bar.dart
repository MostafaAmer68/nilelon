import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/features/search/presentation/pages/search_view.dart';

AppBar customAppBar(
    {required String title,
    required BuildContext context,
    IconData? icon,
    void Function()? onPressed,
    void Function()? leadingOnPressed,
    bool hasLeading = true,
    bool hasIcon = true}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: hasLeading
        ? IconButton(
            onPressed: leadingOnPressed ?? () => navigatePop(context: context),
            icon: const Icon(Icons.arrow_back))
        : Container(),
    title: Text(
      title,
      style: AppStylesManager.customTextStyleBl6,
    ),
    centerTitle: true,
    actions: [
      hasIcon
          ? IconButton(
              onPressed: onPressed ??
                  () {
                    navigateTo(context: context, screen: const SearchView());
                  },
              icon: Icon(
                icon ?? Iconsax.search_normal,
              ),
            )
          : Container(),
    ],
  );
}
