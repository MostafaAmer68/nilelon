import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/widgets/filter/category_container.dart';
import 'package:nilelon/core/widgets/filter/filter_container.dart';
import 'package:nilelon/core/widgets/filter/static_lists.dart';
import 'package:nilelon/core/widgets/shimmer_indicator/build_shimmer.dart';
import 'package:nilelon/core/widgets/text_form_field/text_field/text_form_field_builder.dart';
import 'package:nilelon/core/widgets/cards/small/product_squar_item.dart';

import '../../../../core/tools.dart';
import '../../../../core/widgets/scaffold_image.dart';
import '../cubit/products_cubit/products_cubit.dart';
import '../cubit/products_cubit/products_state.dart';

class SectionsProductView extends StatefulWidget {
  const SectionsProductView({
    super.key,
    required this.categoryId,
  });
  final String categoryId;
  @override
  State<SectionsProductView> createState() => _SectionsProductViewState();
}

class _SectionsProductViewState extends State<SectionsProductView> {
  int selectedGender = 0;
  int selectedCategory = 0;
  late final ProductsCubit cubit;
  @override
  void initState() {
    cubit = ProductsCubit.get(context);
    cubit.categoryId = widget.categoryId;
    // selectedCategory = widget.selectedCat;
    cubit.getProductByCategory(1, 10);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return ScaffoldImage(
      appBar: searchAppBar(context, lang.searchByItemBrand),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16,
            ),
            filtersColumn(context),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BlocBuilder<ProductsCubit, ProductsState>(
                builder: (context, state) {
                  return state.whenOrNull(
                    loading: () => buildShimmerIndicatorGrid(),
                    success: () => GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: gridDelegate,
                      shrinkWrap: true,
                      itemCount: ProductsCubit.get(context).products.length,
                      itemBuilder: (context, sizeIndex) {
                        return Container(
                          child: productSquarItem(
                            context: context,
                            model:
                                ProductsCubit.get(context).products[sizeIndex],
                          ),
                        );
                      },
                    ),
                  )!;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column filtersColumn(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: SizedBox(
            height: screenWidth(context, 0.28),
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    selectedCategory = index;
                    setState(() {});
                  },
                  child: categoryContainer(
                    context: context,
                    image: categoryFilter[index]['image'],
                    name: categoryFilter[index]['name'],
                    isSelected: selectedCategory == index,
                  )),
              itemCount: categoryFilter.length,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            const SizedBox(
              width: 16,
            ),
            const Icon(Icons.tune),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: SizedBox(
                height: 52,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        selectedGender = index;
                        setState(() {});
                      },
                      child: filterContainer(
                        genderFilter[index],
                        selectedGender == index,
                      )),
                  itemCount: genderFilter.length,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  AppBar searchAppBar(BuildContext context, String search) {
    return AppBar(
      clipBehavior: Clip.none,
      leadingWidth: 30,
      backgroundColor: ColorManager.primaryW,
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: TextFormFieldBuilder(
            label: search,
            controller: TextEditingController(),
            type: TextInputType.text,
            textAlignVer: TextAlignVertical.center,
            isIcon: false,
            height: 40,
            prefixWidget: const Icon(Iconsax.search_normal),
            width: screenWidth(context, 1)),
      ),
    );
  }
}
