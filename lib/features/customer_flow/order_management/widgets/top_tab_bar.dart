import 'package:flutter/material.dart';
import 'package:nilelon/core/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/features/customer_flow/order_management/view/in_progress_view.dart';
import 'package:nilelon/features/customer_flow/order_management/view/recieved_view.dart';
import 'package:nilelon/features/customer_flow/order_management/view/shipped_view.dart';

class OrderManegementTabBar extends StatefulWidget {
  const OrderManegementTabBar({super.key});

  @override
  State<OrderManegementTabBar> createState() => _OrderManegementTabBarState();
}

class _OrderManegementTabBarState extends State<OrderManegementTabBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          backgroundColor: ColorManager.primaryW,
          appBar: customAppBar(
              title: lang.ordersManagement, context: context, hasIcon: false),
          body: Padding(
            padding: const EdgeInsetsDirectional.symmetric(vertical: 12),
            child: Column(
              children: [
                TabBar(
                  onTap: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  dividerColor: Colors.transparent,
                  labelColor: ColorManager.primaryO,
                  unselectedLabelColor: ColorManager.primaryG,
                  indicatorColor: ColorManager.primaryO,
                  unselectedLabelStyle: AppStylesManager.customTextStyleG2,
                  labelStyle: AppStylesManager.customTextStyleO3,
                  tabs: const [
                    Tab(
                      child: Text(
                        'Ordered',
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Shipped',
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Recieved',
                      ),
                    ),
                  ],
                ),
                const Expanded(
                  child: TabBarView(
                    children: [
                      InProgressView(),
                      ShippedView(),
                      RecievedView(),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
