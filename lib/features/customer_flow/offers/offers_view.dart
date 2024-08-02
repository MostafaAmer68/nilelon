import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/resources/const_functions.dart';
import 'package:nilelon/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/widgets/cards/offers/market_offers_card.dart';
import 'package:nilelon/widgets/divider/default_divider.dart';
import 'package:nilelon/widgets/cards/offers/offers_card.dart';
import 'package:nilelon/widgets/filter/category_container.dart';
import 'package:nilelon/widgets/filter/filter_container.dart';
import 'package:nilelon/widgets/filter/static_lists.dart';

class OffersView extends StatefulWidget {
  const OffersView({super.key, required this.isStore});
  final bool isStore;

  @override
  State<OffersView> createState() => _OffersViewState();
}

class _OffersViewState extends State<OffersView> {
  int selectedGender = 0;
  int selectedCategory = 0;
  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Scaffold(
      backgroundColor: ColorManager.primaryW,
      appBar: customAppBar(title: lang.offers, context: context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const DefaultDivider(),
            const SizedBox(
              height: 8,
            ),
            filtersColumn(context),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: widget.isStore
                  ? GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1.sw > 600 ? 3 : 2,
                          crossAxisSpacing: 1.sw > 600 ? 16 : 16.0,
                          mainAxisExtent: 1.sw > 600 ? 310 : 245,
                          mainAxisSpacing: 1.sw > 600 ? 16 : 12),
                      shrinkWrap: true,
                      itemCount: 7,
                      itemBuilder: (context, sizeIndex) {
                        return Container(
                          child: marketOffersCard(context: context),
                        );
                      },
                    )
                  : GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1.sw > 600 ? 3 : 2,
                          crossAxisSpacing: 1.sw > 600 ? 16 : 16.0,
                          mainAxisExtent: 1.sw > 600 ? 415 : 300,
                          mainAxisSpacing: 1.sw > 600 ? 16 : 12),
                      shrinkWrap: true,
                      itemCount: 7,
                      itemBuilder: (context, sizeIndex) {
                        return Container(
                          child: offersCard(context: context),
                        );
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
            Icon(
              Icons.tune,
              size: 1.sw > 600 ? 32 : 24,
            ),
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
}
