import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/constants/assets.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/widgets/cards/wide/wide_card.dart';
import 'package:nilelon/features/categories/presentation/widget/gander_filter_widget.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_cubit.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_state.dart';
import 'package:nilelon/features/product/presentation/widgets/product_card/offers_card.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/features/product/presentation/widgets/product_card/product_squar_item.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/shimmer_indicator/build_shimmer.dart';

import '../../../../core/tools.dart';
import '../../../categories/presentation/widget/category_filter_widget.dart';
import '../../domain/models/product_model.dart';
import '../widgets/product_card/market_small_card.dart';
import '../../../../core/widgets/scaffold_image.dart';

class ProductsViewAllHot extends StatefulWidget {
  const ProductsViewAllHot({
    super.key,
    required this.appBarTitle,
    required this.onStartPage,
    this.isStore = false,
    this.isOffer = false,
    required this.notFoundTitle,
    required this.isHandpicked,
  });
  final String appBarTitle;
  final String notFoundTitle;
  final bool isHandpicked;
  final bool isStore;
  final bool isOffer;

  final VoidCallback onStartPage;
  @override
  State<ProductsViewAllHot> createState() => _ProductsViewAllState();
}

class _ProductsViewAllState extends State<ProductsViewAllHot> {
  int page = 5;
  int pageSize = 1;
  bool isLoadMore = false;
  late final ProductsCubit cubit;
  ScrollController scrollCn = ScrollController();
  List<ProductModel> products = [];

  @override
  void initState() {
    cubit = ProductsCubit.get(context);
    widget.onStartPage();

    scrollCn.addListener(() {
      if (scrollCn.position.pixels == scrollCn.position.maxScrollExtent &&
          !isLoadMore) {
        getMoreHandData();
      }
    });
    super.initState();
  }

  getMoreHandData() async {
    setState(() {
      isLoadMore = true;
    });

    page = page + 1;
    widget.onStartPage();
    setState(() {
      isLoadMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final lang = S.of(context);
    return ScaffoldImage(
      appBar: customAppBar(
        title: widget.appBarTitle,
        context: context,
        color: ColorManager.primaryW,
      ),
      bgColor: Assets.assetsImagesBgColor,
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
                  return buildShimmerIndicatorGrid(context);
                }, loading: () {
                  return buildShimmerIndicatorGrid(context);
                }, success: () {
                  if (widget.isHandpicked) {
                    products = cubit.productsHandpack;
                  } else {
                    products = cubit.products;
                  }
                  if (cubit
                      .filterListByCategory(cubit.category, products)
                      .isEmpty) {
                    return SizedBox(
                      height: 450.h,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.notFoundTitle,
                            style: AppStylesManager.customTextStyleG2,
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: GridView.builder(
                        controller: scrollCn,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          crossAxisSpacing: 1.sw > 600 ? 14 : 16.0,
                          mainAxisExtent: 150,
                          mainAxisSpacing: 1.sw > 600 ? 16 : 12,
                        ),
                        shrinkWrap: true,
                        itemCount: isLoadMore
                            ? cubit
                                    .filterListByCategory(
                                        cubit.category, products)
                                    .length +
                                1
                            : cubit
                                .filterListByCategory(cubit.category, products)
                                .length,
                        itemBuilder: (context, sizeIndex) {
                          if (sizeIndex ==
                                  cubit
                                      .filterListByCategory(
                                        cubit.category,
                                        products,
                                      )
                                      .length &&
                              isLoadMore) {
                            return buildShimmerIndicatorSmall();
                          } else {
                            final productItem = cubit.filterListByCategory(
                                cubit.category, products)[sizeIndex];
                            return wideCard(
                                context: context, product: productItem);
                          }
                        },
                      ),
                    );
                  }
                }, failure: (message) {
                  return Text(widget.notFoundTitle);
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
            isDark: true,
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
            const Icon(
              Icons.tune,
              color: ColorManager.primaryW,
            ),
            const SizedBox(
              width: 8,
            ),
            Visibility(
              // visible: HiveStorage.get(HiveKeys.isStore),
              child: Expanded(
                child: GendarFilterWidget(
                  isDark: false,
                  selectedCategory: cubit.gendar,
                  onSelected: (gendar) {
                    cubit.gendar = gendar;
                    widget.onStartPage();
                    setState(() {});
                  },
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
