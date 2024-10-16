import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/features/categories/presentation/widget/category_filter_widget.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_cubit.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_state.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/features/product/presentation/widgets/product_card/product_squar_item.dart';
import 'package:nilelon/core/widgets/shimmer_indicator/build_shimmer.dart';

import '../../../../core/tools.dart';
import '../../../../core/widgets/scaffold_image.dart';
import '../../../categories/presentation/widget/gander_filter_widget copy.dart';
import '../../domain/models/product_model.dart';

class FollowingViewAll extends StatefulWidget {
  const FollowingViewAll({super.key});

  @override
  State<FollowingViewAll> createState() => _FollowingViewAllState();
}

class _FollowingViewAllState extends State<FollowingViewAll> {
  int selectedGender = 0;
  int page = 1;
  late final ProductsCubit cubit;
  int pageSize = 10;
  bool isLoadMore = false;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    cubit = ProductsCubit.get(context);
    _loadInitialData();
    _setupScrollListener();
    super.initState();
  }

  void _loadInitialData() {
    cubit.getFollowedProducts(page, pageSize);
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
    cubit.getFollowedProducts(page, pageSize);

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
                  success: () => _buildProductGrid(cubit.filterListByCategory(
                      cubit.category, ProductsCubit.get(context).products)),
                  failure: (message) => SizedBox(
                      height: 450.h,
                      child:
                          Center(child: Text(S.of(context).noProductFollow))),
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
          child: CategoryFilterWidget(
            selectedCategory: cubit.category,
            onSelected: (category) {},
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const SizedBox(width: 16),
            const Icon(Icons.tune),
            const SizedBox(width: 8),
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
              product: productsList[index],
            );
          }
        },
      ),
    );
  }
}
