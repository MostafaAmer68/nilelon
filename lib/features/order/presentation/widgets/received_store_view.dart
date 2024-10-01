import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/alert/shipped_alert.dart';
import 'package:nilelon/core/widgets/cards/store_order/ordered_store_card.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/features/order/presentation/cubit/order_cubit.dart';
import 'package:nilelon/features/order/presentation/pages/order_store_details_view.dart';
import 'package:nilelon/features/order/presentation/pages/return_history_page.dart';

import '../../../../core/resources/appstyles_manager.dart';
import '../../../../core/widgets/scaffold_image.dart';

class ReceivedStoreView extends StatefulWidget {
  const ReceivedStoreView({super.key});

  @override
  State<ReceivedStoreView> createState() => _ReceivedStoreViewState();
}

class _ReceivedStoreViewState extends State<ReceivedStoreView> {
  late final OrderCubit cubit;
  @override
  void initState() {
    cubit = OrderCubit.get(context);
    if (HiveStorage.get(HiveKeys.isStore)) {
      cubit.getStoreOrder('Delivered');
    }
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
              onPressed: () {
                navigateTo(context: context, screen: const ReturnHistoryPage());
              },
              icon: const Icon(
                Icons.history,
                color: ColorManager.primaryO,
              ),
              label: Text(
                'Returned History',
                style: AppStylesManager.customTextStyleO2,
              ),
            ),
          ),
          BlocListener<OrderCubit, OrderState>(
            listener: (context, state) {
              state.mapOrNull(failure: (err) {
                BotToast.showText(text: err.errMessage);
              }, loading: (_) {
                BotToast.showLoading();
              }, success: (_) {
                BotToast.closeAllLoading();
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: cubit.storeOrders.isEmpty
                  ? Center(
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
                      itemCount: cubit.storeOrders
                          .where((e) => e.status == 'Delivered')
                          .toList()
                          .length,
                      itemBuilder: (context, index) {
                        final order = cubit.storeOrders
                            .where((e) => e.status == 'Delivered')
                            .toList()[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: OrderStoreCard(
                            image: Image.asset('assets/images/arrived2.png'),
                            title: 'Order has arrived to Customer Address.',
                            time: order.date,
                            onTap: () {
                              navigateTo(
                                  context: context,
                                  screen: OrderStoreDetailsView(
                                    id: order.id,
                                    index: 0,
                                  ));
                            },
                            shippedOnTap: () async {
                              await shippedAlert(context, order);
                            },
                          ),
                        );
                      }),
            ),
          ),
        ],
      ),
    );
  }
}
