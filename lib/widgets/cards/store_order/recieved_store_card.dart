import 'package:flutter/material.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/resources/const_functions.dart';
import 'package:nilelon/resources/appstyles_manager.dart';

class ReceivedStoreCard extends StatelessWidget {
  const ReceivedStoreCard({
    super.key,
    required this.image,
    required this.title,
    required this.quantity,
    required this.onTap,
  });
  final String image;
  final String title;
  final String quantity;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 110,
        width: screenWidth(context, 0.9),
        decoration: BoxDecoration(
          color: ColorManager.primaryW,
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
              width: 70,
              height: 70,
              padding: const EdgeInsets.all(12),
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
                      style: AppStylesManager.customTextStyleG8,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          '$quantity items',
                          style: AppStylesManager.customTextStyleG7,
                        ),
                        const Spacer(),
                        GestureDetector(
                            onTap: () {},
                            child: Text(
                              'See Feedback',
                              style: AppStylesManager.customTextStyleO,
                            ))
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
