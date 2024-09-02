import 'package:flutter/material.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/core/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
// import 'package:nilelon/features/store_flow/add_product/model/product_data/product_data.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/alert/delete_alert.dart';
import 'package:nilelon/features/product/presentation/widgets/drafts_card.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/view_all_row/view_all_row.dart';

import '../../../../core/widgets/scaffold_image.dart';

class DraftProductPage extends StatefulWidget {
  const DraftProductPage({super.key});

  @override
  State<DraftProductPage> createState() => _DraftProductPageState();
}

class _DraftProductPageState extends State<DraftProductPage> {
  List<dynamic> draftsProduct = [];
  @override
  void initState() {
    draftsProduct = HiveStorage.get(HiveKeys.draftProduct) ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    return ScaffoldImage(
      appBar: customAppBar(
        title: lang.drafts,
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
            onPressed: () {
              deleteAlert(
                  context, lang.areYouSureYouWantToDeleteAllOfYourDrafts, () {
                draftsProduct.clear();
                HiveStorage.remove(HiveKeys.draftProduct);
                setState(() {});
                navigatePop(context: context);
              });
            },
            text: lang.allDrafts,
            buttonWidget: Text(
              lang.deleteAll,
              style: AppStylesManager.customTextStyleO,
            ),
          ),
          draftsProduct.isEmpty
              ? Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(
                        flex: 2,
                      ),
                      Text(
                        lang.noDraftsYet,
                        style: const TextStyle(
                          fontSize: 14,
                          color: ColorManager.primaryG2,
                        ),
                      ),
                      const Spacer(
                        flex: 3,
                      ),
                    ],
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return DraftsCard(
                        draft: draftsProduct[index],
                        onTap: () {
                          deleteAlert(
                              context, lang.areYouSureYouWantToDeleteThisDraft,
                              () {
                            draftsProduct.remove(draftsProduct[index]);
                            HiveStorage.set(
                                HiveKeys.draftProduct, draftsProduct);
                            setState(() {});
                            navigatePop(context: context);
                          });
                        },
                        indexSelection: index,
                      );
                    },
                    itemCount: draftsProduct.length,
                  ),
                )
        ],
      ),
    );
  }
}
