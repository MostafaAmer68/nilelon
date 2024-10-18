import 'package:flutter/material.dart';
import 'package:nilelon/core/widgets/replacer/image_replacer.dart';

class ProfileAvater extends StatelessWidget {
  const ProfileAvater({super.key, required this.image, this.radius = 50});
  final String image;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(500),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x33726363),
            blurRadius: 16,
            offset: Offset(0, 1),
            spreadRadius: 0,
          )
        ],
      ),
      child: CircleAvatar(
        radius: radius,
        child: imageReplacer(url: image, radius: 300, width: 80, height: 80),
      ),
    );
  }
}
