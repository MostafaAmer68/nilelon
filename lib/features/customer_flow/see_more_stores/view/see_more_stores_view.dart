import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/resources/const_functions.dart';
import 'package:nilelon/resources/appstyles_manager.dart';
import 'package:nilelon/widgets/text_form_field/text_field/text_form_field_builder.dart';
import 'package:nilelon/widgets/cards/brand/brand_card.dart';

class SeeMoreStoresView extends StatelessWidget {
  const SeeMoreStoresView({super.key});

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
    return Scaffold(
      backgroundColor: ColorManager.primaryW,
      appBar: searchAppBar(context),
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
                    mainAxisExtent: 200,
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 12),
                itemCount: brand.length,
                itemBuilder: (context, sizeIndex) {
                  return Column(
                    children: [
                      BrandCard(
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

  AppBar searchAppBar(BuildContext context) {
    return AppBar(
      clipBehavior: Clip.none,
      leadingWidth: 30,
      backgroundColor: ColorManager.primaryW,
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: TextFormFieldBuilder(
            label: 'Search by brand ',
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
