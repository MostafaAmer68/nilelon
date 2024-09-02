import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/alert/shipped_alert.dart';
import 'package:nilelon/core/widgets/cards/store_order/ordered_store_card.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/features/order/presentation/cubit/order_cubit.dart';
import 'package:nilelon/features/order/presentation/pages/ordered_store_details_view.dart';

import '../../../../core/widgets/scaffold_image.dart';

class OrderedView extends StatefulWidget {
  const OrderedView({super.key});

  @override
  State<OrderedView> createState() => _OrderedViewState();
}

class _OrderedViewState extends State<OrderedView> {
  late final OrderCubit cubit;
  @override
  void initState() {
    cubit = OrderCubit.get(context);
    if (HiveStorage.get(HiveKeys.isStore)) {
      cubit.getStoreOrder('ordered');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldImage(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: ListView.builder(
            itemCount: cubit.storeOrders.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: OrderedCard(
                  image: 'assets/images/cloth1.png',
                  title: 'You have new Order no. 42076.',
                  time: '11:56 AM',
                  onTap: () {
                    navigateTo(
                        context: context,
                        screen: const OrderedStoreDetailsView(
                          items: [
                            {
                              'images': ['assets/images/cloth1.png'],
                              'name': 'Cream Hoodie',
                              'storeName': 'By Nagham',
                              'rating': '4.8',
                              'price': '370.00',
                              'size': 'L',
                              'quan': '1',
                            },
                            {
                              'images': ['assets/images/cloth1.png'],
                              'name': 'Cream Hoodie',
                              'storeName': 'By Nagham',
                              'rating': '4.8',
                              'price': '370.00',
                              'size': 'L',
                              'quan': '1',
                            },
                            {
                              'images': ['assets/images/cloth1.png'],
                              'name': 'Cream Hoodie',
                              'storeName': 'By Nagham',
                              'rating': '4.8',
                              'price': '370.00',
                              'size': 'L',
                              'quan': '1',
                            }
                          ],
                          index: 0,
                        ));
                  },
                  shippedOnTap: () async {
                    await shippedAlert(context);
                  },
                ),
              );
            }),
      ),
    );
  }
}
