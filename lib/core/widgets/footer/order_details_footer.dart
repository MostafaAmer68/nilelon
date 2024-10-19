import 'package:flutter/material.dart';
import 'package:nilelon/features/shared/pdf_view/pdf_view.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';

import '../../../features/order/data/models/order_customer_model.dart';

class OrderDetailsFooter extends StatelessWidget {
  const OrderDetailsFooter(
      {super.key, this.visible = true, required this.order});
  final bool visible;
  final OrderCustomerModel order;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Container(
        color: ColorManager.primaryW,
        width: screenWidth(context, 1),
        child: NilelonPdfView(
          location: order.governate,
          orderDate: order.date.toString(),
          orderId: '#${order.id}',
          cells: order.orderProductVariants
              .map((e) => [
                    e.productName,
                    e.storeName,
                    e.quantity.toString(),
                    e.color,
                    e.price.toString()
                  ])
              .toList(),
          netTotal: (order.total - order.discount).toString(),
          discount: order.discount.toString(),
          total: order.total.toString(),
          delivery: order.shippingCost,
        ),
      ),
    );
  }
}
