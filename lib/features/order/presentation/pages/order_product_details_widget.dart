import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/features/product/presentation/widgets/image_banner.dart';

import '../../../../generated/l10n.dart';

class OrderProductDetailsWidget extends StatelessWidget {
  const OrderProductDetailsWidget({
    super.key,
    required this.images,
    required this.name,
    required this.storeName,
    required this.rating,
    required this.price,
    required this.size,
    required this.quan,
  });

  final List<String> images;
  final String name;
  final String storeName;
  final String rating;
  final String price;
  final String size;
  final String quan;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DefaultDivider(),
        ImageBanner(
          images: images,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: AppStylesManager.customTextStyleBl6,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Row(
                        children: [
                          Text(
                            storeName,
                            style: AppStylesManager.customTextStyleG9,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Icon(
                            Icons.star,
                            color: ColorManager.primaryO2,
                            size: 20,
                          ),
                          Text(rating)
                        ],
                      )
                    ],
                  ),
                  const Spacer(),
                  Text(
                    '$price ${S.of(context).le}',
                    style: AppStylesManager.customTextStyleO4,
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                children: [
                  Text(
                    '${S.of(context).size} :  ',
                    style: AppStylesManager.customTextStyleG10,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Container(
                    height: 1.sw > 600 ? 50 : 30,
                    width: 1.sw > 600 ? 50 : 30,
                    decoration: BoxDecoration(
                      color: ColorManager.primaryR2,
                      border: Border.all(
                        color: ColorManager.primaryR2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        size,
                        style: AppStylesManager.customTextStyleO,
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 3,
                  ),
                  Text(
                    '${S.of(context).color} :',
                    style: AppStylesManager.customTextStyleG10,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Container(
                    width: 1.sw > 600 ? 36 : 26,
                    height: 1.sw > 600 ? 36 : 26,
                    decoration: const BoxDecoration(
                        color: ColorManager.primaryL2, shape: BoxShape.circle),
                  ),
                  const Spacer(),
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${S.of(context).quantity}: ',
                    style: AppStylesManager.customTextStyleG10,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Container(
                    height: 1.sw > 600 ? 50 : 30,
                    width: 1.sw > 600 ? 50 : 30,
                    decoration: BoxDecoration(
                      // color: AppStyles.primaryBL,
                      border: Border.all(
                        color: ColorManager.primaryG5,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        quan,
                        style: AppStylesManager.customTextStyleO
                            .copyWith(color: ColorManager.primaryG5),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
