import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/features/categories/presentation/widget/gander_filter_widget%20copy.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_cubit.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_state.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/features/product/presentation/widgets/product_card/product_squar_item.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/shimmer_indicator/build_shimmer.dart';

import '../../../../core/tools.dart';
import '../../../categories/presentation/widget/category_filter_widget.dart';
import '../widgets/product_card/offers_card.dart';
import '../../../../core/widgets/scaffold_image.dart';

class HandPickedViewAll extends StatefulWidget {
  const HandPickedViewAll({super.key});

  @override
  State<HandPickedViewAll> createState() => _HandPickedViewAllState();
}

class _HandPickedViewAllState extends State<HandPickedViewAll> {
  int selectedGender = 0;
  int handPage = 5;
  late final ProductsCubit cubit;
  int handPageSize = 1;
  bool handIsLoadMore = false;
  ScrollController handScrollController = ScrollController();

  @override
  void initState() {
    cubit = ProductsCubit.get(context);
    cubit.getRandomProducts(handPage, handPageSize);
    handScrollController.addListener(() {
      if (handScrollController.position.pixels ==
              handScrollController.position.maxScrollExtent &&
          !handIsLoadMore) {
        getMoreHandData();
      }
    });
    super.initState();
  }

  getMoreHandData() async {
    setState(() {
      handIsLoadMore = true;
    });

    handPage = handPage + 1;
    cubit.getNewInProducts(handPage, handPageSize);
    setState(() {
      handIsLoadMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return ScaffoldImage(
      appBar: customAppBar(title: lang.handPicked, context: context),
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
                  return ProductsCubit.get(context).productsHandpack.isEmpty
                      ? SizedBox(
                          height: 450.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                S.of(context).noProductHandPicked,
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
                            gridDelegate: gridDelegate,
                            shrinkWrap: true,
                            itemCount: handIsLoadMore
                                ? cubit
                                        .filterListByCategory(
                                            cubit.category,
                                            ProductsCubit.get(context)
                                                .productsHandpack)
                                        .length +
                                    1
                                : ProductsCubit.get(context)
                                    .productsHandpack
                                    .length,
                            itemBuilder: (context, sizeIndex) {
                              if (sizeIndex ==
                                      cubit
                                          .filterListByCategory(
                                              cubit.category,
                                              ProductsCubit.get(context)
                                                  .productsHandpack)
                                          .length &&
                                  handIsLoadMore) {
                                return buildShimmerIndicatorSmall();
                              } else {
                                if (cubit
                                        .filterListByCategory(
                                            cubit.category,
                                            ProductsCubit.get(context)
                                                .productsHandpack)[sizeIndex]
                                        .productVariants
                                        .first
                                        .discountRate !=
                                    0) {
                                  return offersCard(
                                      context: context,
                                      product: cubit.filterListByCategory(
                                          cubit.category,
                                          ProductsCubit.get(context)
                                              .productsHandpack)[sizeIndex]);
                                } else {
                                  return productSquarItem(
                                    context: context,
                                    product: cubit.filterListByCategory(
                                        cubit.category,
                                        ProductsCubit.get(context)
                                            .productsHandpack)[sizeIndex],
                                  );
                                }
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
