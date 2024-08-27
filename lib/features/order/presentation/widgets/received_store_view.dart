import 'package:flutter/material.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/cards/store_order/recieved_store_card.dart';
import 'package:nilelon/features/order/presentation/pages/ordered_store_details_view.dart';

import '../../../../core/data/hive_stroage.dart';
import '../cubit/order_cubit.dart';

class RecievedStoreView extends StatefulWidget {
  const RecievedStoreView({super.key});

  @override
  State<RecievedStoreView> createState() => _RecievedStoreViewState();
}

class _RecievedStoreViewState extends State<RecievedStoreView> {
  late final OrderCubit cubit;
  @override
  void initState() {
    cubit = OrderCubit.get(context);
    if (HiveStorage.get(HiveKeys.isStore)) {
      cubit.getStoreOrder('received');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryW,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(
                    Icons.history,
                    color: ColorManager.primaryO,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                      onTap: () {},
                      child: Text(
                        'History',
                        style: AppStylesManager.customTextStyleO,
                      )),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: ReceivedStoreCard(
                        image: 'assets/images/arrived2.png',
                        title: 'Order 42076 has arrived to Customer Address.',
                        quantity: '1',
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
                                index: 2,
                              ));
                        },
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
