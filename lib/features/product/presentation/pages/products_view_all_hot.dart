import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/constants/assets.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/widgets/cards/wide/wide_card.dart';
import 'package:nilelon/features/categories/presentation/widget/gander_filter_widget.dart';
import 'package:nilelon/features/product/domain/models/product_response.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_cubit.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_state.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/shimmer_indicator/build_shimmer.dart';

import '../../../../core/data/hive_stroage.dart';
import '../../../../core/utils/navigation.dart';
import '../../../auth/domain/model/user_model.dart';
import '../../../categories/domain/model/result.dart';
import '../../../categories/presentation/widget/category_filter_widget.dart';
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

  final Function(bool isPage) onStartPage;

  @override
  State<ProductsViewAllHot> createState() => _ProductsViewAllHotState();
}

class _ProductsViewAllHotState extends State<ProductsViewAllHot> {
  late final ProductsCubit cubit;
  ProductResponse paginationList = ProductResponse.empty();
  bool isLoadingMore = false;
  late ScrollController scrollController;

  @override
  void dispose() {
    cubit.category = CategoryModel.empty();
    cubit.gendar = '';
    cubit.page = 1;
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    cubit = ProductsCubit.get(context);
    cubit.gendar = HiveStorage.get<UserModel>(HiveKeys.userModel)
        .getUserData<CustomerModel>()
        .productsChoice;
    widget.onStartPage(true);
    scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 100 &&
          !isLoadingMore) {
        _loadMoreProducts();
      }
    });
  }

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
      appBar: customAppBar(
        title: widget.appBarTitle,
        context: context,
        color: ColorManager.primaryW,
      ),
      bgColor: Assets.assetsImagesBgColor,
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
                  return _buildProductGrid(cubit.randomProducts);
                },
                failure: (message) => _buildErrorMessage(message),
                orElse: () => SizedBox(
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
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid(ProductResponse products) {
    if (products.data.isEmpty && paginationList.data.isEmpty) {
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
    }

    if (paginationList.data.isEmpty || cubit.page == 1) {
      paginationList =
          paginationList.copyWith(data: [], metaData: MetaDataProducts.ampty());
    }

    final temp = paginationList.data.toList();
    temp.addAll(products.data);
    paginationList = paginationList.copyWith(
        data: temp.toSet().toList(), metaData: products.metaData);

    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: GridView.builder(
          controller: scrollController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 1.sw > 600 ? 14 : 16.0,
            mainAxisExtent: !HiveStorage.get(HiveKeys.isStore) ? 170.w : 150.w,
            mainAxisSpacing: 1.sw > 600 ? 16 : 12,
          ),
          itemCount: cubit
                  .filterListByCategory(cubit.category, paginationList.data)
                  .length +
              (isLoadingMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == paginationList.data.length) {
              return const Center(child: CircularProgressIndicator());
            }

            final productItem = cubit.filterListByCategory(
                cubit.category, paginationList.data)[index];
            return WideCard(product: productItem);
          },
        ),
      ),
    );
  }

  Widget _buildErrorMessage(String message) {
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
              paginationList.data.clear(); // Clear pagination list
              cubit.page = 1; // Reset page
              widget.onStartPage(true);
              setState(() {});
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
                        onChanged: (v) {
                          cubit.limit = int.parse(v.isEmpty ? '0' : v);
                          setState(() {});
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
                                  text: 'please enter page size above 0');
                            }
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Icon(
                Icons.tune,
                color: ColorManager.primaryW,
              ),
            ),
            const SizedBox(width: 8),
            Visibility(
              child: Expanded(
                child: GendarFilterWidget(
                  isDark: false,
                  selectedCategory: cubit.gendar,
                  onSelected: (gendar) {
                    cubit.gendar = gendar;
                    widget.onStartPage(false);
                    setState(() {});
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
