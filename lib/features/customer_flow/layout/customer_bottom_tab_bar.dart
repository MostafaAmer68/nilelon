import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:nilelon/features/cart/data/repos_impl/cart_repos_impl.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/service/set_up_locator_service.dart';
import 'package:nilelon/core/widgets/icon_with_gradient/icon_with_gradient.dart';
import 'package:nilelon/features/cart/presentation/view/cart_view.dart';
import 'package:nilelon/features/product/presentation/pages/discover_page.dart';
import 'package:nilelon/features/customer_flow/home/view/customer_home_view.dart';
import 'package:nilelon/features/profile/presentation/pages/profile_view.dart';

class CustomerBottomTabBar extends StatefulWidget {
  const CustomerBottomTabBar({super.key});

  @override
  State<CustomerBottomTabBar> createState() => _CustomerBottomTabBarState();
}

class _CustomerBottomTabBarState extends State<CustomerBottomTabBar> {
  int selectedIndex = 0;

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
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    // BlocProvider<RatingCubit>(
                    //   create: (context) => RatingCubit(),
                    //   child:
                    const CustomerHomeView(),
                    // ),
                    BlocProvider(
                      create: (context) =>
                          CartCubit(locatorService<CartReposImpl>())..getCart(),
                      child: const CartView(),
                    ),
                    const DiscoverView(),
                    const ProfileView(),
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
