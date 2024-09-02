import 'package:flutter/material.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/cards/store_order/shipped_store_card.dart';
import 'package:nilelon/features/order/presentation/pages/ordered_store_details_view.dart';

import '../../../../core/data/hive_stroage.dart';
import '../../../../core/widgets/scaffold_image.dart';
import '../cubit/order_cubit.dart';

class ShippedStoreView extends StatefulWidget {
  const ShippedStoreView({super.key});

  @override
  State<ShippedStoreView> createState() => _ShippedStoreViewState();
}

class _ShippedStoreViewState extends State<ShippedStoreView> {
  late final OrderCubit cubit;
  @override
  void initState() {
    cubit = OrderCubit.get(context);
    if (HiveStorage.get(HiveKeys.isStore)) {
      cubit.getStoreOrder('shipped');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldImage(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: ListView.builder(
            itemCount: 9,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ShippedStoreCard(
                  image: 'assets/images/cloth1.png',
                  title: 'Order 42076 is Shipped.',
                  time: '10:30 AM',
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
                          index: 1,
                        ));
                  },
                ),
              );
            }),
      ),
    );
  }
}
