import 'dart:developer';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:nilelon/features/order/presentation/pages/order_tab_bar.dart';
import 'package:nilelon/features/store_flow/analytics/presentation/analytics_view.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/widgets/icon_with_gradient/icon_with_gradient.dart';
import 'package:nilelon/features/categories/presentation/view/category_view.dart';
import 'package:nilelon/features/home/view/store_home_view.dart';
import 'package:nilelon/features/profile/presentation/pages/store_profile_view.dart';

import '../../core/utils/navigation.dart';
import '../product/presentation/pages/product_details_page.dart';

class StoreBottomTabBar extends StatefulWidget {
  const StoreBottomTabBar({super.key});

  @override
  State<StoreBottomTabBar> createState() => _StoreBottomTabBarState();
}

class _StoreBottomTabBarState extends State<StoreBottomTabBar> {
  int selectedIndex = 0;
  final appLinks = AppLinks();
  @override
  void initState() {
    final sub = appLinks.uriLinkStream.listen((uri) {
      
      navigateTo(
          context: context,
          screen: ProductDetailsView(
              productId: uri.path.split('/').last.toString()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    return DefaultTabController(
      length: 5,
      child: PopScope(
        canPop: false,
        onPopInvoked: (v) {
          if (v) {
            return;
          }
          selectedIndex = 0;
          setState(() {});
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                Expanded(
                    child: [
                  PopScope(
                      canPop: false,
                      onPopInvoked: (v) {
                        if (v) {
                          return;
                        }
                        selectedIndex = 0;
                        setState(() {});
                      },
                      child: const StoreMarketView()),
                  PopScope(
                      canPop: false,
                      onPopInvoked: (v) {
                        if (v) {
                          return;
                        }
                        selectedIndex = 0;
                        setState(() {});
                      },
                      child: const OrderPage()),
                  PopScope(
                      canPop: false,
                      onPopInvoked: (v) {
                        if (v) {
                          return;
                        }
                        selectedIndex = 0;
                        setState(() {});
                      },
                      child: const ChooseProductView()),
                  PopScope(
                      canPop: false,
                      onPopInvoked: (v) {
                        if (v) {
                          return;
                        }
                        selectedIndex = 0;
                        setState(() {});
                      },
                      child: const AnalyticsView()),
                  PopScope(
                      canPop: false,
                      onPopInvoked: (v) {
                        if (v) {
                          return;
                        }
                        selectedIndex = 0;
                        setState(() {});
                      },
                      child: const StoreProfileView()),
                ][selectedIndex]),
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
                                  iconWithGradient(
                                      Icons.shopping_cart_outlined),
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
                              : const Icon(
                                  Icons.insert_chart_outlined_rounded)),
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
                            : const Icon(Icons.person_outline_sharp),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
