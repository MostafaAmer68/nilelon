import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/constants/assets.dart';
import 'package:nilelon/core/tools.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_cubit.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_state.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/features/product/presentation/pages/products_view_all.dart';
import 'package:nilelon/features/product/presentation/widgets/product_card/product_squar_item.dart';
import 'package:nilelon/core/widgets/shimmer_indicator/build_shimmer.dart';
import 'package:nilelon/core/widgets/view_all_row/view_all_row.dart';

import '../../../../core/widgets/scaffold_image.dart';

class DiscoverView extends StatefulWidget {
  const DiscoverView({super.key});

  @override
  State<DiscoverView> createState() => _DiscoverViewState();
}

class _DiscoverViewState extends State<DiscoverView> {
  int pageNum = 1;
  late final ProductsCubit cubit;

  int pageSize = 10;

  @override
  void initState() {
    cubit = ProductsCubit.get(context);
    cubit.getRandomProducts(pageNum, pageSize);
    cubit.getNewInProducts(pageNum, pageSize);

    super.initState();
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
                style: AppStylesManager.customTextStyleG3,
              ),
              const SizedBox(
                height: 16,
              ),
              ViewAllRow(
                assetName: Assets.assetsImagesNewIn,
                noTextIcon: false,
                text: lang.newIn,
                onPressed: () {
                  navigateTo(
                      context: context,
                      screen: ProductsViewAll(
                        notFoundTitle: lang.noProductNewIn,
                        isHandpicked: false,
                        appBarTitle: lang.newIn,
                        onStartPage: () {
                          cubit.getNewInProducts(pageNum, pageSize);
                        },
                      ));
                },
              ),
              const SizedBox(
                height: 16,
              ),
              const ProductNewInView(),
              const SizedBox(height: 16),
              ViewAllRow(
                text: lang.handPicked,
                assetName: Assets.assetsImagesHandPicked,
                noTextIcon: false,
                onPressed: () {
                  navigateTo(
                    context: context,
                    screen: ProductsViewAll(
                      notFoundTitle: lang.noProductHandPicked,
                      isHandpicked: true,
                      appBarTitle: lang.handPicked,
                      onStartPage: () {
                        cubit.getRandomProducts(pageNum, pageSize);
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              const HandPickedView(),
              const SizedBox(height: 30),
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
  });

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
              height: 1.sw > 600 ? 300 : 290,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final product = ProductsCubit.get(context).products[index];
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: productSquarItem(
                      context: context,
                      product: product,
                    ),
                  );
                },
                itemCount: ProductsCubit.get(context).products.length,
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

class HandPickedView extends StatefulWidget {
  const HandPickedView({
    super.key,
  });

  @override
  State<HandPickedView> createState() => _HandPickedViewState();
}

class _HandPickedViewState extends State<HandPickedView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (context, state) {
        state.mapOrNull(success: (_) {});
      },
      builder: (context, state) {
        return state.when(initial: () {
          return buildShimmerIndicatorGrid(context);
        }, loading: () {
          return buildShimmerIndicatorGrid(context);
        }, success: () {
          if (ProductsCubit.get(context).productsHandpack.isEmpty) {
            return Center(
              child: Text(
                S.of(context).noProductHandPicked,
                style: AppStylesManager.customTextStyleG2,
              ),
            );
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: gridDelegate(context),
              shrinkWrap: true,
              itemCount: ProductsCubit.get(context).productsHandpack.length,
              itemBuilder: (context, index) {
                final product =
                    ProductsCubit.get(context).productsHandpack[index];
                return productSquarItem(
                  context: context,
                  product: product,
                );
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
