import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/utils/navigation.dart';
import 'package:nilelon/features/customer_flow/offers/offers_view.dart';

class BannerProduct extends StatefulWidget {
  final double height;
  final bool isStore;
  const BannerProduct({super.key, required this.height, required this.isStore});

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
                // enableInfiniteScroll: false,

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
                onTap: () {
                  navigateTo(
                      context: context,
                      screen: OffersView(
                        isStore: widget.isStore,
                      ));
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(
                          image: AssetImage('assets/images/banner.png'),
                          fit: BoxFit.fill)),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
