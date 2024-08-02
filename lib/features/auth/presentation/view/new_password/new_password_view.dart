import 'package:flutter/material.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/utils/navigation.dart';
import 'package:nilelon/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/widgets/button/outlined_button_builder.dart';
import 'package:nilelon/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/widgets/divider/default_divider.dart';
import 'package:nilelon/widgets/pop_ups/success_creation_popup.dart';
import 'package:nilelon/widgets/text_form_field/text_and_form_field_column/without_icon/text_and_form_field_column_no_icon_hide.dart';
import 'package:nilelon/features/auth/presentation/view/login/login_view.dart';
import 'package:nilelon/features/customer_flow/layout/customer_bottom_tab_bar.dart';

class NewPasswordView extends StatefulWidget {
  const NewPasswordView({
    super.key,
    required this.isLogin,
  });
  final bool isLogin;
  @override
  State<NewPasswordView> createState() => _NewPasswordViewState();
}

class _NewPasswordViewState extends State<NewPasswordView> {
  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Scaffold(
      appBar:
          customAppBar(title: lang.password, context: context, hasIcon: false),
      backgroundColor: ColorManager.primaryW,
      body: Column(
        children: [
          const DefaultDivider(),
          const SizedBox(
            height: 50,
          ),
          TextAndFormFieldColumnNoIconHide(
            title: lang.newPassword,
            label: lang.enterNewPassword,
            controller: TextEditingController(),
            type: TextInputType.emailAddress,
          ),
          TextAndFormFieldColumnNoIconHide(
            title: lang.confirmPassword,
            label: lang.enterConfirmPassword,
            controller: TextEditingController(),
            type: TextInputType.emailAddress,
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
                  text: lang.save,
                  ontap: () {
                    successCreationDialog(
                        isDismissible: false,
                        context: context,
                        highlightedText: lang.passwordChangedSuccessfully,
                        regularText: lang
                            .yourPasswordHasBeenChangedSuccessfullyWeWillLetYouKnowIfThereAnyProblem,
                        buttonText: lang.ok,
                        ontap: () {
                          widget.isLogin
                              ? navigateAndRemoveUntil(
                                  context: context, screen: const LoginView())
                              : navigateAndRemoveUntil(
                                  context: context,
                                  screen: const CustomerBottomTabBar());
                        });
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
