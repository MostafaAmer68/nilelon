import 'package:flutter/material.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/resources/const_functions.dart';

GestureDetector addContainer(
    void Function() onTap, context, double? width, double? height) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: width ?? screenWidth(context, 0.17),
      height: height ??
          screenWidth(context, 0.21), //height ?? screenWidth(context, 0.45),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorManager.primaryB5,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Icon(
        Icons.add,
        color: ColorManager.primaryW,
        size: 40,
      ),
    ),
  );
}
