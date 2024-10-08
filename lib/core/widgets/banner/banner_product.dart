import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/features/product/presentation/pages/product_offers_view.dart';

class BannerProduct extends StatefulWidget {
  final double height;
  final VoidCallback onTap;
  final bool isStore;
  const BannerProduct({super.key, required this.height, required this.isStore, required this.onTap});

  @override
  State<BannerProduct> createState() => _BannerProductState();
}

class _BannerProductState extends State<BannerProduct> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider.builder(
            itemCount: 1,
            options: CarouselOptions(
                height: widget.height,
                aspectRatio: 16 / 6,
                viewportFraction: 1,
                enlargeCenterPage: true,
                autoPlay: true,
                onPageChanged: (index, reason) {
                  setState(() {});
                }),
            itemBuilder: (ctx, index, _) {
              return GestureDetector(
                onTap: widget.onTap,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                        image: widget.isStore
                            ? const AssetImage(
                                'assets/images/hot picks 3_Mesa de trabajo 1 1.png')
                            : const AssetImage('assets/images/banner.png'),
                        fit: BoxFit.cover),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
