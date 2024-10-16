import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/constants/assets.dart';
import 'package:nilelon/core/tools.dart';
import 'package:nilelon/features/product/domain/models/product_model.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_cubit.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_state.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/features/product/presentation/pages/product_handpack_all_page.dart';
import 'package:nilelon/features/product/presentation/widgets/product_card/product_squar_item.dart';
import 'package:nilelon/core/widgets/shimmer_indicator/build_shimmer.dart';
import 'package:nilelon/core/widgets/view_all_row/view_all_row.dart';
import 'package:nilelon/features/product/presentation/pages/product_new_in_all_widget.dart';

import '../widgets/product_card/offers_card.dart';
import '../../../../core/widgets/scaffold_image.dart';

class DiscoverView extends StatefulWidget {
  const DiscoverView({super.key});

  @override
  State<DiscoverView> createState() => _DiscoverViewState();
}

class _DiscoverViewState extends State<DiscoverView> {
  int newInPage = 1;
  int newInPageSize = 10;
  bool newInIsLoadMore = false;
  ScrollController scrollController = ScrollController();
  int handPage = 1;
  late final ProductsCubit cubit;

  int handPageSize = 10;
  bool handIsLoadMore = false;
  ScrollController handScrollController = ScrollController();

  @override
  void initState() {
    cubit = ProductsCubit.get(context);
    cubit.getRandomProducts(newInPage, newInPageSize);
    cubit.getNewInProducts(newInPage, newInPageSize);

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !newInIsLoadMore) {
        getMoreNewInData();
      }
    });
    handScrollController.addListener(() {
      if (handScrollController.position.pixels ==
              handScrollController.position.maxScrollExtent &&
          !handIsLoadMore) {
        getMoreHandData();
      }
    });
    super.initState();
  }

  getMoreNewInData() async {
    setState(() {
      newInIsLoadMore = true;
    });

    newInPage = newInPage + 1;
    cubit.getNewInProducts(newInPage, newInPageSize);
    setState(() {
      newInIsLoadMore = false;
    });
  }

  getMoreHandData() async {
    setState(() {
      handIsLoadMore = true;
    });

    handPage = handPage + 1;
    cubit.getRandomProducts(newInPage, newInPageSize);

    setState(() {
      handIsLoadMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return ScaffoldImage(
      appBar: customAppBar(
          title: lang.discover, context: context, hasLeading: false),
      body: BlocListener<ProductsCubit, ProductsState>(
        listener: (context, state) {
          state.mapOrNull(
            success: (_) => setState(() {}),
          );
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              const DefaultDivider(),
              const SizedBox(
                height: 8,
              ),
              Text(
                lang.discoverOurNewAndSpecialProductsFromHere,
                style: AppStylesManager.customTextStyleG24,
              ),
              const SizedBox(
                height: 16,
              ),
              Column(
                children: [
                  ViewAllRow(
                      assetName: Assets.assetsImagesNewIn,
                      noTextIcon: false,
                      text: lang.newIn,
                      onPressed: () {
                        navigateTo(
                            context: context,
                            screen: const ProductNewInViewAll(
                              isStore: false,
                            ));
                      }),
                  const SizedBox(
                    height: 16,
                  ),
                  ProductNewInView(newInIsLoadMore: newInIsLoadMore),
                  const SizedBox(height: 20),
                  ViewAllRow(
                      text: lang.handPicked,
                      assetName: Assets.assetsImagesHandPicked,
                      noTextIcon: false,
                      onPressed: () {
                        navigateTo(
                            context: context,
                            screen: const HandPickedViewAll());
                      }),
                  HandPickedView(
                    handScrollController: handScrollController,
                    handIsLoadMore: handIsLoadMore,
                  ),
                  const SizedBox(height: 30),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProductNewInView extends StatelessWidget {
  const ProductNewInView({
    super.key,
    required this.newInIsLoadMore,
  });

  final bool newInIsLoadMore;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        return state.when(initial: () {
          return buildShimmerIndicatorRow();
        }, loading: () {
          return buildShimmerIndicatorRow();
        }, success: () {
          if (ProductsCubit.get(context).products.isEmpty) {
            return SizedBox(
              height: 120.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).noProductNewIn,
                    style: AppStylesManager.customTextStyleG2,
                  ),
                ],
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              height: 1.sw > 600 ? 310 : 320,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  if (index == ProductsCubit.get(context).products.length &&
                      newInIsLoadMore) {
                    return buildShimmerIndicatorSmall();
                  } else {
                    if (checkIsHasDiscount(
                        ProductsCubit.get(context).products, index)) {
                      return offersCard(
                          context: context,
                          product: ProductsCubit.get(context).products[index]);
                    }
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: productSquarItem(
                        context: context,
                        product: ProductsCubit.get(context).products[index],
                      ),
                    );
                  }
                },
                itemCount: newInIsLoadMore
                    ? ProductsCubit.get(context).products.length + 1
                    : ProductsCubit.get(context).products.length,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(right: 8),
              ),
            ),
          );
        }, failure: (message) {
          return SizedBox(
            height: 150.h,
            child: Center(
              child: Text(message),
            ),
          );
        });
      },
    );
  }
}

bool checkIsHasDiscount(List<ProductModel> productsList, int index) {
  return productsList[index].productVariants.first.discountRate != 0;
}

class HandPickedView extends StatefulWidget {
  const HandPickedView({
    super.key,
    required this.handScrollController,
    required this.handIsLoadMore,
  });

  final ScrollController handScrollController;
  final bool handIsLoadMore;

  @override
  State<HandPickedView> createState() => _HandPickedViewState();
}

class _HandPickedViewState extends State<HandPickedView> {
  @override
  void initState() {
    ProductsCubit.get(context).getRandomProducts(1, 100);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (context, state) {
        state.mapOrNull(success: (_) {
          // setState(() {});
        });
      },
      builder: (context, state) {
        return state.when(initial: () {
          return buildShimmerIndicatorGrid();
        }, loading: () {
          return buildShimmerIndicatorGrid();
        }, success: () {
          if (ProductsCubit.get(context).productsHandpack.isEmpty) {
            return Text(
              S.of(context).noProductHandPicked,
              style: AppStylesManager.customTextStyleG2,
            );
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: GridView.builder(
              controller: widget.handScrollController,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: gridDelegate,
              shrinkWrap: true,
              itemCount: ProductsCubit.get(context).productsHandpack.length,
              itemBuilder: (context, index) {
                if (index ==
                        ProductsCubit.get(context).productsHandpack.length &&
                    widget.handIsLoadMore) {
                  return buildShimmerIndicatorSmall();
                } else {
                  if (checkIsHasDiscount(
                      ProductsCubit.get(context).products, index)) {
                    return offersCard(
                        context: context,
                        product:
                            ProductsCubit.get(context).productsHandpack[index]);
                  }
                  return productSquarItem(
                    context: context,
                    product: ProductsCubit.get(context).productsHandpack[index],
                  );
                }
              },
            ),
          );
        }, failure: (message) {
          return SizedBox(
            height: 200.h,
            child: Center(
              child: Text(message),
            ),
          );
        });
      },
    );
  }
}
