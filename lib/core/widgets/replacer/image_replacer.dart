import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

Widget imageReplacer(
    {required String url, double? width, double? height, BoxFit? fit}) {
  return CachedNetworkImage(
    width: width,
    height: height,
    fit: fit ?? BoxFit.cover,
    placeholder: (context, _) {
      return Image.asset(
        "assets/images/placeholder.png",
        // height: height ?? 40.h,
        // width: width ?? 40.w,
        fit: fit ?? BoxFit.cover,
      );
    },
    errorWidget: (context, e, _) {
      return Image.asset(
        "assets/images/placeholder.png",
        // height: height ?? 40.h,
        // width: width ?? 40.w,
        fit: fit ?? BoxFit.cover,
      );
    },
    imageUrl: url,
  );
}
