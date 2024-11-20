import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/core/tools.dart';
import 'package:nilelon/features/product/presentation/pages/products_view_all.dart';
import 'package:nilelon/features/product/presentation/pages/products_view_all_hot.dart';
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

import '../../../core/constants/assets.dart';
import '../../../core/resources/appstyles_manager.dart';
import '../../../core/widgets/scaffold_image.dart';
import '../../product/presentation/cubit/products_cubit/products_state.dart';
import '../../search/presentation/pages/search_view.dart';

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
    cubit.getNewInProducts();
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
                  navigateTo(context: context, screen: const SearchPage());
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
              smallBanner(context),
              const SizedBox(
                height: 12,
              ),
              ViewAllRow(
                text: lang.newIn,
                onPressed: () {
                  navigateTo(
                    context: context,
                    screen: ProductsViewAll(
                      appBarTitle: lang.newIn,
                      notFoundTitle: lang.noProductNewIn,
                      isHandpicked: false,
                      onStartPage: (isPage) {
                        cubit.getNewInProducts(isPage);
                      },
                      isStore: true,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: BlocBuilder<ProductsCubit, ProductsState>(
                  builder: (context, state) {
                    return state.maybeWhen(failure: (err) {
                      return const Icon(Icons.error);
                    }, loading: () {
                      return buildShimmerIndicatorGrid(context);
                    }, newInProductSuccess: (products) {
                      if (products.data.isEmpty) {
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
                        gridDelegate: gridDelegate(context),
                        shrinkWrap: true,
                        itemCount: products.data.length,
                        itemBuilder: (context, index) {
                          final product = products.data[index];
                          return Container(
                            child: productSquarItem(
                              context: context,
                              product: product,
                            ),
                          );
                        },
                      );
                    }, orElse: () {
                      if (cubit.newInProducts.data.isEmpty) {
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
                        gridDelegate: gridDelegate(context),
                        shrinkWrap: true,
                        itemCount: cubit.newInProducts.data.length,
                        itemBuilder: (context, index) {
                          final product = cubit.newInProducts.data[index];
                          return Container(
                            child: productSquarItem(
                              context: context,
                              product: product,
                            ),
                          );
                        },
                      );
                    });
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
      height: MediaQuery.of(context).size.height * .60,
      isStore: false,
      onTap: () {
        navigateTo(
          context: context,
          screen: ProductsViewAll(
            isOffer: true,
            notFoundTitle: lang(context).noProductOffer,
            isHandpicked: false,
            appBarTitle: lang(context).offers,
            onStartPage: (isPage) {
              ProductsCubit.get(context).getOffersProducts(isPage);
            },
          ),
        );
      },
    );
  }

  smallBanner(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateTo(
          context: context,
          screen: ProductsViewAllHot(
            isStore: true,
            notFoundTitle: lang(context).noProductNewIn,
            isHandpicked: false,
            appBarTitle: lang(context).hotPicks,
            onStartPage: (isPage) {
              ProductsCubit.get(context).getRandomProducts(isPage);
            },
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Image.asset(
          Assets.assetsImagesBanner2,
          width: double.infinity,
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height * .25,
        ),
      ),
    );
  }
}
