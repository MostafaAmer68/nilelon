import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/features/categories/domain/model/result.dart';
import 'package:nilelon/features/categories/presentation/cubit/category_cubit.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_cubit.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_state.dart';
import 'package:nilelon/core/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/cards/small/market_small_card.dart';
import 'package:nilelon/core/widgets/cards/small/small_card.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/filter/category_container.dart';
import 'package:nilelon/core/widgets/filter/filter_container.dart';
import 'package:nilelon/core/widgets/filter/static_lists.dart';
import 'package:nilelon/core/widgets/shimmer_indicator/build_shimmer.dart';

class NewInViewAll extends StatefulWidget {
  const NewInViewAll({super.key, required this.isStore});
  final bool isStore;

  @override
  State<NewInViewAll> createState() => _NewInViewAllState();
}

class _NewInViewAllState extends State<NewInViewAll> {
  int selectedGender = 0;
  int selectedCategory = 0;
  int page = 5;
  int pageSize = 1;
  bool isLoadMore = false;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    BlocProvider.of<ProductsCubit>(context).getNewInProducts(page, pageSize);
    BlocProvider.of<CategoryCubit>(context).getCategories();
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
        .getNewInProductsPagination(page, pageSize);
    setState(() {
      isLoadMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    return Scaffold(
      backgroundColor: ColorManager.primaryW,
      appBar: customAppBar(title: lang.newIn, context: context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const DefaultDivider(),
            const SizedBox(
              height: 8,
            ),
            filtersColumn(context),
            widget.isStore
                ? GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1.sw > 600 ? 3 : 2,
                        crossAxisSpacing: 1.sw > 600 ? 14 : 16.0,
                        mainAxisExtent: 1.sw > 600 ? 320 : 220,
                        mainAxisSpacing: 1.sw > 600 ? 16 : 12),
                    shrinkWrap: true,
                    itemCount: 7,
                    itemBuilder: (context, sizeIndex) {
                      return Container(
                          // child: marketSmallCard(context: context),
                          );
                    },
                  )
                : BlocBuilder<ProductsCubit, ProductsState>(
                    builder: (context, state) {
                      return state.getNewInProducts.when(initial: () {
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
                                      'There is no new in products yet.',
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
                    image: HiveStorage.get<List<Result>>(
                            HiveKeys.categories)[index]
                        .image!,
                    name: HiveStorage.get<List<Result>>(
                            HiveKeys.categories)[index]
                        .name!,
                    isSelected: selectedCategory == index,
                  )),
              itemCount:
                  HiveStorage.get<List<Result>>(HiveKeys.categories).length,
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