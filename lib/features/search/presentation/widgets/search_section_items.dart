import 'package:flutter/material.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';

class SearchSectionItems extends StatelessWidget {
  const SearchSectionItems({
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
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: width ?? screenWidth(context, 0.45),
            height: height ?? screenWidth(context, 0.45),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              // color: AppStyles.primaryB5,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Image.network(image),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            name,
            style: AppStylesManager.customTextStyleBl3,
          )
        ],
      ),
    );
  }
}
