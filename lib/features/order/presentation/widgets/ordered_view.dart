import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/utils/navigation.dart';
import 'package:nilelon/widgets/alert/shipped_alert.dart';
import 'package:nilelon/widgets/cards/store_order/ordered_store_card.dart';
import 'package:nilelon/features/store_flow/ordered_store_details/ordered_store_details_view.dart';

class OrderedView extends StatelessWidget {
  const OrderedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryW,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: ListView.builder(
            itemCount: 9,
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
