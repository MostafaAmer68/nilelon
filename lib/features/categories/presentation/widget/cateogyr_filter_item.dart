import 'package:flutter/material.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';

import '../../../../core/resources/color_manager.dart';

class CategoryFilterItem extends StatelessWidget {
  const CategoryFilterItem(
      {super.key,
      required this.name,
      required this.isSelected,
      required this.onTap});
  final String name;
  final bool isSelected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          decoration: !isSelected
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: ColorManager.primaryB2))
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: ColorManager.primaryW,
                  boxShadow: const [
                    BoxShadow(
                      color: ColorManager.primaryO2,
                      offset: Offset(5, 5),
                    ),
                  ],
                  border: Border.all(color: ColorManager.primaryL),
                ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Center(
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: AppStylesManager.customTextStyleB4,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
