import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/widgets/replacer/image_replacer.dart';

import '../../../../core/resources/color_manager.dart';

class SearchSectionItems extends StatelessWidget {
  const SearchSectionItems({
    super.key,
    required this.image,
    required this.name,
    required this.onTap,
    this.width,
    this.height,
  });
  final String image;
  final String name;
  final void Function() onTap;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    log(image);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? screenWidth(context, 0.45),
        height: height ?? screenWidth(context, 0.45),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ColorManager.primaryW,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            imageReplacer(
              url: image,
              // width: 100,
              height: 130,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              name,
              overflow: TextOverflow.ellipsis,
              style: AppStylesManager.customTextStyleBl3,
            )
          ],
        ),
      ),
    );
  }
}
