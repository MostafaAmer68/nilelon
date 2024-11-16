import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/widgets/text_form_field/text_field/text_form_field_builder.dart';
import 'package:nilelon/features/categories/domain/model/result.dart';
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
import '../../../../core/utils/navigation.dart';
import '../../../categories/presentation/widget/category_filter_widget.dart';
import '../../domain/models/product_model.dart';
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
    required this.isHandpicked,
  });
  final String appBarTitle;
  final String notFoundTitle;
  final bool isHandpicked;
  final bool isStore;
  final bool isOffer;

  final VoidCallback onStartPage;
  @override
  State<ProductsViewAll> createState() => _ProductsViewAllState();
}

class _ProductsViewAllState extends State<ProductsViewAll> {
  late final ProductsCubit cubit;
  List<ProductModel> products = [];
  @override
  void dispose() {
    cubit.category = CategoryModel.empty();
    cubit.gendar = 'All';
    cubit.products.clear();
    // cubit.getFollowedProducts();
    cubit.productsHandpack.clear();
    cubit.scroll.dispose();
    super.dispose();
  }

  bool isPullDown = false;

  @override
  void initState() {
    cubit = ProductsCubit.get(context);
    widget.onStartPage();
    cubit.scroll = ScrollController();
    cubit.scroll.addListener(() {
      double currentPos = cubit.scroll.position.pixels;
      double maxPos = cubit.scroll.position.maxScrollExtent;
      if (maxPos >= currentPos) {
        widget.onStartPage();
        cubit.page += 1;
        if (products.isEmpty || cubit.productsHandpack.isEmpty) {
          cubit.page = cubit.page - 1;
        }
      }

      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final lang = S.of(context);
    return ScaffoldImage(
      appBar: customAppBar(title: widget.appBarTitle, context: context),
      // bgColor: ColorManager.primaryB6,
      body: Column(
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
                return Expanded(child: buildShimmerIndicatorGrid(context));
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
                    height: screenHeight(context, 0.6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.notFoundTitle),
                      ],
                    ),
                  );
                } else {
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: GridView.builder(
                        controller: cubit.scroll,
                        // physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: widget.isOffer
                            ? SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1.sw > 600 ? 3 : 2,
                                crossAxisSpacing: 1.sw > 600 ? 14 : 16.0,
                                mainAxisExtent: 295.w,
                                mainAxisSpacing: 1.sw > 600 ? 16 : 12,
                              )
                            : gridDelegate(context),
                        shrinkWrap: true,
                        itemCount: cubit
                            .filterListByCategory(cubit.category, products)
                            .length,
                        itemBuilder: (context, sizeIndex) {
                          final productItem = cubit.filterListByCategory(
                              cubit.category, products)[sizeIndex];
                          if (widget.isOffer) {
                            return offersCard(
                              context: context,
                              product: productItem,
                            );
                          } else {
                            if (widget.isStore) {
                              return marketSmallCard(
                                context: context,
                                product: productItem,
                              );
                            } else {
                              return productSquarItem(
                                context: context,
                                product: productItem,
                              );
                            }
                          }
                        },
                      ),
                    ),
                  );
                }
              }, failure: (message) {
                return SizedBox(
                    height: screenHeight(context, 0.6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.notFoundTitle),
                      ],
                    ));
              });
            },
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
            InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return SimpleDialog(
                          contentPadding: const EdgeInsets.all(5),
                          titlePadding: const EdgeInsets.all(20),
                          title: TextField(
                            controller: TextEditingController(
                                text: cubit.limit.toString()),
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
                                  widget.onStartPage();
                                } else {
                                  BotToast.showText(
                                      text: 'please enter page size above 0');
                                }
                              },
                              child: Text(lang(context).ok),
                            )
                          ],
                        );
                      });
                },
                child: Icon(Icons.tune)),
            const SizedBox(
              width: 8,
            ),
            Visibility(
              // visible: HiveStorage.get(HiveKeys.isStore),
              child: Expanded(
                child: GendarFilterWidget(
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
