import 'package:flutter/material.dart';

import '../../../../core/resources/const_functions.dart';

class ColorSelector extends StatelessWidget {
  final List<String> colors;
  final String selectedColor;
  final Function(String) onColorSelected;

  const ColorSelector({
    super.key,
    required this.colors,
    required this.selectedColor,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: screenHeight(context, 0.33),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: colors.map((color) {
          final isSelected = color == selectedColor;
          return GestureDetector(
            onTap: () => onColorSelected(color),
            child: Container(
              // width: 40,
              // height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: isSelected
                    ? Border.all(
                        color: Colors.orange,
                        width: 3,
                      )
                    : null,
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(int.parse('0x$color')),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
