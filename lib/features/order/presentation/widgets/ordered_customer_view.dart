import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/widgets/cards/customer_order_management/ordered_card.dart';
import 'package:nilelon/core/widgets/shimmer_indicator/build_shimmer.dart';
import 'package:nilelon/features/order/presentation/cubit/order_cubit.dart';
import 'package:nilelon/features/order/presentation/pages/order_customer_details.dart';
import 'package:svg_flutter/svg.dart';

import '../../../../core/resources/appstyles_manager.dart';
import '../../../../core/utils/navigation.dart';
import '../../../../core/widgets/scaffold_image.dart';

class OrderedCustomerView extends StatefulWidget {
  const OrderedCustomerView({super.key});

  @override
  State<OrderedCustomerView> createState() => _OrderedCustomerViewState();
}

class _OrderedCustomerViewState extends State<OrderedCustomerView> {
  late final OrderCubit cubit;
  @override
  void initState() {
    cubit = OrderCubit.get(context);
    cubit.getCustomerOrder('Ordered');
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
                              'There is no Order yet.',
                              style: AppStylesManager.customTextStyleG2,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: cubit.customerOrders
                          .where((e) => e.status == 'Ordered')
                          .toList()
                          .length,
                      itemBuilder: (context, index) {
                        final order = cubit.customerOrders
                            .where((e) => e.status == 'Ordered')
                            .toList()[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: OrderCustomerCard(
                            order: order,
                            name: 'Your package is being delivered by courier',
                            icon: SvgPicture.asset(
                                'assets/images/package accept.svg'),
                            onTap: () {
                              navigateTo(
                                  context: context,
                                  screen: OrderDetailsView(
                                    index: 0,
                                    recievedDate: '',
                                    id: order.id,
                                  ));
                            },
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
