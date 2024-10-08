import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_cubit.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_state.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/cards/small/product_squar_item.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/filter/category_container.dart';
import 'package:nilelon/core/widgets/filter/filter_container.dart';
import 'package:nilelon/core/widgets/filter/static_lists.dart';
import 'package:nilelon/core/widgets/shimmer_indicator/build_shimmer.dart';

import '../../../../core/tools.dart';
import '../../../../core/widgets/cards/offers/offers_card.dart';
import '../../../../core/widgets/scaffold_image.dart';

class HandPickedViewAll extends StatefulWidget {
  const HandPickedViewAll({super.key});

  @override
  State<HandPickedViewAll> createState() => _HandPickedViewAllState();
}

class _HandPickedViewAllState extends State<HandPickedViewAll> {
  int selectedGender = 0;
  int selectedCategory = 0;
  int handPage = 5;
  int handPageSize = 1;
  bool handIsLoadMore = false;
  ScrollController handScrollController = ScrollController();

  @override
  void initState() {
    BlocProvider.of<ProductsCubit>(context)
        .getRandomProducts(handPage, handPageSize);
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
    await BlocProvider.of<ProductsCubit>(context)
        .getNewInProducts(handPage, handPageSize);
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
                  return ProductsCubit.get(context).products.isEmpty
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
                                ? ProductsCubit.get(context).products.length + 1
                                : ProductsCubit.get(context).products.length,
                            itemBuilder: (context, sizeIndex) {
                              if (sizeIndex ==
                                      ProductsCubit.get(context)
                                          .products
                                          .length &&
                                  handIsLoadMore) {
                                return buildShimmerIndicatorSmall();
                              } else {
                                return ProductsCubit.get(context)
                                            .products[sizeIndex]
                                            .productVariants
                                            .first
                                            .discountRate !=
                                        0
                                    ? offersCard(
                                        context: context,
                                        product: ProductsCubit.get(context)
                                            .products[sizeIndex])
                                    : productSquarItem(
                                        context: context,
                                        model: ProductsCubit.get(context)
                                            .products[sizeIndex],
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
            const Icon(Icons.tune),
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
