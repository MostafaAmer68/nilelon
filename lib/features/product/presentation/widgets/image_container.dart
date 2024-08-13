import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/resources/const_functions.dart';

GestureDetector imageContainer(
    void Function() onTap, File file, context, double? width, double? height) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: width ?? screenWidth(context, 0.21),
      height: height ?? screenWidth(context, 0.21),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: ColorManager.primaryB5,
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(image: FileImage(file), fit: BoxFit.fill)),
    ),
  );
}
