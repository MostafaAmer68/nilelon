import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
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
    log(image);
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
            child: CachedNetworkImage(
              imageUrl: image,
              errorWidget: (_, e, er) =>
                  Image.asset('assets/images/1-Nilelon f logo d.png'),
            ),
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
