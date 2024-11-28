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
  @override
  void initState() {
    if (HiveStorage.get(HiveKeys.userModel) != null) {
      ProductsCubit.get(context).getFollowedProducts();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        return state.maybeWhen(initial: () {
          return Center(child: Text(lang(context).guestMsg));
        }, loading: () {
          return buildShimmerIndicatorGrid(context);
        }, success: () {
          if (ProductsCubit.get(context).followingProducts.data.isEmpty) {
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
                controller: ProductsCubit.get(context).scroll,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: gridDelegate(context),
                shrinkWrap: true,
                itemCount:
                    ProductsCubit.get(context).followingProducts.data.length,
                itemBuilder: (context, sizeIndex) {
                  return productSquarItem(
                    context: context,
                    product: ProductsCubit.get(context)
                        .followingProducts
                        .data[sizeIndex],
                  );
                },
              ),
            );
          }
        }, failure: (message) {
          return SizedBox(
              height: 100,
              child: Center(child: Text(S.of(context).noProductFollow)));
        }, orElse: () {
          if (ProductsCubit.get(context).followingProducts.data.isEmpty) {
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
                controller: ProductsCubit.get(context).scroll,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: gridDelegate(context),
                shrinkWrap: true,
                itemCount:
                    ProductsCubit.get(context).followingProducts.data.length,
                itemBuilder: (context, sizeIndex) {
                  return productSquarItem(
                    context: context,
                    product: ProductsCubit.get(context)
                        .followingProducts
                        .data[sizeIndex],
                  );
                },
              ),
            );
          }
        });
      },
    );
  }
}
