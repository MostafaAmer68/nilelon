import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/features/categories/domain/model/result.dart';
import 'package:nilelon/features/categories/presentation/widget/gander_filter_widget.dart';
import 'package:nilelon/features/product/domain/models/product_response.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_cubit.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_state.dart';
import 'package:nilelon/features/product/presentation/widgets/product_card/offers_card.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/features/product/presentation/widgets/product_card/product_squar_item.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/shimmer_indicator/build_shimmer.dart';

import '../../../../core/data/hive_stroage.dart';
import '../../../../core/tools.dart';
import '../../../../core/utils/navigation.dart';
import '../../../categories/presentation/widget/category_filter_widget.dart';
import '../widgets/product_card/market_small_card.dart';
import '../../../../core/widgets/scaffold_image.dart';

class ProductsViewAll extends StatefulWidget {
  const ProductsViewAll({
    super.key,
    required this.appBarTitle,
    required this.onStartPage,
    this.isStore = false,
    this.isOffer = false,
    required this.notFoundTitle,
    required this.type,
  });
  final String appBarTitle;
  final String notFoundTitle;
  final productTypes type;
  final bool isStore;
  final bool isOffer;

  final Function(bool isPagination) onStartPage;

  @override
  State<ProductsViewAll> createState() => _ProductsViewAllState();
}

class _ProductsViewAllState extends State<ProductsViewAll> {
  late final ProductsCubit cubit;
  ProductResponse paginationList = ProductResponse.empty();
  bool isLoadingMore = false;
  late ScrollController scrollController;

  @override
  void dispose() {
    cubit.category = CategoryModel.empty();
    cubit.gendar = '';
    widget.onStartPage(true);
    scrollController.dispose();
    cubit.page = 1;
    widget.onStartPage(true);
    super.dispose();
  }

  double currentScrollPosition = 0;
  @override
  void initState() {
    cubit = ProductsCubit.get(context);
    cubit.gendar = HiveStorage.get(HiveKeys.shopFor) != null
        ? ''
        : HiveStorage.get(HiveKeys.shopFor);
    widget.onStartPage(true);
    scrollController = ScrollController(keepScrollOffset: true);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        currentScrollPosition = scrollController.position.maxScrollExtent;
        _loadMoreProducts();
      }
    });
    super.initState();
  }

  /// Load the next page of products
  void _loadMoreProducts() async {
    if (paginationList.metaData.hasNext) {
      if (!isLoadingMore) {
        setState(() => isLoadingMore = true);
        cubit.page += 1; // Increment page for the next API call
        widget.onStartPage(false); // Trigger fetching next page

        setState(() {
          isLoadingMore = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldImage(
      appBar: customAppBar(title: widget.appBarTitle, context: context),
      body: Column(
        children: [
          const DefaultDivider(),
          const SizedBox(height: 8),
          filtersColumn(context),
          BlocBuilder<ProductsCubit, ProductsState>(
            builder: (context, state) {
              return state.maybeWhen(
                loading: () =>
                    Expanded(child: buildShimmerIndicatorGrid(context)),
                success: () {
                  ProductResponse products = ProductResponse.empty();
                  if (widget.type == productTypes.newIn) {
                    products = cubit.newInProducts;
                  }
                  if (widget.type == productTypes.random) {
                    products = cubit.randomProducts;
                  }
                  if (widget.type == productTypes.offer) {
                    products = cubit.products;
                  }
                  if (widget.type == productTypes.following) {
                    products = cubit.followingProducts;
                  }
                  return _buildProductGrid(products);
                },
                failure: (message) => _buildErrorMessage(message),
                orElse: () {
                  return Expanded(
                    child: buildShimmerIndicatorGrid(context),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  /// Build the product grid with pagination
  Widget _buildProductGrid(ProductResponse products) {
    if (products.data.isEmpty && paginationList.data.isEmpty) {
      return SizedBox(
        height: screenHeight(context, 0.6),
        child: Center(child: Text(widget.notFoundTitle)),
      );
    }

    // Append new products to the pagination list
    if (paginationList.data.isEmpty || cubit.page == 1) {
      paginationList = paginationList.copyWith(
        data: [],
        metaData: MetaDataProducts.ampty(),
      ); // Clear if it's the first page
    }
    final temp = paginationList.data.toList();
    temp.addAll(products.data);
    paginationList = paginationList.copyWith(
        data: temp.toSet().toList(), metaData: products.metaData);
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: GridView.builder(
          controller: scrollController, // Use the custom ScrollController
          gridDelegate: widget.isOffer
              ? gridDelegateOffer(context)
              : gridDelegate(context),
          itemCount: cubit
                  .filterListByCategory(cubit.category, paginationList.data)
                  .length +
              (isLoadingMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index ==
                cubit
                    .filterListByCategory(cubit.category, paginationList.data)
                    .length) {
              // Show loading indicator at the bottom
              return const Center(child: CircularProgressIndicator());
            }

            final productItem = cubit.filterListByCategory(
                cubit.category, paginationList.data)[index];
            return widget.isOffer
                ? offersCard(
                    context: context,
                    product: productItem,
                  )
                : widget.isStore
                    ? marketSmallCard(
                        context: context,
                        product: productItem,
                      )
                    : productSquarItem(
                        context: context,
                        product: productItem,
                      );
          },
        ),
      ),
    );
  }

  /// Display error message
  Widget _buildErrorMessage(String message) {
    return SizedBox(
      height: screenHeight(context, 0.6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message, style: const TextStyle(color: Colors.red)),
        ],
      ),
    );
  }

  Column filtersColumn(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: CategoryFilterWidget(
            selectedCategory: cubit.category,
            onSelected: (category) {
              cubit.category = category;
              paginationList
                  .copyWith(data: []); // Clear pagination when filter changes
              cubit.page = 1; // Reset to the first page
              // widget.onStartPage(true); // Trigger new API call
              cubit.category = category;
              log(cubit.category.name);
              setState(() {}); // Update UI
            },
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const SizedBox(width: 16),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      contentPadding: const EdgeInsets.all(5),
                      titlePadding: const EdgeInsets.all(20),
                      title: TextField(
                        controller:
                            TextEditingController(text: cubit.limit.toString()),
                        onChanged: (value) {
                          cubit.limit = int.parse(value.isEmpty ? '0' : value);
                        },
                        decoration: InputDecoration(
                          prefix: const Icon(Icons.pages),
                          hintText: cubit.limit.toString(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      children: [
                        TextButton(
                          onPressed: () {
                            if (cubit.limit > 0) {
                              navigatePop(context: context);
                              widget.onStartPage(true);
                            } else {
                              BotToast.showText(
                                  text:
                                      'Please enter a valid page size above 0');
                            }
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Icon(Icons.tune),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: GendarFilterWidget(
                selectedCategory: cubit.gendar,
                onSelected: (gendar) {
                  cubit.gendar = gendar;
                  paginationList
                      .copyWith(data: []); // Reset pagination on filter change
                  cubit.page = 1; // Reset page number
                  widget.onStartPage(true);
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
}
