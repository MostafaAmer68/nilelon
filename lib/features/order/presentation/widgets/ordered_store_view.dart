import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/widgets/alert/shipped_alert.dart';
import 'package:nilelon/core/widgets/cards/store_order/ordered_store_card.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/features/order/presentation/cubit/order_cubit.dart';
import 'package:svg_flutter/svg.dart';

import '../../../../core/utils/navigation.dart';
import '../../../../core/widgets/scaffold_image.dart';
import '../pages/ordered_store_details_view.dart';

class OrderedStoreView extends StatefulWidget {
  const OrderedStoreView({super.key});

  @override
  State<OrderedStoreView> createState() => _OrderedStoreViewState();
}

class _OrderedStoreViewState extends State<OrderedStoreView> {
  late final OrderCubit cubit;
  @override
  void initState() {
    cubit = OrderCubit.get(context);
    if (HiveStorage.get(HiveKeys.isStore)) {
      cubit.getStoreOrder('Ordered');
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
          child: ListView.builder(
            itemCount: cubit.storeOrders
                .where((e) => e.status == 'Ordered')
                .toList()
                .length,
            itemBuilder: (context, index) {
              final order = cubit.storeOrders
                  .where((e) => e.status == 'Ordered')
                  .toList()[index];

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: OrderedCard(
                  image: SvgPicture.asset('assets/images/package accept.svg'),
                  title: 'You have new Order.',
                  time: '',
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
            },
          ),
        ),
      ),
    );
  }
}
