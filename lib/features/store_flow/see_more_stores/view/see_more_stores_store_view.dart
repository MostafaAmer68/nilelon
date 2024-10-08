import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/widgets/text_form_field/text_field/text_form_field_builder.dart';
import 'package:nilelon/core/widgets/cards/brand/store_brand_card.dart';

import '../../../../core/widgets/scaffold_image.dart';

class SeeMoreStoresStoreView extends StatelessWidget {
  const SeeMoreStoresStoreView({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> brand = [
      {
        "name": "Sara Baqatyan",
        "image": "assets/images/brand1.png",
      },
      {
        "name": "Lia Shop",
        "image": "assets/images/brand2.png",
      },
      {
        "name": "Twixi Shop",
        "image": "assets/images/brand3.png",
      },
      {
        "name": "Shop with tene",
        "image": "assets/images/brand4.png",
      },
    ];
    final lang = S.of(context);

    return ScaffoldImage(
      appBar: searchAppBar(context, lang.searchByItemBrand),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lang.allBrands,
              style: AppStylesManager.customTextStyleB4,
            ),
            const SizedBox(
              height: 18,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 170,
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 12),
                itemCount: brand.length,
                itemBuilder: (context, sizeIndex) {
                  return Column(
                    children: [
                      StoreBrandCard(
                        image: brand[sizeIndex]['image'],
                        name: brand[sizeIndex]['name'],
                        description: 'Shop store for woman clothes',
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
