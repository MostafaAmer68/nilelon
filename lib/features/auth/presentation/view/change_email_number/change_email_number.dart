import 'package:flutter/material.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/utils/navigation.dart';
import 'package:nilelon/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/widgets/button/outlined_button_builder.dart';
import 'package:nilelon/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/widgets/divider/default_divider.dart';
import 'package:nilelon/widgets/pop_ups/success_creation_popup.dart';
import 'package:nilelon/widgets/text_form_field/text_and_form_field_column/without_icon/text_and_form_field_column_no_icon.dart';
import 'package:nilelon/features/auth/presentation/view/otp/otp_view.dart';

class ChangeEmail extends StatelessWidget {
  const ChangeEmail({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    return Scaffold(
      appBar: customAppBar(title: lang.email, context: context, hasIcon: false),
      backgroundColor: ColorManager.primaryW,
      body: Column(
        children: [
          const DefaultDivider(),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextAndFormFieldColumnNoIcon(
              title: lang.addNewEmail,
              label: lang.enterEmail,
              controller: TextEditingController(),
              type: TextInputType.emailAddress,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButtonBuilder(
                  text: lang.cancel,
                  ontap: () {
                    navigatePop(context: context);
                  }),
              GradientButtonBuilder(
                  text: lang.next,
                  ontap: () {
                    navigateTo(
                        context: context,
                        screen: OtpView(
                          name: lang.verifyEmail,
                          phoneOrEmail: '+20 1012******',
                          buttonName: lang.verify,
                          ontap: () {
                            successCreationDialog(
                                context: context,
                                highlightedText: lang.emailChangedSuccessfully,
                                regularText: lang
                                    .yourEmailHasBeenChangedSuccessfullyWeWillLetYouKnowIfThereAnyProblem,
                                buttonText: lang.ok,
                                ontap: () {});
                          },
                        ));
                  })
            ],
          ),
          const SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }
}
