import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/features/auth/domain/model/user_model.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_cubit.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_state.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/features/product/presentation/pages/hand_picked_view_all.dart';
import 'package:nilelon/core/widgets/cards/small/product_squar_item.dart';
import 'package:nilelon/core/widgets/shimmer_indicator/build_shimmer.dart';
import 'package:nilelon/core/widgets/view_all_row/view_all_row.dart';
import 'package:nilelon/features/product/presentation/widgets/new_in_all_widget.dart';

import '../../../../core/widgets/cards/offers/offers_card.dart';
import '../../../../core/widgets/scaffold_image.dart';

class DiscoverView extends StatefulWidget {
  const DiscoverView({super.key});

  @override
  State<DiscoverView> createState() => _DiscoverViewState();
}

class _DiscoverViewState extends State<DiscoverView> {
  int newInPage = 1;
  int newInPageSize = 10;
  bool newInIsLoadMore = false;
  ScrollController scrollController = ScrollController();
  int handPage = 1;
  int handPageSize = 10;
  bool handIsLoadMore = false;
  ScrollController handScrollController = ScrollController();

  @override
  void initState() {
    if (HiveStorage.get<UserModel>(HiveKeys.userModel).id.isNotEmpty) {
      ProductsCubit.get(context).getNewInProducts(newInPage, newInPageSize);
      ProductsCubit.get(context).getRandomProducts(newInPage, newInPageSize);
    } else {
      ProductsCubit.get(context)
          .getNewInProductsGuest(newInPage, newInPageSize);
      ProductsCubit.get(context)
          .getRandomProductsGuest(newInPage, newInPageSize);
    }
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !newInIsLoadMore) {
        getMoreNewInData();
      }
    });
    handScrollController.addListener(() {
      if (handScrollController.position.pixels ==
              handScrollController.position.maxScrollExtent &&
          !handIsLoadMore) {
        getMoreHandData();
      }
    });
    super.initState();
  }

  getMoreNewInData() async {
    setState(() {
      newInIsLoadMore = true;
    });

    newInPage = newInPage + 1;
    if (HiveStorage.get<UserModel>(HiveKeys.userModel).id.isNotEmpty) {
      ProductsCubit.get(context)
          .getNewInProductsPagination(newInPage, newInPageSize);
    } else {
      ProductsCubit.get(context)
          .getNewInProductsGuestPagination(newInPage, newInPageSize);
    }
    setState(() {
      newInIsLoadMore = false;
    });
  }

  getMoreHandData() async {
    setState(() {
      handIsLoadMore = true;
    });

    handPage = handPage + 1;
    if (HiveStorage.get<UserModel>(HiveKeys.userModel).id.isNotEmpty) {
      ProductsCubit.get(context)
          .getRandomProductsPagination(newInPage, newInPageSize);
    } else {
      ProductsCubit.get(context)
          .getRandomProductsGuestPagination(newInPage, newInPageSize);
    }
    setState(() {
      handIsLoadMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return ScaffoldImage(
      appBar: customAppBar(
          title: lang.discover, context: context, hasLeading: false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const DefaultDivider(),
            const SizedBox(
              height: 8,
            ),
            Text(
              lang.discoverOurNewAndSpecialProductsFromHere,
              style: AppStylesManager.customTextStyleG24,
            ),
            const SizedBox(
              height: 16,
            ),
            Column(
              children: [
                ViewAllRow(
                    assetName: 'assets/images/newIn.svg',
                    noTextIcon: false,
                    text: lang.newIn,
                    onPressed: () {
                      navigateTo(
                          context: context,
                          screen: const NewInViewAll(
                            isStore: false,
                          ));
                    }),
                const SizedBox(
                  height: 16,
                ),
                BlocBuilder<ProductsCubit, ProductsState>(
                  builder: (context, state) {
                    return state.getNewInProducts.when(initial: () {
                      return buildShimmerIndicatorRow();
                    }, loading: () {
                      return buildShimmerIndicatorRow();
                    }, success: (productsList) {
                      if (productsList.isEmpty) {
                        return SizedBox(
                          height: 120.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'There is no New In products yet.',
                                style: AppStylesManager.customTextStyleG2,
                              ),
                            ],
                          ),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SizedBox(
                          height: 1.sw > 600 ? 310 : 300,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              if (index == productsList.length &&
                                  newInIsLoadMore) {
                                return buildShimmerIndicatorSmall();
                              } else {
                                return productsList[index]
                                            .productVariants
                                            .first
                                            .discountRate !=
                                        0
                                    ? offersCard(
                                        context: context,
                                        product: productsList[index])
                                    : productSquarItem(
                                        context: context,
                                        model: productsList[index],
                                      );
                              }
                            },
                            itemCount: newInIsLoadMore
                                ? productsList.length + 1
                                : productsList.length,
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.only(right: 8),
                          ),
                        ),
                      );
                    }, failure: (message) {
                      return SizedBox(
                        height: 150.h,
                        child: Center(
                          child: Text(message),
                        ),
                      );
                    });
                  },
                ),
                const SizedBox(height: 20),
                ViewAllRow(
                    text: lang.handPicked,
                    assetName: 'assets/images/handPicked.svg',
                    noTextIcon: false,
                    onPressed: () {
                      navigateTo(
                          context: context, screen: const HandPickedViewAll());
                    }),
                BlocBuilder<ProductsCubit, ProductsState>(
                  builder: (context, state) {
                    return state.getRandomProducts.when(initial: () {
                      return buildShimmerIndicatorGrid();
                    }, loading: () {
                      return buildShimmerIndicatorGrid();
                    }, success: (productsList) {
                      return productsList.isEmpty
                          ? SizedBox(
                              height: 450.h,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'There is no Hand Picked in products yet.',
                                    style: AppStylesManager.customTextStyleG2,
                                  ),
                                ],
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: GridView.builder(
                                controller: handScrollController,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1.sw > 600 ? 3 : 2,
                                  crossAxisSpacing: 1.sw > 600 ? 14 : 16.0,
                                  mainAxisExtent: 1.sw > 600 ? 300 : 300,
                                  mainAxisSpacing: 1.sw > 600 ? 16 : 12,
                                ),
                                shrinkWrap: true,
                                itemCount: handIsLoadMore
                                    ? productsList.length
                                    : productsList.length,
                                itemBuilder: (context, index) {
                                  if (index == productsList.length &&
                                      handIsLoadMore) {
                                    return buildShimmerIndicatorSmall();
                                  } else {
                                    return productsList[index]
                                                .productVariants
                                                .first
                                                .discountRate !=
                                            0
                                        ? offersCard(
                                            context: context,
                                            product: productsList[index])
                                        : productSquarItem(
                                            context: context,
                                            model: productsList[index],
                                          );
                                  }
                                },
                              ),
                            );
                    }, failure: (message) {
                      return SizedBox(
                        height: 200.h,
                        child: Center(
                          child: Text(message),
                        ),
                      );
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
