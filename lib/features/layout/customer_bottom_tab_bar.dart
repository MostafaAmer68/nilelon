import 'dart:developer';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/features/profile/presentation/pages/profile_guest_page.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/widgets/icon_with_gradient/icon_with_gradient.dart';
import 'package:nilelon/features/cart/presentation/view/cart_view.dart';
import 'package:nilelon/features/product/presentation/pages/product_discover_page.dart';
import 'package:nilelon/features/home/view/customer_home_view.dart';
import 'package:nilelon/features/profile/presentation/pages/profile_view.dart';

import '../../core/data/hive_stroage.dart';
import '../../core/utils/navigation.dart';
import '../product/presentation/pages/product_details_page.dart';
import '../profile/presentation/pages/store_profile_customer.dart';

class CustomerBottomTabBar extends StatefulWidget {
  const CustomerBottomTabBar({super.key, this.index = 0});
  final int index;
  @override
  State<CustomerBottomTabBar> createState() => _CustomerBottomTabBarState();
}

class _CustomerBottomTabBarState extends State<CustomerBottomTabBar> {
  int selectedIndex = 0;
  final appLinks = AppLinks();
  @override
  void initState() {
    selectedIndex = widget.index;
    final sub = appLinks.uriLinkStream.listen((uri) {
      log(uri.path);
      if (uri.path.contains('Product')) {
        navigateTo(
            context: context,
            screen: ProductDetailsView(
                productId: uri.path.split('/').last.toString()));
      } else if (uri.path.contains('Store')) {
        navigateTo(
          context: context,
          screen: StoreProfileCustomer(
            storeId: uri.path.split('/').last.toString(),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Expanded(
                child: [
                  const CustomerHomeView(),
                  PopScope(
                    onPopInvoked: (s) {
                      selectedIndex = 0;
                      setState(() {});
                    },
                    child: HiveStorage.get(HiveKeys.userModel) != null
                        ? const CartView()
                        : const ProfileGuestPage(),
                  ),
                  PopScope(
                    onPopInvoked: (s) {
                      selectedIndex = 0;
                      setState(() {});
                    },
                    child: const DiscoverView(),
                  ),
                  PopScope(
                    onPopInvoked: (s) {
                      selectedIndex = 0;
                      setState(() {});
                    },
                    child: HiveStorage.get(HiveKeys.userModel) != null
                        ? const ProfileView()
                        : const ProfileGuestPage(),
                  ),
                ][selectedIndex],
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
                                  iconWithGradient(Iconsax.home),
                                  Text(
                                    lang.home,
                                    style: AppStylesManager.customTextStyleB2,
                                  )
                                ],
                              )
                            : const Icon(
                                Iconsax.home,
                              )),
                    Tab(
                      child: selectedIndex == 1
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                iconWithGradient(Icons.shopping_cart_outlined),
                                Text(
                                  lang.cart,
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
                                  iconWithGradient(Icons.explore_outlined),
                                  Text(
                                    lang.discover,
                                    style: AppStylesManager.customTextStyleB2,
                                  )
                                ],
                              )
                            : const Icon(Icons.explore_outlined)),
                    Tab(
                        child: selectedIndex == 3
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
