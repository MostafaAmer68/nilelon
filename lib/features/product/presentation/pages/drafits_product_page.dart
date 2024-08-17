import 'package:flutter/material.dart';
import 'package:nilelon/data/hive_stroage.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/resources/appstyles_manager.dart';
// import 'package:nilelon/features/store_flow/add_product/model/product_data/product_data.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/utils/navigation.dart';
import 'package:nilelon/widgets/alert/delete_alert.dart';
import 'package:nilelon/widgets/cards/drafts/drafts_card.dart';
import 'package:nilelon/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/widgets/divider/default_divider.dart';
import 'package:nilelon/widgets/view_all_row/view_all_row.dart';

class DraftsView extends StatefulWidget {
  const DraftsView({super.key});

  @override
  State<DraftsView> createState() => _DraftsViewState();
}

class _DraftsViewState extends State<DraftsView> {
  List<dynamic> allDrafts = [];
  @override
  void initState() {
    allDrafts = HiveStorage.get(HiveKeys.productData) ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    return Scaffold(
      backgroundColor: ColorManager.primaryW,
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
                allDrafts.clear();
                HiveStorage.remove(HiveKeys.productData);
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
          allDrafts.isEmpty
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
                        draft: allDrafts[index],
                        onTap: () {
                          deleteAlert(
                              context, lang.areYouSureYouWantToDeleteThisDraft,
                              () {
                            allDrafts.remove(allDrafts[index]);
                            HiveStorage.set(HiveKeys.productData, allDrafts);
                            setState(() {});
                            navigatePop(context: context);
                          });
                        },
                        indexSelection: index,
                      );
                    },
                    itemCount: allDrafts.length,
                  ),
                )
        ],
      ),
    );
  }
}
