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
import '../../domain/models/product_model.dart';

class DiscoverView extends StatefulWidget {
  const DiscoverView({super.key});

  @override
  State<DiscoverView> createState() => _DiscoverViewState();
}

class _DiscoverViewState extends State<DiscoverView> {
  late final ProductsCubit cubit;

  @override
  void initState() {
    cubit = ProductsCubit.get(context);
    cubit.getRandomProducts();
    cubit.getNewInProducts();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return ScaffoldImage(
      appBar: customAppBar(
          title: lang.discover, context: context, hasLeading: false),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          return state.maybeWhen(
            loading: () {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Image.asset(
                        Assets.assetsImagesDiscover,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        lang.discoverOurNewAndSpecialProductsFromHere,
                        style: AppStylesManager.customTextStyleB4,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
            newInProductSuccess: (products) => SingleChildScrollView(
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
                            onStartPage: (isPage) {
                              cubit.getNewInProducts(isPage);
                            },
                          ));
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ProductNewInView(
                    products: cubit.newInProducts,
                  ),
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
                          onStartPage: (isPage) {
                            cubit.getRandomProducts(isPage);
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  HandPickedView(
                    products: cubit.randomProducts,
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            randomProductSuccess: (products) => SingleChildScrollView(
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
                            onStartPage: (isPage) {
                              cubit.getNewInProducts(isPage);
                            },
                          ));
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ProductNewInView(
                    products: cubit.newInProducts,
                  ),
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
                          onStartPage: (isPage) {
                            cubit.getRandomProducts(isPage);
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  HandPickedView(
                    products: cubit.randomProducts,
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            orElse: () => SingleChildScrollView(
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
                            onStartPage: (isPage) {
                              cubit.getNewInProducts(isPage);
                            },
                          ));
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ProductNewInView(
                    products: cubit.newInProducts,
                  ),
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
                          onStartPage: (isPage) {
                            cubit.getRandomProducts(isPage);
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  HandPickedView(
                    products: cubit.randomProducts,
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            failure: (_) => Text(_),
          )!;
        },
      ),
    );
  }
}

class ProductNewInView extends StatelessWidget {
  const ProductNewInView({
    super.key,
    required this.products,
  });
  final List<ProductModel> products;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (products.isEmpty) {
          return SizedBox(
            height: 120.w,
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
            height: 270.w,
            child: ListView.builder(
              itemBuilder: (context, index) {
                final product = products[index];
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: productSquarItem(
                    context: context,
                    product: product,
                  ),
                );
              },
              itemCount: products.length,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(right: 8),
            ),
          ),
        );
      },
    );
  }
}

class HandPickedView extends StatelessWidget {
  const HandPickedView({
    super.key,
    required this.products,
  });
  final List<ProductModel> products;
  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
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
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return productSquarItem(
            context: context,
            product: product,
          );
        },
      ),
    );
  }
}
