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
import 'package:nilelon/core/widgets/filter/category_container.dart';
import 'package:nilelon/core/widgets/filter/filter_container.dart';
import 'package:nilelon/core/widgets/filter/static_lists.dart';
import 'package:nilelon/core/widgets/shimmer_indicator/build_shimmer.dart';

import '../../../../core/tools.dart';
import '../../../../core/widgets/scaffold_image.dart';
import '../../domain/models/product_model.dart';

class FollowingViewAll extends StatefulWidget {
  const FollowingViewAll({super.key});

  @override
  State<FollowingViewAll> createState() => _FollowingViewAllState();
}

class _FollowingViewAllState extends State<FollowingViewAll> {
  int selectedGender = 0;
  int selectedCategory = 0;
  int page = 1;
  int pageSize = 10;
  bool isLoadMore = false;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadInitialData();
    _setupScrollListener();
  }

  void _loadInitialData() {
    BlocProvider.of<ProductsCubit>(context)
        .getFollowedProductsPagination(page, pageSize);
  }

  void _setupScrollListener() {
    scrollController.addListener(() {
      if (_isEndOfScroll() && !isLoadMore) {
        _loadMoreData();
      }
    });
  }

  bool _isEndOfScroll() {
    return scrollController.position.pixels ==
        scrollController.position.maxScrollExtent;
  }

  Future<void> _loadMoreData() async {
    setState(() {
      isLoadMore = true;
    });

    page += 1;
    await BlocProvider.of<ProductsCubit>(context)
        .getFollowedProductsPagination(page, pageSize);

    setState(() {
      isLoadMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return ScaffoldImage(
      appBar: customAppBar(title: lang.following, context: context),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            const SizedBox(height: 8),
            _buildFilters(context),
            BlocBuilder<ProductsCubit, ProductsState>(
              builder: (context, state) {
                return state.when(
                  initial: buildShimmerIndicatorGrid,
                  loading: buildShimmerIndicatorGrid,
                  success: () =>
                      _buildProductGrid(ProductsCubit.get(context).products),
                  failure: (message) => Center(child: Text(message)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SizedBox(
            height: screenWidth(context, 0.28),
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: categoryFilter.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCategory = index;
                  });
                },
                child: categoryContainer(
                  context: context,
                  image: categoryFilter[index]['image'],
                  name: categoryFilter[index]['name'],
                  isSelected: selectedCategory == index,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const SizedBox(width: 16),
            const Icon(Icons.tune),
            const SizedBox(width: 8),
            Expanded(
              child: SizedBox(
                height: 52,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: genderFilter.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGender = index;
                      });
                    },
                    child: filterContainer(
                      genderFilter[index],
                      selectedGender == index,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildProductGrid(List<ProductModel> productsList) {
    if (productsList.isEmpty) {
      return SizedBox(
        height: 450.h,
        child: Center(
          child: Text(
            S.of(context).noProductFollow,
            style: AppStylesManager.customTextStyleG2,
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: GridView.builder(
        controller: scrollController,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: gridDelegate,
        itemCount: isLoadMore ? productsList.length + 1 : productsList.length,
        itemBuilder: (context, index) {
          if (index == productsList.length && isLoadMore) {
            return buildShimmerIndicatorSmall();
          } else {
            return productSquarItem(
              context: context,
              model: productsList[index],
            );
          }
        },
      ),
    );
  }
}
