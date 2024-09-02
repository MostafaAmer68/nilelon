import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/core/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/custom_app_bar/market_custom_app_bar.dart';
import 'package:nilelon/core/widgets/cards/wide/market_wide_card.dart';
import 'package:nilelon/core/widgets/text_form_field/text_field/const_text_form_field.dart';
import 'package:nilelon/core/widgets/banner/banner_product.dart';
import 'package:nilelon/core/widgets/view_all_row/view_all_row.dart';
import 'package:nilelon/features/product/presentation/widgets/new_in_all_widget.dart';
import 'package:nilelon/features/store_flow/hot_picks/store_hot_picks_view.dart';
import 'package:nilelon/features/store_flow/search/view/store_search_view.dart';

import '../../../../core/widgets/scaffold_image.dart';

class StoreMarketView extends StatelessWidget {
  const StoreMarketView({super.key});

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
                text: lang.hotPicks,
                onPressed: () {
                  navigateTo(
                      context: context, screen: const StoreHotPicksView());
                },
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  height: 1.sw > 600 ? 170.h : 140.h,
                  child: ListView.builder(
                    itemBuilder: (context, index) => Row(
                      children: [
                        marketWideCard(context: context),
                        SizedBox(
                          width: 8.w,
                        )
                      ],
                    ),
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              ViewAllRow(
                text: lang.newIn,
                onPressed: () {
                  navigateTo(
                      context: context,
                      screen: const NewInViewAll(
                        isStore: true,
                      ));
                },
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1.sw > 600 ? 3 : 2,
                      crossAxisSpacing: 1.sw > 600 ? 14 : 16.0,
                      mainAxisExtent: 1.sw > 600 ? 320 : 220,
                      mainAxisSpacing: 1.sw > 600 ? 16 : 12),
                  shrinkWrap: true,
                  itemCount: 7,
                  itemBuilder: (context, sizeIndex) {
                    return Container(
                        // child: marketSmallCard(context: context),
                        );
                  },
                ),
              ),
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
    );
  }
}
