import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/core/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/text_form_field/text_field/text_form_field_builder.dart';
import 'package:nilelon/core/widgets/view_all_row/view_all_row.dart';
import 'package:nilelon/features/search/presentation/widgets/search_section_items.dart';
import 'package:nilelon/features/store_flow/sections_view.dart/store_sections_view.dart';
import 'package:nilelon/features/store_flow/see_more_stores/view/see_more_stores_store_view.dart';
import 'package:nilelon/features/profile/presentation/pages/store_profile_store.dart';

import '../../../../core/widgets/scaffold_image.dart';

class StoreSearchView extends StatelessWidget {
  const StoreSearchView({super.key});

  @override
  Widget build(BuildContext context) {
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
    List<String> names = [
      'Sara Baqatyan',
      'Lia Shop',
      'Twixi Shop',
      'Shop with tene',
    ];
    List<String> images = [
      'assets/images/brand1.png',
      'assets/images/brand2.png',
      'assets/images/brand3.png',
      'assets/images/brand4.png',
    ];
    final lang = S.of(context);

    return ScaffoldImage(
      appBar: searchAppBar(context, lang.searchByItemBrand),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
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
                    context: context, screen: const SeeMoreStoresStoreView());
              },
            ),
            SizedBox(
              height: 130,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
                    child: Row(
                      children: [
                        circleItems(
                          images[index],
                          context,
                          names[index],
                          'Shop store for woman clothes',
                        ),
                      ],
                    ),
                  );
                },
                itemCount: images.length,
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 220,
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 12),
                itemCount: searchItem.length,
                itemBuilder: (context, sizeIndex) {
                  return Column(
                    children: [
                      SearchSectionItems(
                        image: searchItem[sizeIndex]['image'],
                        name: searchItem[sizeIndex]['name'],
                        onTap: () {
                          navigateTo(
                              context: context,
                              screen: const StoreSectionsView());
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
      String image, context, String name, String description) {
    return GestureDetector(
      onTap: () {
        navigateTo(
            context: context,
            screen: StoreProfileStore(
              storeName: name,
              image: image,
              description: description,
            ));
      },
      child: Column(
        children: [
          Container(
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x33726363),
                  blurRadius: 16,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(image),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            name,
            style: AppStylesManager.customTextStyleBl10,
          )
        ],
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
            textAlignVer: TextAlignVertical.center,
            type: TextInputType.text,
            isIcon: false,
            height: 40,
            prefixWidget: const Icon(Iconsax.search_normal),
            width: screenWidth(context, 1)),
      ),
    );
  }
}
