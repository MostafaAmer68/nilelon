import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/tools.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_cubit.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_state.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/features/product/presentation/widgets/product_card/product_squar_item.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/shimmer_indicator/build_shimmer.dart';

import '../../../categories/presentation/widget/category_filter_widget.dart';
import '../../../categories/presentation/widget/gander_filter_widget copy.dart';
import '../widgets/product_card/offers_card.dart';
import '../widgets/product_card/market_small_card.dart';
import '../../../../core/widgets/scaffold_image.dart';

class ProductNewInViewAll extends StatefulWidget {
  const ProductNewInViewAll({super.key, required this.isStore});
  final bool isStore;

  @override
  State<ProductNewInViewAll> createState() => _ProductNewInViewAllState();
}

class _ProductNewInViewAllState extends State<ProductNewInViewAll> {
  int page = 1;
  late final ProductsCubit cubit;

  int pageSize = 10;
  bool isLoadMore = false;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    cubit = ProductsCubit.get(context);
    cubit.getNewInProducts(page, pageSize);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isLoadMore) {
        getMoreData();
      }
    });
    super.initState();
  }

  getMoreData() async {
    setState(() {
      isLoadMore = true;
    });

    page = page + 1;
    cubit.getNewInProducts(page, pageSize);
    setState(() {
      isLoadMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    return ScaffoldImage(
      appBar: customAppBar(title: lang.newIn, context: context),
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
                  return cubit
                          .filterListByCategory(cubit.category, cubit.products)
                          .isEmpty
                      ? SizedBox(
                          height: 450.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                S.of(context).noProductNewIn,
                                style: AppStylesManager.customTextStyleG2,
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: GridView.builder(
                            controller: scrollController,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: gridDelegate,
                            shrinkWrap: true,
                            itemCount: isLoadMore
                                ? cubit
                                        .filterListByCategory(
                                            cubit.category, cubit.products)
                                        .length +
                                    1
                                : cubit
                                    .filterListByCategory(
                                        cubit.category, cubit.products)
                                    .length,
                            itemBuilder: (context, sizeIndex) {
                              if (sizeIndex ==
                                      cubit
                                          .filterListByCategory(
                                              cubit.category, cubit.products)
                                          .length &&
                                  isLoadMore) {
                                return buildShimmerIndicatorSmall();
                              } else {
                                return widget.isStore
                                    ? marketSmallCard(
                                        context: context,
                                        product: cubit.filterListByCategory(
                                            cubit.category,
                                            cubit.products)[sizeIndex])
                                    : cubit
                                                .filterListByCategory(
                                                    cubit.category,
                                                    cubit.products)[sizeIndex]
                                                .productVariants
                                                .first
                                                .discountRate !=
                                            0
                                        ? offersCard(
                                            context: context,
                                            product: cubit.filterListByCategory(
                                                cubit.category,
                                                cubit.products)[sizeIndex])
                                        : productSquarItem(
                                            context: context,
                                            product: cubit.filterListByCategory(
                                                cubit.category,
                                                cubit.products)[sizeIndex],
                                          );
                              }
                            },
                          ),
                        );
                }, failure: (message) {
                  return Text(message);
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
          child: CategoryFilterWidget(
            selectedCategory: cubit.category,
            onSelected: (category) {
              cubit.category = category;
              setState(() {});
            },
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
            const Icon(Icons.tune),
            const SizedBox(
              width: 8,
            ),
             Expanded(
              child: GendarFilterWidget(
                selectedCategory: cubit.gendar,
                onSelected: (gendar) {
                  cubit.gendar = gendar;
                  setState(() {});
                },
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
