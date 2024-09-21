import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/widgets/shimmer_indicator/build_shimmer.dart';
import 'package:nilelon/features/order/presentation/cubit/order_cubit.dart';
import 'package:svg_flutter/svg.dart';

import '../../../../core/resources/appstyles_manager.dart';
import '../../../../core/utils/navigation.dart';
import '../../../../core/widgets/cards/customer_order_management/ordered_card.dart';
import '../../../../core/widgets/scaffold_image.dart';
import '../pages/order_store_details_view.dart';

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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'There is no Order yet.',
                            style: AppStylesManager.customTextStyleG2,
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
                                  screen: OrderStoreDetailsView(
                                    index: 2,
                                    id: order.id,
                                  ));
                            },
                            name: 'Your package is being delivered by courier',
                            icon: SvgPicture.asset(
                                'assets/images/inProgress.svg'),
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
