import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/core/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/widgets/text_form_field/text_field/text_form_field_builder.dart';

import '../../../core/widgets/scaffold_image.dart';

class StoreSectionsView extends StatefulWidget {
  const StoreSectionsView({super.key});

  @override
  State<StoreSectionsView> createState() => _StoreSectionsViewState();
}

class _StoreSectionsViewState extends State<StoreSectionsView> {
  List<Map<String, dynamic>> searchItem = [
    {"image": "assets/images/blue-t-shirt.png", "name": "T-Shirts"},
    {
      "image":
          "assets/images/toteme-jeans-twisted-seam-high-waist-worn-blue.png",
      "name": "Pants"
    },
    {"image": "assets/images/shoes.png", "name": "Shoes"},
    {"image": "assets/images/shirt.png", "name": "Shirts"},
    {"image": "assets/images/knitwear.png", "name": "knit wear"},
    {"image": "assets/images/jackets.png", "name": "Jackets"},
  ];
  List<String> items = [
    'Men',
    'Women',
    'Both',
  ];
  int _selectedIndex = 0;

  // String _indexName = 'Men';
  int _selectedCatIndex = 0;

  // String _indexCatName = 'T-Shirts';
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
              child: SizedBox(
                height: screenWidth(context, 0.3),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return _selectedCatIndex == index
                        ? GestureDetector(
                            onTap: () {
                              _selectedCatIndex = index;
                              setState(() {});
                            },
                            child: Container(
                              height: screenWidth(context, 0.4),
                              decoration: ShapeDecoration(
                                color: const Color(0xFFE9F2F5),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: screenWidth(context, 0.2),
                                    height: screenWidth(context, 0.2),
                                    padding: const EdgeInsets.all(16),
                                    child:
                                        Image.asset(searchItem[index]['image']),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    searchItem[index]['name'],
                                    style: AppStylesManager.customTextStyleBl3,
                                  )
                                ],
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              _selectedCatIndex = index;
                              setState(() {});
                            },
                            child: Column(
                              children: [
                                Container(
                                  width: screenWidth(context, 0.2),
                                  height: screenWidth(context, 0.2),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child:
                                      Image.asset(searchItem[index]['image']),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  searchItem[index]['name'],
                                  style: AppStylesManager.customTextStyleBl3,
                                )
                              ],
                            ),
                          );
                  },
                  itemCount: searchItem.length,
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
                      itemBuilder: (context, index) =>
                          filterContainer(items[index], index),
                      itemCount: items.length,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 28,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.0,
                    mainAxisExtent: 220,
                    mainAxisSpacing: 12),
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
    );
  }

  GestureDetector filterContainer(String name, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
          // _indexName = name;
        });
      },
      child: _selectedIndex == index
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                // height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: ColorManager.primaryB2,
                    border: Border.all(color: ColorManager.primaryB2)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                  ),
                  child: Center(
                    child: Text(
                      name,
                      textAlign: TextAlign.center,
                      style: AppStylesManager.customTextStyleW4,
                    ),
                  ),
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                // height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: ColorManager.primaryB2)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                  ),
                  child: Center(
                    child: Text(
                      name,
                      textAlign: TextAlign.center,
                      style: AppStylesManager.customTextStyleB3
                          .copyWith(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
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
            isIcon: false,
            height: 40,
            prefixWidget: const Icon(Iconsax.search_normal),
            width: screenWidth(context, 1)),
      ),
    );
  }
}
