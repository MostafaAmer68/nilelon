import 'package:flutter/material.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/utils/navigation.dart';
import 'package:nilelon/widgets/cards/store_order/shipped_store_card.dart';
import 'package:nilelon/features/store_flow/ordered_store_details/ordered_store_details_view.dart';

class ShippedStoreView extends StatelessWidget {
  const ShippedStoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryW,
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
