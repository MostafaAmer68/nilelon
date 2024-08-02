import 'package:flutter/material.dart';
import 'package:nilelon/resources/color_manager.dart';

class SmallButton extends StatelessWidget {
  const SmallButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.color,
  });
  final IconData icon;
  final Color? color;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: ShapeDecoration(
          color: Colors.white,
          shadows: const [
            BoxShadow(
              color: ColorManager.primaryG6,
              blurRadius: 4,
              offset: Offset(0, 2),
              spreadRadius: 0,
            )
          ],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Icon(
            icon,
            size: 20,
            color: color,
          ),
        ),
      ),
    );
  }
}
