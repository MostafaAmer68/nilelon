import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/features/customer_flow/see_more_stores/view/see_more_stores_view.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/resources/const_functions.dart';
import 'package:nilelon/resources/appstyles_manager.dart';
import 'package:nilelon/utils/navigation.dart';
import 'package:nilelon/widgets/filter/static_lists.dart';
import 'package:nilelon/widgets/text_form_field/text_field/text_form_field_builder.dart';
import 'package:nilelon/features/customer_flow/search/widget/search_section_items.dart';
import 'package:nilelon/features/customer_flow/sections_view.dart/sections_view.dart';
import 'package:nilelon/features/customer_flow/store_profile_customer/store_profile_customer.dart';
import 'package:nilelon/widgets/view_all_row/view_all_row.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
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
    return Scaffold(
      backgroundColor: ColorManager.primaryW,
      appBar: searchAppBar(context, lang.searchByItemBrand),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            ViewAllRow(
              noPadding: true,
              text: lang.brands,
              buttonWidget: Text(
                lang.seeMore,
                style: AppStylesManager.customTextStyleO,
              ),
              onPressed: () {
                navigateTo(context: context, screen: const SeeMoreStoresView());
              },
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: SizedBox(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: circleItems(
                        images[index],
                        context,
                        names[index],
                        'Shop store for woman clothes',
                      ),
                    ),
                    itemCount: images.length,
                  ),
                )),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 220,
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 12),
                itemCount: categoryFilter.length,
                itemBuilder: (context, sizeIndex) {
                  return Column(
                    children: [
                      SearchSectionItems(
                        image: categoryFilter[sizeIndex]['image'],
                        name: categoryFilter[sizeIndex]['name'],
                        onTap: () {
                          navigateTo(
                              context: context,
                              screen: SectionsView(
                                selectedCat: sizeIndex,
                              ));
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
            screen: StoreProfileCustomer(
              storeName: name,
              image: image,
              description: description,
            ));
      },
      child: Container(
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
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(image),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              name,
              style: AppStylesManager.customTextStyleBl10,
            )
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
