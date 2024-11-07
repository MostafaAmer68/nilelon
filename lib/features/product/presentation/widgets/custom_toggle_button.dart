import 'package:flutter/material.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';

import '../../../../core/sizes_consts.dart';

class SizeToggleButtons extends StatelessWidget {
  final List<String> sizes;
  final String selectedSize;
  final Function(String) onSizeSelected;

  const SizeToggleButtons({
    super.key,
    required this.sizes,
    required this.selectedSize,
    required this.onSizeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: screenHeight(context, 0.38),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: sizes.map((size) {
          final isSelected = size == selectedSize;
          return GestureDetector(
            onTap: () => onSizeSelected(size),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              width: 45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: !isSelected
                    ? null
                    : const LinearGradient(
                        colors: [Colors.blue, Colors.orange],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.3),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                        const BoxShadow(
                          color: Color.fromRGBO(68, 201, 225, 0.40),
                          blurRadius: 8,
                          spreadRadius: 3,
                        ),
                      ]
                    : null,
                color:
                    isSelected ? ColorManager.primaryW : ColorManager.primaryG,
              ),
              child: Container(
                width: 40,
                height: 40,
                // padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : ColorManager.primaryW,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    getSizeShortcut(size),
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.orange : Colors.grey.shade400,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
