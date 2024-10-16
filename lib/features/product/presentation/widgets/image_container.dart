import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/widgets/replacer/image_replacer.dart';

GestureDetector imageContainer(void Function() onTap, String file, context,
    double? width, double? height) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: width ?? screenWidth(context, 0.21),
      height: height ?? screenWidth(context, 0.17),
      // padding: const EdgeInsets.all(16),
      // decoration: BoxDecoration(
      //   color: ColorManager.primaryB5,
      //   borderRadius: BorderRadius.circular(16),
      // ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: file.contains('https') || file.contains('http')
            ? imageReplacer(url: file)
            : Image.file(File(file)),
      ),
    ),
  );
}
