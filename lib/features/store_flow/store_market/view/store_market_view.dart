import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/core/tools.dart';
import 'package:nilelon/features/product/presentation/widgets/product_card/product_squar_item.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/custom_app_bar/market_custom_app_bar.dart';
import 'package:nilelon/core/widgets/shimmer_indicator/build_shimmer.dart';
import 'package:nilelon/core/widgets/text_form_field/text_field/const_text_form_field.dart';
import 'package:nilelon/core/widgets/banner/banner_product.dart';
import 'package:nilelon/core/widgets/view_all_row/view_all_row.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_cubit.dart';
import 'package:nilelon/features/product/presentation/pages/product_new_in_all_widget.dart';
import 'package:nilelon/features/store_flow/search/view/store_search_view.dart';

import '../../../../core/resources/appstyles_manager.dart';
import '../../../../core/widgets/scaffold_image.dart';
import '../../../product/presentation/cubit/products_cubit/products_state.dart';
import '../../../product/presentation/pages/product_offers_view.dart';

class StoreMarketView extends StatefulWidget {
  const StoreMarketView({super.key});

  @override
  State<StoreMarketView> createState() => _StoreMarketViewState();
}

class _StoreMarketViewState extends State<StoreMarketView> {
  late final ProductsCubit cubit;
  @override
  void initState() {
    cubit = BlocProvider.of(context);
    cubit.getNewInProducts(1, 20);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    return ScaffoldImage(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const MarketCustomAppBar(),
              const SizedBox(
                height: 24,
              ),
              GestureDetector(
                onTap: () {
                  navigateTo(context: context, screen: const StoreSearchView());
                },
                child: ConstTextFieldBuilder(
                  label: lang.searchForAnything,
                  width: screenWidth(context, 0.92),
                  prefixWidget: const Icon(
                    Iconsax.search_normal,
                    color: ColorManager.primaryG,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              banner(context),
              const SizedBox(
                height: 12,
              ),
              ViewAllRow(
                text: lang.newIn,
                onPressed: () {
                  navigateTo(
                      context: context,
                      screen: const ProductNewInViewAll(
                        isStore: true,
                      ));
                },
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: BlocBuilder<ProductsCubit, ProductsState>(
                  builder: (context, state) {
                    return state.whenOrNull(
                      failure: (err) {
                        return const Icon(Icons.error);
                      },
                      loading: () {
                        return buildShimmerIndicatorGrid();
                      },
                      success: () {
                        if (ProductsCubit.get(context).products.isEmpty) {
                          return SizedBox(
                            height: 120.h,
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
                        return GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: gridDelegate,
                          shrinkWrap: true,
                          itemCount: ProductsCubit.get(context).products.length,
                          itemBuilder: (context, index) {
                            final product =
                                ProductsCubit.get(context).products[index];
                            return Container(
                              child: productSquarItem(
                                context: context,
                                product: product,
                              ),
                            );
                          },
                        );
                      },
                    )!;
                  },
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  BannerProduct banner(BuildContext context) {
    return BannerProduct(
      height: MediaQuery.of(context).size.height * .2,
      isStore: true,
      onTap: () {
        navigateTo(
          context: context,
          screen: const OffersView(
            isStore: true,
          ),
        );
      },
    );
  }
}
