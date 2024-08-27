import 'package:flutter/material.dart';
import 'package:nilelon/core/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/features/order/presentation/cubit/order_cubit.dart';
import 'package:nilelon/features/order/presentation/widgets/ordered_view.dart';
import 'package:nilelon/features/order/presentation/widgets/received_store_view.dart';
import 'package:nilelon/features/order/presentation/widgets/shipped_store_view.dart';

class OrderTabBar extends StatefulWidget {
  const OrderTabBar({super.key});

  @override
  State<OrderTabBar> createState() => _OrderTabBarState();
}

class _OrderTabBarState extends State<OrderTabBar> {
  int selectedIndex = 0;
  late final OrderCubit cubit;
  @override
  void initState() {
    cubit = OrderCubit.get(context);
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: ColorManager.primaryW,
        appBar: customAppBar(
          title: lang.orders,
          context: context,
          hasIcon: false,
          hasLeading: false,
        ),
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
                tabs: [
                  Tab(
                    child: Text(
                      lang.ordered,
                    ),
                  ),
                  Tab(
                    child: Text(
                      lang.shipped,
                    ),
                  ),
                  Tab(
                    child: Text(
                      lang.received,
                    ),
                  ),
                ],
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    OrderedView(),
                    ShippedStoreView(),
                    RecievedStoreView(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
