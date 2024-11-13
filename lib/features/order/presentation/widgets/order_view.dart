import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/tools.dart';
import 'package:nilelon/features/order/data/models/order_model.dart';
import 'package:nilelon/features/order/presentation/pages/order_store_details_view.dart';
import 'package:nilelon/features/order/presentation/widgets/ordered_card.dart';
import 'package:nilelon/features/order/presentation/widgets/ordered_store_card.dart';
import 'package:nilelon/core/widgets/shimmer_indicator/build_shimmer.dart';
import 'package:nilelon/features/order/presentation/cubit/order_cubit.dart';
import 'package:nilelon/features/order/presentation/pages/order_customer_details.dart';
import '../../../../core/resources/appstyles_manager.dart';
import '../../../../core/utils/navigation.dart';
import '../../../../core/widgets/scaffold_image.dart';

class OrderView extends StatefulWidget {
  const OrderView({
    super.key,
    required this.onTapHistory,
    required this.status,
    required this.image,
    required this.title,
  });
  final VoidCallback onTapHistory;
  final String status;
  final Widget image;
  final String title;
  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  late final OrderCubit cubit;
  @override
  void initState() {
    cubit = OrderCubit.get(context);
    if (HiveStorage.get(HiveKeys.isStore)) {
      cubit.getStoreOrder(widget.status);
    } else {
      cubit.getCustomerOrder(widget.status);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldImage(
      body: Column(
        children: [
          Visibility(
            visible: widget.status == 'Delivered',
            child: Align(
              alignment: AlignmentDirectional.topEnd,
              child: TextButton.icon(
                onPressed: widget.onTapHistory,
                icon: const Icon(
                  Icons.history,
                  color: ColorManager.primaryO,
                ),
                label: Text(
                  lang(context).refundHistory,
                  style: AppStylesManager.customTextStyleO2,
                ),
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
                  if (cubit.orders.isEmpty) {
                    return SizedBox(
                      height: screenHeight(context, 0.6),
                      child: Center(
                        child: Text(
                          lang(context).noOrder,
                          style: AppStylesManager.customTextStyleG2,
                        ),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: GroupedListView<OrderModel, String>(
                          // shrinkWrap: true,
                          elements: cubit.orders
                              .where((e) => e.status == widget.status)
                              .toList(),
                          order: GroupedListOrder.ASC,
                          groupBy: (OrderModel e) => DateFormat('dd-MM-yyyy')
                              .format(DateFormat('yyyy-MM-ddTHH:mm:ss.ssssss')
                                  .parse(e.date)),
                          groupSeparatorBuilder: (String groupByValue) =>
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    groupByValue,
                                    style: AppStylesManager.customDateStyle
                                        .copyWith(fontSize: 14.sp),
                                  ),
                                ),
                              ),
                          itemBuilder: (context, order) {
                            if (HiveStorage.get(HiveKeys.isStore)) {
                              return OrderStoreCard(
                                image: widget.image,
                                title: widget.title,
                                order: order,
                                onTap: () {
                                  navigateTo(
                                      context: context,
                                      screen: OrderStoreDetailsView(
                                        index: 2,
                                        // recievedDate: order.date,
                                        id: order.id,
                                      ));
                                },
                                shippedOnTap: () {
                                  OrderCubit.get(context).changeOrderStatus(
                                      order.id, 'Shipped', true);
                                  OrderCubit.get(context)
                                      .getStoreOrder(widget.status);
                                },
                              );
                            }
                            return OrderCustomerCard(
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
                              name: widget.title,
                              icon: widget.image,
                            );
                          }),
                    );
                  }
                },
                loading: () {
                  return buildShimmerIndicator();
                },
              )!;
            },
          ),
        ],
      ),
    );
  }
}
