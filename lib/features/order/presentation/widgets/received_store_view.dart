import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/alert/shipped_alert.dart';
import 'package:nilelon/core/widgets/cards/store_order/ordered_store_card.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/features/order/presentation/cubit/order_cubit.dart';
import 'package:nilelon/features/order/presentation/pages/ordered_store_details_view.dart';

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
      cubit.getStoreOrder('Received');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldImage(
      body: BlocListener<OrderCubit, OrderState>(
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
              ? SizedBox(
                  height: 120.h,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'There is no Order yet.',
                          style: AppStylesManager.customTextStyleG2,
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: cubit.storeOrders
                      .where((e) => e.status == 'Received')
                      .toList()
                      .length,
                  itemBuilder: (context, index) {
                    final order = cubit.storeOrders
                        .where((e) => e.status == 'Received')
                        .toList()[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: OrderedCard(
                        image: Image.asset('assets/images/arrived2.png'),
                        title: 'Order has arrived to Customer Address.',
                        time: order.date,
                        onTap: () {
                          navigateTo(
                              context: context,
                              screen: const OrderedStoreDetailsView(
                                items: [],
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
    );
  }
}
