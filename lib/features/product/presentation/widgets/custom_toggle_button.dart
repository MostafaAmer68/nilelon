import 'package:flutter/material.dart';
import 'package:nilelon/core/resources/const_functions.dart';

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
      height: 55,
      width: screenHeight(context, 0.33),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: sizes.map((size) {
          final isSelected = size == selectedSize;
          return GestureDetector(
            onTap: () => onSizeSelected(size),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              width: 80,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: isSelected ? Colors.orange : Colors.grey.shade300,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                        BoxShadow(
                          color: Colors.cyanAccent.withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 3,
                        ),
                      ]
                    : null,
                color: isSelected ? Colors.white : Colors.transparent,
              ),
              child: Text(
                size,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.orange : Colors.grey.shade400,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
