import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/core/widgets/shimmer_indicator/build_shimmer.dart';
import 'package:nilelon/features/customer_flow/see_more_stores/view/see_more_stores_view.dart';
import 'package:nilelon/features/search/presentation/widgets/search_delegate.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/features/search/presentation/widgets/search_section_items.dart';
import 'package:nilelon/features/product/presentation/pages/product_sections.dart';
import 'package:nilelon/core/widgets/view_all_row/view_all_row.dart';
import 'package:nilelon/features/profile/presentation/cubit/profile_cubit.dart';

import '../../../../core/widgets/scaffold_image.dart';
import '../../../profile/presentation/pages/store_profile_customer.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    ProfileCubit.get(context).getStores(1, 5);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    return ScaffoldImage(
      appBar: searchAppBar(context, lang.searchByItemBrand),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            ViewAllRow(
              noPadding: true,
              text: lang.brands,
              buttonWidget: Text(
                lang.seeMore,
                style: AppStylesManager.customTextStyleO,
              ),
              onPressed: () {
                navigateTo(
                    context: context,
                    screen: SeeMoreStoresView(
                        stores: ProfileCubit.get(context).stores));
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                height: 100,
                child: BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    return state.whenOrNull(
                      loading: () => buildShimmerIndicatorRow(),
                      success: () {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final store =
                                ProfileCubit.get(context).stores[index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: circleItems(
                                store.id,
                                store.profilePic ?? '',
                                context,
                                store.name,
                                store.storeSlogan ?? '',
                              ),
                            );
                          },
                          itemCount: ProfileCubit.get(context).stores.length,
                        );
                      },
                    )!;
                  },
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 220,
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 12),
                itemCount: HiveStorage.get<List>(HiveKeys.categories).length,
                itemBuilder: (context, index) {
                  final category =
                      HiveStorage.get<List>(HiveKeys.categories)[index];
                  return Column(
                    children: [
                      SearchSectionItems(
                        image: category.image,
                        name: category.name,
                        onTap: () {
                          navigateTo(
                            context: context,
                            screen: SectionsProductView(
                              categoryId: category.id,
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector circleItems(
      String id, String image, context, String name, String description) {
    return GestureDetector(
      onTap: () {
        navigateTo(
          context: context,
          screen: StoreProfileCustomer(
            storeId: id,
          ),
        );
      },
      child: Container(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x33726363),
              blurRadius: 16,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(image),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              name,
              style: AppStylesManager.customTextStyleBl10,
            )
          ],
        ),
      ),
    );
  }

  AppBar searchAppBar(BuildContext context, String search) {
    return AppBar(
      clipBehavior: Clip.none,
      leadingWidth: 30,
      backgroundColor: ColorManager.primaryW,
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: SearchBar(
          hintText: search,
          onTap: () {
            showSearch(context: context, delegate: SearchView());
          },
        ),
      ),
    );
  }
}
