import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';

class ReturnedCustomerCard extends StatelessWidget {
  const ReturnedCustomerCard({
    super.key,
    required this.image,
    required this.title,
    required this.time,
    required this.onTap,
  });
  final Widget image;
  final String title;
  final String time;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: screenWidth(context, 0.9),
        child: Container(
          clipBehavior: Clip.antiAlias,
          height: 1.sw > 600 ? 120 : 100,
          margin: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: ColorManager.primaryW,
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
                width: 1.sw > 600 ? 80 : 50,
                height: 1.sw > 600 ? 80 : 50,
                decoration: const BoxDecoration(
                  color: Color(0xFFECE7FF),
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: image,
                ),
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
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            time,
                            style: AppStylesManager.customTextStyleG7,
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
      ),
    );
  }
}
