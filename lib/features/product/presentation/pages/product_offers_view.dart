import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/features/product/presentation/widgets/product_card/offers_card.dart';
import 'package:nilelon/core/widgets/shimmer_indicator/build_shimmer.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_cubit.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_state.dart';

import '../../../../core/tools.dart';
import '../../../../core/widgets/scaffold_image.dart';
import '../../../categories/presentation/widget/category_filter_widget.dart';
import '../../../categories/presentation/widget/gander_filter_widget copy.dart';

class OffersView extends StatefulWidget {
  const OffersView({super.key, required this.isStore});
  final bool isStore;

  @override
  State<OffersView> createState() => _OffersViewState();
}

class _OffersViewState extends State<OffersView> {
  int offersPage = 1;
  late final ProductsCubit cubit;

  int offersPageSize = 10;
  bool offersIsLoadMore = false;
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    cubit = ProductsCubit.get(context);
    cubit.getOffersProducts(offersPage, offersPageSize);
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
    cubit.getOffersProducts(offersPage, offersPageSize);

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
                        ? _buildOfferList(context)
                        : _buildProductList(),
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

  GridView _buildProductList() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: gridDelegate,
      shrinkWrap: true,
      itemCount: offersIsLoadMore
          ? cubit.filterListByCategory(cubit.category, cubit.products).length +
              1
          : cubit.filterListByCategory(cubit.category, cubit.products).length,
      itemBuilder: (context, sizeIndex) {
        if (sizeIndex ==
                cubit
                    .filterListByCategory(cubit.category, cubit.products)
                    .length &&
            offersIsLoadMore) {
          return buildShimmerIndicatorSmall();
        } else {
          return Container(
            child: offersCard(
                context: context,
                product: cubit.filterListByCategory(
                    cubit.category, cubit.products)[sizeIndex]),
          );
        }
      },
    );
  }

  GridView _buildOfferList(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: gridDelegate,
      shrinkWrap: true,
      itemCount: offersIsLoadMore
          ? cubit.filterListByCategory(cubit.category, cubit.products).length +
              1
          : cubit.filterListByCategory(cubit.category, cubit.products).length,
      itemBuilder: (context, sizeIndex) {
        if (sizeIndex ==
                cubit
                    .filterListByCategory(cubit.category, cubit.products)
                    .length &&
            offersIsLoadMore) {
          return buildShimmerIndicatorSmall();
        } else {
          return offersCard(
            context: context,
            product: cubit.filterListByCategory(
                cubit.category, cubit.products)[sizeIndex],
          );
        }
      },
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
            Icon(
              Icons.tune,
              size: 1.sw > 600 ? 32 : 24,
            ),
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
