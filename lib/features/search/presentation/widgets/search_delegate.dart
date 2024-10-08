import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/shimmer_indicator/build_shimmer.dart';
import 'package:nilelon/features/product/presentation/pages/product_details_page.dart';
import 'package:nilelon/features/profile/presentation/pages/store_profile_customer.dart';
import 'package:nilelon/features/search/presentation/cubit/search_cubit.dart';
import 'package:nilelon/features/search/presentation/widgets/search_section_items.dart';

class SearchView extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (query.isNotEmpty) {
          SearchCubit.get(context).search(query);
        }
      },
      icon: const Icon(Icons.search),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final result = SearchCubit.get(context).searchResult;
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {
        if (state is SearchFailure) {
          BotToast.showText(text: state.message);
        }
      },
      builder: (context, state) {
        if (state is SearchLoading) {
          return buildShimmerIndicatorGrid();
        }
        if (state is SearchSuccess) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 220,
                crossAxisCount: 2,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 12),
            itemCount: result.length,
            itemBuilder: (context, index) {
              final item = result[index];
              return SearchSectionItems(
                image: item.picture,
                name: item.name,
                onTap: () {},
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final result = SearchCubit.get(context).searchResult;
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {
        if (state is SearchFailure) {
          BotToast.showText(text: state.message);
        }
      },
      builder: (context, state) {
        if (state is SearchLoading) {
          return buildShimmerIndicatorGrid();
        }
        if (state is SearchSuccess) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 220,
                crossAxisCount: 2,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 12),
            itemCount: result.length,
            itemBuilder: (context, index) {
              final item = result[index];
              return SearchSectionItems(
                image: item.picture,
                name: item.name,
                onTap: () {
                  if (item.isStore) {
                    navigateTo(
                        context: context,
                        screen: StoreProfileCustomer(storeId: item.id));
                  } else {
                    navigateTo(
                        context: context,
                        screen: ProductDetailsView(productId: item.id));
                  }
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
