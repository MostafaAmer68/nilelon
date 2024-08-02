import 'package:flutter/material.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/resources/const_functions.dart';
import 'package:nilelon/resources/appstyles_manager.dart';
import 'package:nilelon/utils/navigation.dart';
import 'package:nilelon/widgets/button/button_builder.dart';
import 'package:nilelon/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/widgets/divider/default_divider.dart';
import 'package:nilelon/widgets/text_form_field/text_and_form_field_column/without_icon/text_and_form_field_column_no_icon.dart';

class EditStoreInfoView extends StatelessWidget {
  const EditStoreInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    return Scaffold(
      backgroundColor: ColorManager.primaryW,
      appBar: customAppBar(
        title: lang.storeInfo,
        context: context,
        hasIcon: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const DefaultDivider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  TextAndFormFieldColumnNoIcon(
                    title: lang.storeRepresentativeName,
                    label: 'Twixi',
                    height: 25,
                    controller: TextEditingController(),
                    type: TextInputType.text,
                  ),
                  TextAndFormFieldColumnNoIcon(
                    title: lang.storeRepresentativeNumber,
                    label: '01000000000',
                    controller: TextEditingController(),
                    height: 25,
                    type: TextInputType.phone,
                  ),
                  TextAndFormFieldColumnNoIcon(
                    title: lang.warehouseAddress,
                    label: 'Cairo',
                    controller: TextEditingController(),
                    height: 25,
                    type: TextInputType.text,
                  ),
                  TextAndFormFieldColumnNoIcon(
                    title: lang.profileLink,
                    label: 'TwixiShop',
                    controller: TextEditingController(),
                    height: 25,
                    desc: ' (Facebook or Instagram)',
                    type: TextInputType.text,
                  ),
                  TextAndFormFieldColumnNoIcon(
                    title: lang.websiteLink,
                    label: 'TwixiShop',
                    controller: TextEditingController(),
                    height: 25,
                    type: TextInputType.text,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight(context, 0.11),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ButtonBuilder(
                      text: lang.cancel,
                      width: screenWidth(context, 0.44),
                      height: screenHeight(context, 0.06),
                      buttonColor: Colors.transparent,
                      frameColor: ColorManager.primaryB2,
                      style: AppStylesManager.customTextStyleB4,
                      ontap: () {
                        navigatePop(context: context);
                      }),
                  const SizedBox(
                    width: 12,
                  ),
                  GradientButtonBuilder(
                      text: lang.save,
                      width: screenWidth(context, 0.44),
                      height: screenHeight(context, 0.06),
                      ontap: () {
                        navigatePop(context: context);
                      }),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            )
          ],
        ),
      ),
    );
  }
}
