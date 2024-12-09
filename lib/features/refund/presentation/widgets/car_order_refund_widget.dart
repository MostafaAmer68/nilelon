// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:nilelon/core/widgets/replacer/image_replacer.dart';
import 'package:nilelon/features/refund/presentation/cubit/refund_cubit.dart';

import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/features/order/data/models/order_customer_model.dart';

import 'custom_check_box.dart';

class OrderRefundDetailsCard extends StatefulWidget {
  const OrderRefundDetailsCard({
    super.key,
    required this.product,
    this.onSelected,
  });
  final OrderProductVariant product;
  final VoidCallback? onSelected;
  @override
  State<OrderRefundDetailsCard> createState() => _OrderRefundDetailsCardState();
}

class _OrderRefundDetailsCardState extends State<OrderRefundDetailsCard> {
  late final RefundCubit cubit;
  @override
  void initState() {
    cubit = RefundCubit.get(context);
    super.initState();
  }

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
            color: ColorManager.primaryO3,
            blurRadius: 0,
            offset: Offset(3, 3),
            spreadRadius: 0,
          ),
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          imageReplacer(
            url: widget.product.urls.first,
            radius: 15,
            width: 100,
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
                          widget.product.productName,
                          style: AppStylesManager.customTextStyleBl8,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            Text(
                              '${widget.product.price} ${S.of(context).le}',
                              style: AppStylesManager.customTextStyleO3,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Visibility(
                      visible: widget.product.storeName.isNotEmpty,
                      child: GradientCheckBox(
                        value: cubit.selectedProducts.isEmpty
                            ? false
                            : cubit.selectedProducts.contains(widget.product),
                        onChanged: (value) {
                          if (value) {
                            if (cubit.selectedProducts.isNotEmpty) {
                              final index = cubit.selectedProducts
                                  .indexWhere((e) => e == widget.product);
                              cubit.selectedProducts
                                  .insert(index, widget.product);
                            } else {
                              cubit.selectedProducts.add(widget.product);
                            }
                          } else {
                            cubit.selectedProducts.remove(widget.product);
                          }
                          if(widget.onSelected != null){
                              widget.onSelected!();
                          }
                          setState(() {});
                        },
                      ),
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
                    const SizedBox(width: 5),
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
                          widget.product.size[0],
                          style: AppStylesManager.customTextStyleO,
                        ),
                      ),
                    ),
                    const Spacer(
                      flex: 3,
                    ),
                    Text(
                      '${S.of(context).quantity}: ',
                      style: AppStylesManager.customTextStyleG13,
                    ),
                    Text(
                      widget.product.quantity.toString(),
                      style: AppStylesManager.customTextStyleBl9
                          .copyWith(fontSize: 10),
                    ),
                    const Spacer(
                      flex: 3,
                    ),
                    Text(
                      '${S.of(context).color}:  ',
                      style: AppStylesManager.customTextStyleG13,
                    ),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          color: Color(int.parse('0x${widget.product.color}')),
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
