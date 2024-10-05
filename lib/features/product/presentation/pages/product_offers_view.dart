import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/cards/offers/market_offers_card.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/cards/offers/offers_card.dart';
import 'package:nilelon/core/widgets/filter/category_container.dart';
import 'package:nilelon/core/widgets/filter/filter_container.dart';
import 'package:nilelon/core/widgets/filter/static_lists.dart';
import 'package:nilelon/core/widgets/shimmer_indicator/build_shimmer.dart';
import 'package:nilelon/features/auth/domain/model/user_model.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_cubit.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_state.dart';

import '../../../../core/tools.dart';
import '../../../../core/widgets/scaffold_image.dart';

class OffersView extends StatefulWidget {
  const OffersView({super.key, required this.isStore});
  final bool isStore;

  @override
  State<OffersView> createState() => _OffersViewState();
}

class _OffersViewState extends State<OffersView> {
  int selectedGender = 0;
  int selectedCategory = 0;
  int offersPage = 1;
  int offersPageSize = 10;
  bool offersIsLoadMore = false;
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    if (HiveStorage.get(HiveKeys.userModel) != null) {
      ProductsCubit.get(context)
          .getOffersProductsPagination(offersPage, offersPageSize);
    } else {
      ProductsCubit.get(context)
          .getOffersProductsPaginationGuest(offersPage, offersPageSize);
    }
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !offersIsLoadMore) {
        getMoreOffersData();
      }
    });
    super.initState();
  }

  getMoreOffersData() async {
    setState(() {
      offersIsLoadMore = true;
    });

    offersPage = offersPage + 1;
    if (HiveStorage.get(HiveKeys.userModel) != null) {
      ProductsCubit.get(context)
          .getOffersProductsPagination(offersPage, offersPageSize);
    } else {
      ProductsCubit.get(context)
          .getOffersProductsPaginationGuest(offersPage, offersPageSize);
    }
    setState(() {
      offersIsLoadMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return ScaffoldImage(
      appBar: customAppBar(title: lang.offers, context: context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const DefaultDivider(),
            const SizedBox(
              height: 8,
            ),
            filtersColumn(context),
            BlocBuilder<ProductsCubit, ProductsState>(
              builder: (context, state) {
                return state.when(initial: () {
                  return buildShimmerIndicatorGrid();
                }, loading: () {
                  return buildShimmerIndicatorGrid();
                }, success: () {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: widget.isStore
                        ? GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: gridDelegate,
                            shrinkWrap: true,
                            itemCount: offersIsLoadMore
                                ? ProductsCubit.get(context).products.length + 1
                                : ProductsCubit.get(context).products.length,
                            itemBuilder: (context, sizeIndex) {
                              if (sizeIndex ==
                                      ProductsCubit.get(context)
                                          .products
                                          .length &&
                                  offersIsLoadMore) {
                                return buildShimmerIndicatorSmall();
                              } else {
                                return Container(
                                  child: marketOffersCard(
                                      context: context,
                                      product: ProductsCubit.get(context)
                                          .products[sizeIndex]),
                                );
                              }
                            },
                          )
                        : GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1.sw > 600 ? 3 : 2,
                                    crossAxisSpacing: 1.sw > 600 ? 16 : 16.0,
                                    mainAxisExtent: 1.sw > 600 ? 415 : 300,
                                    mainAxisSpacing: 1.sw > 600 ? 16 : 12),
                            shrinkWrap: true,
                            itemCount: offersIsLoadMore
                                ? ProductsCubit.get(context).products.length + 1
                                : ProductsCubit.get(context).products.length,
                            itemBuilder: (context, sizeIndex) {
                              if (sizeIndex ==
                                      ProductsCubit.get(context)
                                          .products
                                          .length &&
                                  offersIsLoadMore) {
                                return buildShimmerIndicatorSmall();
                              } else {
                                return Container(
                                  child: offersCard(
                                      context: context,
                                      product: ProductsCubit.get(context)
                                          .products[sizeIndex]),
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
        ),
      ),
    );
  }

  Column filtersColumn(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: SizedBox(
            height: screenWidth(context, 0.28),
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    selectedCategory = index;
                    setState(() {});
                  },
                  child: categoryContainer(
                    context: context,
                    image: categoryFilter[index]['image'],
                    name: categoryFilter[index]['name'],
                    isSelected: selectedCategory == index,
                  )),
              itemCount: categoryFilter.length,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            const SizedBox(
              width: 16,
            ),
            Icon(
              Icons.tune,
              size: 1.sw > 600 ? 32 : 24,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: SizedBox(
                height: 52,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        selectedGender = index;
                        setState(() {});
                      },
                      child: filterContainer(
                        genderFilter[index],
                        selectedGender == index,
                      )),
                  itemCount: genderFilter.length,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
