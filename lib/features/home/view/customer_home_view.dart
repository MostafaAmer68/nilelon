import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/core/constants/assets.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/core/tools.dart';
import 'package:nilelon/features/recomandtion/recommendation_profile_view.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_cubit.dart';
import 'package:nilelon/features/product/presentation/pages/product_followed_page.dart';
import 'package:nilelon/features/product/presentation/pages/products_view_all.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/scaffold_image.dart';
import 'package:nilelon/core/widgets/text_form_field/text_field/const_text_form_field.dart';
import 'package:nilelon/core/widgets/banner/banner_product.dart';
import 'package:nilelon/core/widgets/custom_app_bar/home_custom_app_bar.dart';
import 'package:nilelon/core/widgets/view_all_row/view_all_row.dart';
import 'package:nilelon/features/search/presentation/pages/search_view.dart';

import '../../layout/customer_bottom_tab_bar.dart';
import '../../product/presentation/pages/products_view_all_hot.dart';

class CustomerHomeView extends StatefulWidget {
  const CustomerHomeView({super.key});

  @override
  State<CustomerHomeView> createState() => _CustomerHomeViewState();
}

class _CustomerHomeViewState extends State<CustomerHomeView> {
  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return ScaffoldImage(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const HomeCustomAppBar(),
              const SizedBox(
                height: 24,
              ),
              GestureDetector(
                onTap: () {
                  navigateTo(context: context, screen: const SearchPage());
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
                  child: ConstTextFieldBuilder(
                    label: lang.searchForAnything,
                    width: screenWidth(context, 1),
                    prefixWidget: const Icon(
                      Iconsax.search_normal,
                      color: ColorManager.primaryG,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GestureDetector(
                  onTap: () {
                    navigateTo(
                        context: context,
                        screen: const RecommendationProfileView());
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        HiveStorage.get(HiveKeys.shopFor),
                        style: AppStylesManager.customTextStyleBl6,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              banner(context),
              const SizedBox(height: 10),
              smallBanner(context),
              SizedBox(
                height: 16.h,
              ),
              ViewAllRow(
                text: lang.following,
                onPressed: () {
                  if (HiveStorage.get(HiveKeys.userModel) == null) {
                    navigateAndRemoveUntil(
                        context: context,
                        screen: const CustomerBottomTabBar(
                          index: 3,
                        ));
                    return;
                  }
                  navigateTo(
                    context: context,
                    screen: ProductsViewAll(
                      notFoundTitle: lang.noProductFollow,
                      isHandpicked: false,
                      appBarTitle: lang.following,
                      onStartPage: (isPage) {
                        ProductsCubit.get(context).getFollowedProducts(isPage);
                      },
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 8,
              ),
              const FollowedProductPage(),
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
            notFoundTitle: lang(context).noProductHandPicked,
            isHandpicked: true,
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
