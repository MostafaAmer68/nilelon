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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(500)),
        shadows: const [
          BoxShadow(
            spreadRadius: 2,
            blurRadius: 10,
            color: Colors.black12,
          )
        ],
      ),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Colors.transparent,
        child: imageReplacer(url: image, radius: 300, width: 80, height: 80),
      ),
    );
  }
}
