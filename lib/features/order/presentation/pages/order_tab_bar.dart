import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/features/refund/presentation/pages/refund_history_page.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/features/order/presentation/widgets/order_view.dart';
import 'package:svg_flutter/svg.dart';

import '../../../../core/constants/assets.dart';
import '../../../../core/data/hive_stroage.dart';
import '../../../../core/widgets/scaffold_image.dart';
import '../cubit/order_cubit.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  int selectedIndex = 0;
  late final OrderCubit cubit;
  bool isStore = HiveStorage.get(HiveKeys.isStore);
  @override
  void initState() {
    cubit = OrderCubit.get(context);
    super.initState();
  }

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
                    height: 40,
                    width: screenWidth(context, 0.9),
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
                      indicatorWeight: 0.1,
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      // dividerHeight: 50,
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
                  Expanded(
                    child: TabBarView(
                      children: [
                        OrderView(
                          image: SvgPicture.asset(
                              Assets.assetsImagesPackageAccept),
                          title:
                              isStore ? lang.newOrder : lang.orderHasDelivered,
                          status: 'Ordered',
                          onTapHistory: () {
                            navigateTo(
                                context: context,
                                screen: const ReturnHistoryPage());
                          },
                        ),
                        OrderView(
                          image: Padding(
                            padding: const EdgeInsets.all(5),
                            child: SvgPicture.asset(
                              Assets.assetsImagesInProgress,
                              // width: 10,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: isStore
                              ? lang.orderIsShipped
                              : lang.orderHasDistance,
                          status: 'Shipped',
                          onTapHistory: () {
                            navigateTo(
                                context: context,
                                screen: const ReturnHistoryPage());
                          },
                        ),
                        OrderView(
                          image: Image.asset(Assets.assetsImagesArrived2),
                          title: lang.orderHasArrived,
                          status: 'Delivered',
                          onTapHistory: () {
                            navigateTo(
                                context: context,
                                screen: const ReturnHistoryPage());
                          },
                        ),
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
