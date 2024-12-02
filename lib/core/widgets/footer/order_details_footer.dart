import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nilelon/core/color_const.dart';
import 'package:nilelon/features/shared/pdf_view/pdf_view.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';

import '../../../features/order/data/models/order_customer_model.dart';

class OrderDetailsFooter extends StatefulWidget {
  const OrderDetailsFooter(
      {super.key, this.visible = true, required this.order});
  final bool visible;
  final OrderCustomerModel order;

  @override
  State<OrderDetailsFooter> createState() => _OrderDetailsFooterState();
}

class _OrderDetailsFooterState extends State<OrderDetailsFooter> {
  double price = 0;

  @override
  Widget build(BuildContext context) {
    price = 0;
    for (var item in widget.order.orderProductVariants) {
      price += item.price;
    }
    return Visibility(
      visible: widget.visible,
      child: Container(
        color: ColorManager.primaryW,
        width: screenWidth(context, 1),
        child: NilelonPdfView(
          location: widget.order.governate,
          orderDate: DateFormat('dd-MM-yyyy').format(widget.order.date),
          orderId: '#${widget.order.id}',
          cells: widget.order.orderProductVariants
              .map((e) => [
                    e.productName,
                    e.storeName,
                    e.quantity.toString(),
                    colroName['0x${e.color.toUpperCase()}']!,
                    e.size.toString(),
                    e.price.toString()
                  ])
              .toList(),
          netTotal: price.toString(),
          discount: widget.order.discount.toString(),
          total: widget.order.total.toString(),
          delivery: widget.order.shippingCost,
        ),
      ),
    );
  }
}
