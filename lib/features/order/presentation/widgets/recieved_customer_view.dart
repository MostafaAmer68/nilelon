import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/widgets/cards/customer_order_management/ordered_card.dart';
import 'package:nilelon/core/widgets/shimmer_indicator/build_shimmer.dart';
import 'package:nilelon/features/order/presentation/cubit/order_cubit.dart';
import 'package:nilelon/features/order/presentation/pages/order_store_details_view.dart';

import '../../../../core/resources/appstyles_manager.dart';
import '../../../../core/utils/navigation.dart';
import '../../../../core/widgets/scaffold_image.dart';

class ReceivedCustomerView extends StatefulWidget {
  const ReceivedCustomerView({super.key});

  @override
  State<ReceivedCustomerView> createState() => _ReceivedCustomerViewState();
}

class _ReceivedCustomerViewState extends State<ReceivedCustomerView> {
  late final OrderCubit cubit;
  @override
  void initState() {
    cubit = OrderCubit.get(context);
    cubit.getCustomerOrder('Received');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldImage(
      body: Column(
        children: [
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: TextButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.history,
                color: ColorManager.primaryO,
              ),
              label: Text(
                'Refund History',
                style: AppStylesManager.customTextStyleO2,
              ),
            ),
          ),
          BlocBuilder<OrderCubit, OrderState>(
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
                              .where((e) => e.status == 'Received')
                              .toList()
                              .length,
                          itemBuilder: (context, index) {
                            final order = cubit.customerOrders
                                .where((e) => e.status == 'Received')
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
                                name:
                                    'Your package has arrived at your destination',
                                icon: Image.asset('assets/images/arrived2.png'),
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
        ],
      ),
    );
  }
}
