import 'package:flutter/material.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/resources/appstyles_manager.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/utils/navigation.dart';
import 'package:nilelon/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/widgets/button/outlined_button_builder.dart';
import 'package:nilelon/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/widgets/divider/default_divider.dart';
import 'package:nilelon/widgets/text_form_field/text_and_form_field_column/without_icon/text_and_form_field_column_no_icon_hide.dart';
import 'package:nilelon/features/auth/presentation/view/forget_password/forget_password_view.dart';
import 'package:nilelon/features/auth/presentation/view/new_password/new_password_view.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
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
            height: 16,
          ),
          TextAndFormFieldColumnNoIconHide(
            title: lang.currentPassword,
            label: lang.enterYourPassowrd,
            spaceSize: 30,
            controller: TextEditingController(),
            type: TextInputType.emailAddress,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    navigateTo(
                        context: context,
                        screen: const ForgetPasswordView(
                          isLogin: false,
                        ));
                  },
                  child: Text(
                    lang.forgetPassword,
                    style: AppStylesManager.customTextStyleL,
                  )),
            ],
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
                        screen: const NewPasswordView(
                          isLogin: false,
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
