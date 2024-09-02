import 'package:flutter/material.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';

import '../oval_shape.dart';

categoryContainer({
  required BuildContext context,
  required String image,
  required String name,
  required bool isSelected,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: CustomPaint(
      painter: CirclePainter(),
      child: isSelected
          ? Container(
              width: 100,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.shade300.withOpacity(1),
                    offset: Offset(10, 10),
                    blurRadius: 0,
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    image, // Use your own image path here
                    height: 50,
                    width: 50,
                  ),
                  SizedBox(height: 10),
                  Text(
                    name,
                    style: AppStylesManager.customTextStyleBl3,
                  ),
                ],
              ),
            )
          : Container(
              width: 100,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.shade300.withOpacity(0.7),
                    offset: Offset(10, 10),
                    blurRadius: 0,
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    image, // Use your own image path here
                    height: 50,
                    width: 50,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    name,
                    style: AppStylesManager.customTextStyleBl3,
                  ),
                ],
              ),
            ),
    ),
  );
}
