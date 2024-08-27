import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:svg_flutter/svg.dart';

class ShippedStoreCard extends StatelessWidget {
  const ShippedStoreCard({
    super.key,
    required this.image,
    required this.title,
    required this.time,
    required this.onTap,
  });
  final String image;
  final String title;
  final String time;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 1.sw > 600 ? 130 : 100,
        width: screenWidth(context, 0.9),
        decoration: BoxDecoration(
          color: ColorManager.primaryG10,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: ColorManager.primaryG6,
              blurRadius: 10,
              offset: Offset(0, 2),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 16,
            ),
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              width: 1.sw > 600 ? 100 : 70,
              height: 1.sw > 600 ? 100 : 70,
              // padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color(0xFFECE7FF),
                shape: BoxShape.circle,
              ),
              child: Image.asset(image, fit: BoxFit.cover),
            ),
            const SizedBox(
              width: 4,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      title,
                      style: AppStylesManager.customTextStyleBl7,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                    ),
                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          time,
                          style: AppStylesManager.customTextStyleG7,
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 25,
                          height: 25,
                          child:
                              SvgPicture.asset('assets/images/inProgress.svg'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
          ],
        ),
      ),
    );
  }
}
