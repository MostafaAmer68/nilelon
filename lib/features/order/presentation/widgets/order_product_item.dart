// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:nilelon/core/constants/assets.dart';

import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/features/order/data/models/order_customer_model.dart';

class OrderDetailsCard extends StatelessWidget {
  const OrderDetailsCard({
    super.key,
    required this.product,
  });
  final OrderProductVariant product;
  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Container(
      width: screenWidth(context, 0.92),
      decoration: ShapeDecoration(
        color: ColorManager.primaryW,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        shadows: const [
          BoxShadow(
            color: Color(0x38006577),
            blurRadius: 8,
            offset: Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Container(
            width: 90,
            height: 110,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                    image: AssetImage(Assets.assetsImagesCloth1),
                    fit: BoxFit.cover)),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.productName,
                          style: AppStylesManager.customTextStyleBl8,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            Text(
                              product.storeName,
                              style: AppStylesManager.customTextStyleG5,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            const Icon(
                              Icons.star,
                              color: ColorManager.primaryO2,
                              size: 20,
                            ),
                            Text(
                              product.productRate.toString(),
                              style: AppStylesManager.customTextStyleG6,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      product.price.toString(),
                      style: AppStylesManager.customTextStyleO3,
                    ),
                    const SizedBox(
                      width: 8,
                    )
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    Text(
                      lang.size,
                      style: AppStylesManager.customTextStyleG13,
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: ColorManager.primaryR2,
                        border: Border.all(
                          color: ColorManager.primaryR2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          product.size[0],
                          style: AppStylesManager.customTextStyleO,
                        ),
                      ),
                    ),
                    const Spacer(
                      flex: 3,
                    ),
                    Text(
                      'Qun: ',
                      style: AppStylesManager.customTextStyleG13,
                    ),
                    Text(
                      product.quantity.toString(),
                      style: AppStylesManager.customTextStyleBl9
                          .copyWith(fontSize: 10),
                    ),
                    const Spacer(
                      flex: 3,
                    ),
                    Text(
                      'Color:  ',
                      style: AppStylesManager.customTextStyleG13,
                    ),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          color: Color(int.parse('0x${product.color}')),
                          shape: BoxShape.circle),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
