import 'package:flutter/material.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/widgets/replacer/image_replacer.dart';

class CategoryItems extends StatelessWidget {
  const CategoryItems({
    super.key,
    required this.image,
    required this.name,
    required this.onTap,
    this.width,
    this.height,
  });
  final String image;
  final String name;
  final void Function() onTap;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 230,
        child: Column(
          children: [
            Container(
              width: width ?? screenWidth(context, 0.42),
              height: 190, //height ?? screenWidth(context, 0.45),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: ColorManager.primaryB5,
                borderRadius: BorderRadius.circular(16),
              ),
              child: imageReplacer(url: image, fit: BoxFit.fitWidth),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.add,
                  size: 20,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  '${lang.add} $name',
                  style: AppStylesManager.customTextStyleBl3,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
