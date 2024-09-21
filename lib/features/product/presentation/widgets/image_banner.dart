import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/widgets/replacer/image_replacer.dart';

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
            return widget.images.isEmpty
                ? Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                            image: AssetImage(
                                'assets/images/1-Nilelon f logo d.png'),
                            fit: BoxFit.cover)),
                  )
                : imageReplacer(
                    url: widget.images[index],
                    height: screenHeight(context, 0.5),
                    width: double.infinity,
                  );
          },
        ),
      ],
    );
  }
}
