import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/constants/assets.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/widgets/scaffold_image.dart';
import 'package:nilelon/features/order/presentation/cubit/order_cubit.dart';
import 'package:nilelon/generated/l10n.dart';

import '../../../../core/resources/appstyles_manager.dart';

class OrderedSuccessPage extends StatefulWidget {
  const OrderedSuccessPage({super.key});

  @override
  State<OrderedSuccessPage> createState() => _OrderedSuccessPageState();
}

class _OrderedSuccessPageState extends State<OrderedSuccessPage> {
  late final OrderCubit cubit;
  @override
  void initState() {
    cubit = OrderCubit.get(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldImage(
      body: Column(
        children: [
          Image.asset(
            Assets.assetsImagesInvoice,
            width: screenWidth(context, 0.5),
          ),
          const SizedBox(height: 20),
          Text(
            S.of(context).thankYouForOrdering,
            style: AppStylesManager.customTextStyleBl13
                .copyWith(fontSize: 25.sp, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            S.of(context).youCanDownloadYourReceiptToViewYourOrderDetails,
            style: AppStylesManager.customTextStyleG,
          ),
          const SizedBox(height: 300),
          // NilelonPdfView(
          //   location: cubit.addressLine1.text,
          //   orderDate:DateTime.now().toString(),
          //   orderId: '#${order.id}',
          //   cells: order.orderProductVariants
          //       .map((e) => [
          //             e.productName,
          //             e.storeName,
          //             e.quantity.toString(),
          //             e.color,
          //             e.price.toString()
          //           ])
          //       .toList(),
          //   netTotal: (order.total - order.discount).toString(),
          //   discount: order.discount.toString(),
          //   total: order.total.toString(),
          //   delivery: order.shippingCost,
          // )
        ],
      ),
    );
  }
}
