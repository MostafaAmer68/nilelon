import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/constants/assets.dart';
import 'package:nilelon/core/tools.dart';
import 'package:nilelon/core/widgets/shimmer_indicator/build_shimmer.dart';
import 'package:nilelon/features/order/presentation/cubit/order_cubit.dart';
import 'package:svg_flutter/svg.dart';

import '../../../../core/resources/appstyles_manager.dart';
import '../../../../core/utils/navigation.dart';
import '../../../../core/widgets/cards/customer_order_management/ordered_card.dart';
import '../../../../core/widgets/scaffold_image.dart';
import '../pages/order_customer_details.dart';

class ShippedCustomerView extends StatefulWidget {
  const ShippedCustomerView({super.key});

  @override
  State<ShippedCustomerView> createState() => _ShippedCustomerViewState();
}

class _ShippedCustomerViewState extends State<ShippedCustomerView> {
  late final OrderCubit cubit;
  @override
  void initState() {
    cubit = OrderCubit.get(context);
    cubit.getCustomerOrder('Shipped');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldImage(
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          return state.whenOrNull(
            failure: (e) {
              return const Icon(Icons.error);
            },
            success: () {
              return cubit.customerOrders.isEmpty
                  ? SizedBox(
                      height: 120.h,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              lang(context).noOrder,
                              style: AppStylesManager.customTextStyleG2,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: cubit.customerOrders
                          .where((e) => e.status == 'Shipped')
                          .toList()
                          .length,
                      itemBuilder: (context, index) {
                        final order = cubit.customerOrders
                            .where((e) => e.status == 'Shipped')
                            .toList()[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: OrderCustomerCard(
                            order: order,
                            onTap: () {
                              navigateTo(
                                  context: context,
                                  screen: OrderDetailsView(
                                    index: 2,
                                    recievedDate: order.date,
                                    id: order.id,
                                  ));
                            },
                            name: lang(context).orderHasDelivered,
                            icon:
                                SvgPicture.asset(Assets.assetsImagesInProgress),
                          ),
                        );
                      });
            },
            loading: () {
              return ListView.builder(
                itemCount: 9,
                itemBuilder: (context, index) {
                  return buildShimmerIndicatorSmall();
                },
              );
            },
          )!;
        },
      ),
    );
  }
}
