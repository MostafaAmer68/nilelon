import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/core/tools.dart';
import 'package:nilelon/core/widgets/shimmer_indicator/build_shimmer.dart';
import 'package:nilelon/features/customer_flow/see_more_stores/view/see_more_stores_view.dart';
import 'package:nilelon/features/search/presentation/cubit/search_cubit.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/features/search/presentation/widgets/search_section_items.dart';
import 'package:nilelon/features/product/presentation/pages/product_sections.dart';
import 'package:nilelon/core/widgets/view_all_row/view_all_row.dart';
import 'package:nilelon/features/profile/presentation/cubit/profile_cubit.dart';

import '../../../../core/resources/const_functions.dart';
import '../../../../core/widgets/scaffold_image.dart';
import '../../../../core/widgets/text_form_field/text_field/text_form_field_builder.dart';
import '../../../profile/presentation/pages/store_profile_customer.dart';
import '../../../profile/presentation/widgets/profile_avater_widget.dart';
import '../widgets/search_delegate.dart';

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

  bool isSearch = false;
  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    return ScaffoldImage(
      appBar: searchAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: isSearch
            ? const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: SearchResult(),
              )
            : Column(
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
                            stores: ProfileCubit.get(context).stores),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: SizedBox(
                      height: 100,
                      child: BlocBuilder<ProfileCubit, ProfileState>(
                        builder: (context, state) {
                          return state.when(
                            initial: () => Text(lang.smothingWent),
                            loading: () => buildShimmerIndicatorRow(),
                            failure: (_) => Text(lang.smothingWent),
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
                                itemCount:
                                    ProfileCubit.get(context).stores.length,
                              );
                            },
                            codeSentSuccess: () => const SizedBox(),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1.sw > 600 ? 3 : 2,
                        crossAxisSpacing: 1.sw > 600 ? 14 : 16.0,
                        mainAxisExtent: 1.sw > 600 ? 300 : 220,
                        mainAxisSpacing: 1.sw > 600 ? 16 : 12,
                      ),
                      itemCount: HiveStorage.get<List>(HiveKeys.categories)
                          .where((e) => e.id != '')
                          .length,
                      itemBuilder: (context, index) {
                        final category =
                            HiveStorage.get<List>(HiveKeys.categories)
                                .where((e) => e.id != '')
                                .toList()[index];
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
        ProfileCubit.get(context).getStoreForCustomer(id);
        navigateTo(
          context: context,
          screen: StoreProfileCustomer(
            storeId: id,
          ),
        );
      },
      child: Column(
        children: [
          ProfileAvater(
            image: image,
            radius: 30,
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
    );
  }

  AppBar searchAppBar(BuildContext context) {
    return AppBar(
      clipBehavior: Clip.none,
      leadingWidth: 30,
      backgroundColor: ColorManager.primaryW,
      title: TextFormFieldBuilder(
        label: lang(context).searchForAnything,
        controller: SearchCubit.get(context).searchC,
        type: TextInputType.text,
        isIcon: false,
        onchanged: (v) {
          if (v.isEmpty) {
            isSearch = false;
            setState(() {});
          } else {
            SearchCubit.get(context).search();
            isSearch = true;
          }
          setState(() {});
        },
        onpressed: () {
          SearchCubit.get(context).search();
          isSearch = true;
          setState(() {});
        },
        // height: 40,
        prefixWidget: const Icon(Iconsax.search_normal),
        width: screenWidth(context, 1),
      ),
    );
  }
}
