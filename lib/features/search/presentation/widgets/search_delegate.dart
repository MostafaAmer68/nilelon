import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/tools.dart';
import 'package:nilelon/core/widgets/cards/brand/brand_card.dart';
import 'package:nilelon/features/product/data/repositories/products_repos_impl.dart';
import 'package:nilelon/features/product/domain/models/product_model.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_cubit.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_state.dart';
import 'package:nilelon/features/product/presentation/widgets/product_card/product_squar_item.dart';
import 'package:nilelon/features/profile/data/repositories/profile_repo_impl.dart';
import 'package:nilelon/features/profile/presentation/cubit/profile_cubit.dart';

import '../../../../core/service/set_up_locator_service.dart';
import '../../../../core/widgets/shimmer_indicator/build_shimmer.dart';
import '../../../profile/data/models/store_profile_model.dart';
import '../cubit/search_cubit.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({super.key, this.isBrand = false});
  final bool isBrand;
  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  late final SearchCubit cubit;
  @override
  void initState() {
    cubit = SearchCubit.get(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {
        if (state is SearchFailure) {
          BotToast.showText(text: state.message);
        }
      },
      builder: (context, state) {
        if (state is SearchLoading) {
          return buildShimmerIndicatorGrid(context);
        }
        if (state is SearchSuccess) {
          final filterResult = widget.isBrand
              ? cubit.searchResult.where((e) => e.isStore).toList()
              : cubit.searchResult;

          if (filterResult.isEmpty) {
            if (widget.isBrand) {
              return Center(child: Text(lang(context).noStore));
            }
            return Center(child: Text(lang(context).itemNotFound));
          }
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 230.w,
                crossAxisCount: 2,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 12),
            itemCount: filterResult.length,
            itemBuilder: (context, index) {
              final item = filterResult[index];
              if (item.isStore) {
                final result = ProfileRepoIMpl(locatorService());
                return FutureBuilder(
                  future: result.getStoreById(item.id),
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    StoreProfileModel? store;
                    snap.data!.fold((v) {}, (re) {
                      store = re;
                    });
                    return BrandCard(
                      store: store!,
                    );
                  },
                );
              }
              final result = ProductsReposImpl(locatorService());
              return FutureBuilder(
                future: result.getProductDetails(item.id),
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  ProductModel product = ProductModel.empty();
                  snap.data!.fold((v) {}, (re) {
                    product = re;
                  });
                  return productSquarItem(context: context, product: product);
                },
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
