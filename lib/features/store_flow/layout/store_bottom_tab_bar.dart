import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/features/store_flow/analytics/presentation/analytics_view.dart';
import 'package:nilelon/features/store_flow/analytics/presentation/cubit/reservation_cubit/reservation_date_cubit.dart';
import 'package:nilelon/features/store_flow/analytics/data/repos_impl/analytics_repos_impl.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/service/set_up_locator_service.dart';
import 'package:nilelon/core/widgets/icon_with_gradient/icon_with_gradient.dart';
import 'package:nilelon/features/categories/presentation/category_view.dart';
import 'package:nilelon/features/order/presentation/pages/order_store_tab_bar.dart';
import 'package:nilelon/features/store_flow/store_market/view/store_market_view.dart';
import 'package:nilelon/features/profile/presentation/pages/store_profile_view.dart';

import '../analytics/presentation/cubit/analytics_cubit.dart';

class StoreBottomTabBar extends StatefulWidget {
  const StoreBottomTabBar({super.key});

  @override
  State<StoreBottomTabBar> createState() => _StoreBottomTabBarState();
}

class _StoreBottomTabBarState extends State<StoreBottomTabBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    return DefaultTabController(
      length: 5,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const StoreMarketView(),
                    const OrderTabBar(),
                    const ChooseProductView(),
                    MultiBlocProvider(
                      providers: [
                        BlocProvider<ReservationDateCubit>(
                          create: (context) => ReservationDateCubit(),
                        ),
                        BlocProvider(
                          create: (context) => AnalyticsCubit(
                              locatorService<AnalyticsReposImpl>()),
                        ),
                      ],
                      child: const AnalyticsView(),
                    ),
                    const StoreProfileView(),
                  ],
                ),
              ),
              SizedBox(
                height: 70,
                child: TabBar(
                  onTap: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  labelColor: ColorManager.primaryB2,
                  unselectedLabelColor: ColorManager.primaryG,
                  indicatorColor: Colors.transparent,
                  tabs: [
                    Tab(
                        child: selectedIndex == 0
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  iconWithGradient(
                                      Icons.store_mall_directory_outlined),
                                  Text(
                                    lang.market,
                                    style: AppStylesManager.customTextStyleB2,
                                  )
                                ],
                              )
                            : const Icon(
                                Icons.store_mall_directory_outlined,
                              )),
                    Tab(
                      child: selectedIndex == 1
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                iconWithGradient(Icons.shopping_cart_outlined),
                                Text(
                                  lang.order,
                                  style: AppStylesManager.customTextStyleB2,
                                )
                              ],
                            )
                          : const Icon(Icons.shopping_cart_outlined),
                    ),
                    Tab(
                        child: selectedIndex == 2
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  iconWithGradient(Icons.add),
                                  Text(
                                    lang.add,
                                    style: AppStylesManager.customTextStyleB2,
                                  )
                                ],
                              )
                            : const Icon(Icons.add)),
                    Tab(
                        child: selectedIndex == 3
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  iconWithGradient(
                                      Icons.insert_chart_outlined_rounded),
                                  Text(
                                    lang.analytics,
                                    style: AppStylesManager.customTextStyleB2,
                                  )
                                ],
                              )
                            : const Icon(Icons.insert_chart_outlined_rounded)),
                    Tab(
                        child: selectedIndex == 4
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  iconWithGradient(Icons.person_outline_sharp),
                                  Text(
                                    lang.profile,
                                    style: AppStylesManager.customTextStyleB2,
                                  )
                                ],
                              )
                            : const Icon(Icons.person_outline_sharp)),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
