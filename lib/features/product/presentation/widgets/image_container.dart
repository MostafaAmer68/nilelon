import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';

GestureDetector imageContainer(void Function() onTap, String file, context,
    double? width, double? height) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: width ?? screenWidth(context, 0.21),
      height: height ?? screenWidth(context, 0.17),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorManager.primaryB5,
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: file.contains('https')
              ? NetworkImage(file)
              : FileImage(File(file)),
          fit: BoxFit.fill,
        ),
      ),
    ),
  );
}
