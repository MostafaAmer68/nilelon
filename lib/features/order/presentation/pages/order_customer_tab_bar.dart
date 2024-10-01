import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/features/order/presentation/widgets/ordered_customer_view.dart';
import 'package:nilelon/features/order/presentation/widgets/recieved_customer_view.dart';
import 'package:nilelon/features/order/presentation/widgets/shipped_customer_view.dart';

import '../../../../core/widgets/scaffold_image.dart';
import '../cubit/order_cubit.dart';

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
    return BlocListener<OrderCubit, OrderState>(
      listener: (context, state) {
        state.mapOrNull(failure: (err) {
          BotToast.showText(text: err.errMessage);
        });
      },
      child: DefaultTabController(
        length: 3,
        child: ScaffoldImage(
            appBar: customAppBar(
                title: lang.ordersManagement, context: context, hasIcon: false),
            body: Padding(
              padding: const EdgeInsetsDirectional.symmetric(
                  vertical: 12, horizontal: 10),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // Background color for the tab bar
                      borderRadius: BorderRadius.circular(25), // Rounded edges
                      border: Border.all(
                        color: Colors.orange,
                        width: 1,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 255, 214, 153),
                          offset: Offset(1, 1),
                          blurRadius: 20,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: TabBar(
                      onTap: (index) {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      indicator: BoxDecoration(
                        color: Colors.orange, // Color of the selected tab

                        borderRadius:
                            BorderRadius.circular(25), // Rounded indicator
                      ),
                      // labelPadding: EdgeInsets.symmetric(horizontal: 5),
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      labelColor: ColorManager.primaryW,
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
                  ),
                  const Expanded(
                    child: TabBarView(
                      children: [
                        OrderedCustomerView(),
                        ShippedCustomerView(),
                        ReceivedCustomerView(),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
