import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/features/product/presentation/widgets/image_banner.dart';

import '../../../../core/sizes_consts.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/order_store_model.dart';

class OrderProductDetailsWidget extends StatelessWidget {
  const OrderProductDetailsWidget({
    super.key,
    required this.product,
  });

  final OrderProductVariant product;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DefaultDivider(),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: ImageBanner(
            images: product.urls,
            height: 200.w,
          ),
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
                        product.productName,
                        style: AppStylesManager.customTextStyleBl2,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Row(
                        children: [
                          Text(
                            product.storeName,
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
                          Text(product.productRate.toString())
                        ],
                      )
                    ],
                  ),
                  const Spacer(),
                  Text(
                    '${product.price} ${S.of(context).le}',
                    style: AppStylesManager.customTextStyleO4,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
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
                  borderContainer(getSizeShortcut(product.size)),
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
                      color: ColorManager.primaryL2,
                      shape: BoxShape.circle,
                    ),
                  ),
                  // const Spacer(),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${S.of(context).quantity.substring(0, 4)}: ',
                    style: AppStylesManager.customTextStyleG10,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  borderContainer(product.quantity.toString())
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Container borderContainer(String t) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      width: 35,
      height: 35,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          colors: [Colors.blue, Colors.orange],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.3),
            blurRadius: 8,
            spreadRadius: 1,
          ),
          const BoxShadow(
            color: Color.fromRGBO(68, 201, 225, 0.40),
            blurRadius: 8,
            spreadRadius: 3,
          ),
        ],
        color: ColorManager.primaryW,
      ),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: ColorManager.primaryW,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            t,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.orange),
          ),
        ),
      ),
    );
  }
}
