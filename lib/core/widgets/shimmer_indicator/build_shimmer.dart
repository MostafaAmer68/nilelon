import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:shimmer/shimmer.dart';

Widget buildShimmerIndicator() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: SingleChildScrollView(
      child: Column(
        children: List.generate(10, (index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        }),
      ),
    ),
  );
}

Widget buildShimmerIndicatorSmall() {
  return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 1.sw > 600 ? 290 : 220,
          height: 1.sw > 600 ? 300 : 220,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ));
}

Widget buildShimmerIndicatorAnalyticsBigCard(context) {
  return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: screenWidth(context, 0.45),
        height: screenHeight(context, 0.22),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
      ));
}

Widget buildShimmerIndicatorAnalyticsSmallCard(context) {
  return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: screenWidth(context, 0.45),
        height: screenHeight(context, 0.106),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
      ));
}

Widget buildShimmerIndicatorGrid() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.w),
    child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1.sw > 600 ? 3 : 2,
            crossAxisSpacing: 1.sw > 600 ? 14 : 16.0,
            mainAxisExtent: 1.sw > 600 ? 300 : 220,
            mainAxisSpacing: 1.sw > 600 ? 16 : 12),
        itemCount: 10,
        shrinkWrap: true,
        itemBuilder: (context, sizeIndex) {
          return buildShimmerIndicatorSmall();
        }),
  );
}

Widget buildShimmerIndicatorRow() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: SizedBox(
      height: 1.sw > 600 ? 310 : 230,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return buildShimmerIndicatorSmall();
        },
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(right: 8),
      ),
    ),
  );
}