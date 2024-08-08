import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_cubit.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_state.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/resources/appstyles_manager.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/resources/const_functions.dart';
import 'package:nilelon/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/widgets/cards/small/small_card.dart';
import 'package:nilelon/widgets/filter/category_container.dart';
import 'package:nilelon/widgets/filter/filter_container.dart';
import 'package:nilelon/widgets/filter/static_lists.dart';
import 'package:nilelon/widgets/shimmer_indicator/build_shimmer.dart';

class FollowingViewAll extends StatefulWidget {
  const FollowingViewAll({super.key});

  @override
  State<FollowingViewAll> createState() => _FollowingViewAllState();
}

class _FollowingViewAllState extends State<FollowingViewAll> {
  int selectedGender = 0;
  int selectedCategory = 0;
  int page = 5;
  int pageSize = 1;
  bool isLoadMore = false;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    BlocProvider.of<ProductsCubit>(context).getFollowedProducts(page, pageSize);
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
    await BlocProvider.of<ProductsCubit>(context)
        .getFollowedProductsPagination(page, pageSize);
    setState(() {
      isLoadMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Scaffold(
      backgroundColor: ColorManager.primaryW,
      appBar: customAppBar(title: lang.following, context: context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            filtersColumn(context),
            BlocBuilder<ProductsCubit, ProductsState>(
              builder: (context, state) {
                return state.getFollowedProducts.when(initial: () {
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
                                'There is no followed products yet.',
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
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1.sw > 600 ? 3 : 2,
                              crossAxisSpacing: 1.sw > 600 ? 14 : 16.0,
                              mainAxisExtent: 1.sw > 600 ? 300 : 220,
                              mainAxisSpacing: 1.sw > 600 ? 16 : 12,
                            ),
                            shrinkWrap: true,
                            itemCount: isLoadMore
                                ? productsList.length + 1
                                : productsList.length,
                            itemBuilder: (context, sizeIndex) {
                              if (sizeIndex == productsList.length &&
                                  isLoadMore) {
                                return buildShimmerIndicatorSmall();
                              } else {
                                return Container(
                                  child: smallCardC(
                                    context: context,
                                    model: productsList[sizeIndex],
                                  ),
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
