import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/filter/category_container.dart';
import 'package:nilelon/core/widgets/filter/filter_container.dart';
import 'package:nilelon/core/widgets/filter/static_lists.dart';
import 'package:nilelon/core/widgets/cards/wide/wide_card.dart';

class CustomerHotPicksView extends StatefulWidget {
  const CustomerHotPicksView({super.key});

  @override
  State<CustomerHotPicksView> createState() => _CustomerHotPicksViewState();
}

class _CustomerHotPicksViewState extends State<CustomerHotPicksView> {
  int selectedGender = 0;
  int selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Scaffold(
      backgroundColor: ColorManager.primaryW,
      appBar: customAppBar(title: lang.hotPicks, context: context),
      body: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          filtersColumn(context),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => Column(
                children: [
                  SizedBox(
                    height: 12.h,
                  ),
                  wideCard(
                      onTap: () {
                        // addToClosetDialog(context,);
                      },
                      context: context),
                ],
              ),
              itemCount: 5,
              padding: const EdgeInsets.only(bottom: 12),
            ),
          ),
        ],
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
}