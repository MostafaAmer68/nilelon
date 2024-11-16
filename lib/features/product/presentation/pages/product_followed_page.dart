import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/tools.dart';
import 'package:nilelon/generated/l10n.dart';

import '../../../../core/data/hive_stroage.dart';
import '../../../../core/resources/appstyles_manager.dart';
import '../widgets/product_card/product_squar_item.dart';
import '../../../../core/widgets/shimmer_indicator/build_shimmer.dart';
import '../cubit/products_cubit/products_cubit.dart';
import '../cubit/products_cubit/products_state.dart';

class FollowedProductPage extends StatefulWidget {
  const FollowedProductPage({super.key});

  @override
  State<FollowedProductPage> createState() => _FollowedProductPageState();
}

class _FollowedProductPageState extends State<FollowedProductPage> {
  int page = 1;
  int pageSize = 5;
  bool isLoadMore = false;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // if (HiveStorage.get(HiveKeys.userModel) != null) {
    ProductsCubit.get(context).products.clear();
    ProductsCubit.get(context).productsHandpack.clear();
    if (HiveStorage.get(HiveKeys.userModel) != null) {
      ProductsCubit.get(context).getFollowedProducts(page, pageSize);
      scrollController.addListener(() {
        if (scrollController.position.pixels ==
                scrollController.position.maxScrollExtent &&
            !isLoadMore) {
          getMoreData();
        }
      });
    }
    log('product');
    // }
    super.initState();
  }

  getMoreData() async {
    setState(() {
      isLoadMore = true;
    });

    page = page + 1;
    if (HiveStorage.get(HiveKeys.userModel) != null) {
      ProductsCubit.get(context).getFollowedProducts(page, pageSize);
    }
    setState(() {
      isLoadMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        return state.when(initial: () {
          return Center(child: Text(lang(context).guestMsg));
        }, loading: () {
          return buildShimmerIndicatorGrid(context);
        }, success: () {
          if (ProductsCubit.get(context).products.isEmpty) {
            return SizedBox(
              height: 180.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).noFollowingAnyStore,
                    style: AppStylesManager.customTextStyleG2,
                  ),
                ],
              ),
            );
          } else {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: GridView.builder(
                controller: scrollController,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: gridDelegate(context),
                shrinkWrap: true,
                itemCount: isLoadMore
                    ? ProductsCubit.get(context).products.length + 1
                    : ProductsCubit.get(context).products.length,
                itemBuilder: (context, sizeIndex) {
                  if (sizeIndex == ProductsCubit.get(context).products.length &&
                      isLoadMore) {
                    return buildShimmerIndicatorSmall();
                  } else {
                    return productSquarItem(
                      context: context,
                      product: ProductsCubit.get(context).products[sizeIndex],
                    );
                  }
                },
              ),
            );
          }
        }, failure: (message) {
          return SizedBox(
              height: 100,
              child: Center(child: Text(S.of(context).noProductFollow)));
        });
      },
    );
  }
}
