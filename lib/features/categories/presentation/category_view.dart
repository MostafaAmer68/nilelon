import 'package:flutter/material.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/features/categories/presentation/cubit/category_cubit.dart';
import 'package:nilelon/features/product/presentation/pages/draft_product_page.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/app_logs.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/view_all_row/view_all_row.dart';
import 'package:nilelon/features/product/presentation/pages/add_product_page.dart';
import 'package:nilelon/features/categories/presentation/widget/category_items.dart';

import '../../../core/widgets/scaffold_image.dart';

class ChooseProductView extends StatefulWidget {
  const ChooseProductView({super.key});

  @override
  State<ChooseProductView> createState() => _ChooseProductViewState();
}

class _ChooseProductViewState extends State<ChooseProductView> {
  @override
  void initState() {
    CategoryCubit.get(context).getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    return ScaffoldImage(
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
                      HiveStorage.get(HiveKeys.draftProduct).toString());
                  navigateTo(
                      context: context, screen: const DraftProductPage());
                },
                child: Text(
                  lang.drafts,
                  style: AppStylesManager.customTextStyleO,
                )),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: HiveStorage.get<List>(HiveKeys.categories).isEmpty
                  ? const Center(child: Text('No Category added yet!!'))
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 230,
                        crossAxisCount: 2,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 12,
                      ),
                      itemCount:
                          HiveStorage.get<List>(HiveKeys.categories).length,
                      itemBuilder: (context, sizeIndex) {
                        final category = (HiveStorage.get<List>(
                            HiveKeys.categories))[sizeIndex];

                        return Column(
                          children: [
                            CategoryItems(
                              image: category.image!,
                              name: category.name!,
                              onTap: () {
                                navigateTo(
                                    context: context,
                                    screen: AddProductView(
                                      categoryId: category.id!,
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
