import 'package:flutter/material.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/resources/const_functions.dart';
import 'package:nilelon/resources/appstyles_manager.dart';
import 'package:nilelon/utils/navigation.dart';
import 'package:nilelon/widgets/button/button_builder.dart';
import 'package:nilelon/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/features/customer_flow/closet/widget/closet_widget_with_options.dart';
import 'package:nilelon/widgets/pop_ups/create_new_section_popup.dart';
import 'package:nilelon/widgets/view_all_row/view_all_row.dart';
import 'package:nilelon/features/customer_flow/section_details/section_details_view.dart';

class ClosetView extends StatelessWidget {
  const ClosetView({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Scaffold(
      backgroundColor: ColorManager.primaryW,
      appBar: customAppBar(title: lang.closet, context: context),
      body: Column(
        children: [
          const Divider(
            color: ColorManager.primaryG8,
          ),
          Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              ViewAllRow(
                text: lang.yourSections,
                onPressed: () {},
                buttonWidget: Text(
                  lang.showItems,
                  style: AppStylesManager.customTextStyleO,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClosetsWidgetWithOptions(
                    onTap: () {
                      navigateTo(
                          context: context, screen: const SectionDetailsView());
                    },
                  ),
                ],
              ),
            ],
          )
        ],
      ),
      persistentFooterButtons: [
        ButtonBuilder(
            text: lang.addNewSection,
            width: screenWidth(context, 0.94),
            ontap: () {
              createNewSectionDialog(context);
            })
      ],
    );
  }
}
