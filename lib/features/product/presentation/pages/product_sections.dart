import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/widgets/shimmer_indicator/build_shimmer.dart';
import 'package:nilelon/core/widgets/text_form_field/text_field/text_form_field_builder.dart';
import 'package:nilelon/features/product/presentation/widgets/product_card/product_squar_item.dart';

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
  int selectedCategoryIndex = 0;
  int selectedGenderIndex = 0;
  late final ProductsCubit cubit;
  @override
  void initState() {
    cubit = ProductsCubit.get(context);
    cubit.categoryId = widget.categoryId;
    log(cubit.categoryId);
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BlocBuilder<ProductsCubit, ProductsState>(
                builder: (context, state) {
                  return state.whenOrNull(
                    failure: (er) => Center(child: Text(er)),
                    loading: () => buildShimmerIndicatorGrid(context),
                    success: () => GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: gridDelegate(context),
                      shrinkWrap: true,
                      itemCount:
                          ProductsCubit.get(context).products.toList().length,
                      itemBuilder: (context, sizeIndex) {
                        return Container(
                          child: productSquarItem(
                            context: context,
                            product: ProductsCubit.get(context)
                                .products
                                .toList()[sizeIndex],
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
