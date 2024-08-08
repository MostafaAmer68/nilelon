import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nilelon/resources/const_functions.dart';

class ImageBanner extends StatefulWidget {
  final List<String> images;
  const ImageBanner({
    super.key,
    required this.images,
  });

  @override
  State<ImageBanner> createState() => _ImageBannerState();
}

class _ImageBannerState extends State<ImageBanner> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CarouselSlider.builder(
          itemCount: widget.images.length,
          options: CarouselOptions(
              aspectRatio: 1,
              viewportFraction: 1,
              height: screenHeight(context, 0.5),
              enlargeCenterPage: true,
              autoPlay: true,
              onPageChanged: (index, reason) {
                setState(() {});
              }),
          itemBuilder: (ctx, index, _) {
            return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                      image: AssetImage(widget.images[index]),
                      fit: BoxFit.cover)),
            );
          },
        ),
      ],
    );
  }
}
