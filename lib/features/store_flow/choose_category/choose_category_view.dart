import 'package:flutter/material.dart';
import 'package:nilelon/data/hive_stroage.dart';
import 'package:nilelon/features/store_flow/drafts/drafts_view.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/resources/appstyles_manager.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/utils/app_logs.dart';
import 'package:nilelon/utils/navigation.dart';
import 'package:nilelon/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/widgets/divider/default_divider.dart';
import 'package:nilelon/widgets/view_all_row/view_all_row.dart';
import 'package:nilelon/features/product/presentation/cubit/add_product_view.dart';
import 'package:nilelon/features/store_flow/choose_category/widget/category_items.dart';

class ChooseProductView extends StatelessWidget {
  const ChooseProductView({super.key});

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
    final lang = S.of(context);

    return Scaffold(
      backgroundColor: ColorManager.primaryW,
      appBar: customAppBar(
        hasLeading: false,
        title: lang.addProduct,
        context: context,
        hasIcon: false,
      ),
      body: Column(
        children: [
          const DefaultDivider(),
          const SizedBox(
            height: 24,
          ),
          ViewAllRow(
            text: lang.chooseCategory,
            style: AppStylesManager.customTextStyleBl5.copyWith(
              fontWeight: FontWeight.w500,
            ),
            buttonWidget: GestureDetector(
                onTap: () {
                  AppLogs.infoLog(
                      HiveStorage.get(HiveKeys.productData).toString());
                  navigateTo(context: context, screen: const DraftsView());
                },
                child: Text(
                  lang.drafts,
                  style: AppStylesManager.customTextStyleO,
                )),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 230,
                    crossAxisCount: 2,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 12),
                itemCount: searchItem.length,
                itemBuilder: (context, sizeIndex) {
                  return Column(
                    children: [
                      CategoryItems(
                        image: searchItem[sizeIndex]['image'],
                        name: searchItem[sizeIndex]['name'],
                        onTap: () {
                          navigateTo(
                              context: context,
                              screen: AddProductView(
                                categoryName: searchItem[sizeIndex]['name'],
                              ));
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
