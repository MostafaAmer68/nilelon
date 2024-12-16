import 'package:flutter/material.dart';

class GradientCheckBox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const GradientCheckBox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!value); // Toggle the checkbox state
      },
      child: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          gradient: value
              ? const LinearGradient(
                  colors: [Colors.cyan, Colors.orange],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: value ? null : Colors.grey[300], // Background when unchecked
          borderRadius: BorderRadius.circular(7),
          border: Border.all(
            color: value
                ? Colors.transparent
                : Colors.grey, // Border when unchecked
            width: 2,
          ),
        ),
        child: value
            ? const Icon(
                Icons.check,
                color: Colors.white,
                size: 20,
              )
            : null, // Show the checkmark when checked
      ),
    );
  }
}
