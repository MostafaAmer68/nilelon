import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/core/widgets/cards/customer_order_management/shipped_card.dart';
import 'package:nilelon/core/widgets/shimmer_indicator/build_shimmer.dart';
import 'package:nilelon/features/order/presentation/cubit/order_cubit.dart';

import '../../../../core/widgets/scaffold_image.dart';

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
              return ListView.builder(
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
                      child: ShippedCard(order: order),
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
