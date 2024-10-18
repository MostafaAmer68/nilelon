import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/core/tools.dart';

import '../../../../core/utils/navigation.dart';
import '../../../../core/widgets/shimmer_indicator/build_shimmer.dart';
import '../../../product/presentation/pages/product_details_page.dart';
import '../../../profile/presentation/pages/store_profile_customer.dart';
import '../cubit/search_cubit.dart';
import 'search_section_items.dart';

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
          return buildShimmerIndicatorGrid();
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
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 220,
                crossAxisCount: 2,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 12),
            itemCount: filterResult.length,
            itemBuilder: (context, index) {
              final item = filterResult[index];

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
