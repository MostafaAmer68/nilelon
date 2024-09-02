import 'package:flutter/material.dart';
import 'package:nilelon/core/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/widgets/cards/subscription/subscription_card.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/scaffold_image.dart';

class SubscriptionView extends StatelessWidget {
  const SubscriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> subscriptionList = [
      {
        'image': 'assets/images/sub_1.png',
        'title': 'Silver',
        'price': 5000,
        'month': 3,
        'textColor': ColorManager.primaryB7,
        'ontap': () {},
      },
      {
        'image': 'assets/images/sub_2.png',
        'title': 'Silver',
        'price': 5000,
        'month': 3,
        'textColor': ColorManager.primaryY,
        'ontap': () {},
      },
      {
        'image': 'assets/images/sub_3.png',
        'title': 'Silver',
        'price': 5000,
        'month': 3,
        'textColor': ColorManager.primaryP,
        'ontap': () {},
      },
    ];
    final lang = S.of(context);

    return ScaffoldImage(
      appBar: customAppBar(
        title: lang.subscription,
        context: context,
        hasIcon: false,
      ),
      body: Column(
        children: [
          const DefaultDivider(),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16,
                ),
                child: SubscriptionCard(
                  image: subscriptionList[index]['image'],
                  title: subscriptionList[index]['title'],
                  price: subscriptionList[index]['price'],
                  month: subscriptionList[index]['month'],
                  textColor: subscriptionList[index]['textColor'],
                  ontap: subscriptionList[index]['ontap'],
                ),
              ),
              itemCount: subscriptionList.length,
            ),
          )
        ],
      ),
    );
  }
}
