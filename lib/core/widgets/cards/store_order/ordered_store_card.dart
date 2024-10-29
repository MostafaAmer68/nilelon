import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';

class OrderStoreCard extends StatelessWidget {
  const OrderStoreCard({
    super.key,
    required this.image,
    required this.title,
    required this.time,
    required this.onTap,
    required this.shippedOnTap,
  });
  final Widget image;
  final String title;
  final String time;
  final void Function() onTap;
  final void Function() shippedOnTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: screenWidth(context, 0.9),
        child: Stack(
          children: [
            Container(
              height: 1.sw > 600 ? 140 : 120,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: ColorManager.gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
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
            ),
            Positioned.fill(
              child: Container(
                clipBehavior: Clip.antiAlias,
                height: 1.sw > 600 ? 140 : 120,
                margin: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: ColorManager.primaryG10,
                  borderRadius: BorderRadius.circular(12),
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
                      decoration: const BoxDecoration(
                        color: Color(0xFFECE7FF),
                        shape: BoxShape.circle,
                      ),
                      child: image,
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
                                 DateFormat('dd-MM-yyyy').format(
                                      DateFormat('yyyy-MM-ddTHH:mm:ss.ssssss')
                                          .parse(time)),
                                  style: AppStylesManager.customTextStyleG7,
                                ),
                                const Spacer(),
                                GradientButtonBuilder(
                                  text: 'Shipped',
                                  ontap: shippedOnTap,
                                  style: AppStylesManager.customTextStyleW4,
                                  width: 120.w,
                                  height: 35.h,
                                )
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
            ),
          ],
        ),
      ),
    );
  }
}
