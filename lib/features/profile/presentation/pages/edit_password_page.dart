import 'package:flutter/material.dart';
import 'package:nilelon/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:nilelon/features/auth/presentation/view/forget_password_page.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/core/widgets/button/outlined_button_builder.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/text_form_field/text_and_form_field_column/without_icon/text_and_form_field_column_no_icon_hide.dart';
import 'package:nilelon/features/auth/presentation/view/reset_password_page.dart';

import '../../../../core/widgets/scaffold_image.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return ScaffoldImage(
      appBar:
          customAppBar(title: lang.password, context: context, hasIcon: false),
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
            controller: AuthCubit.get(context).passwordController,
            type: TextInputType.emailAddress,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    navigateTo(
                        context: context,
                        screen: const ForgetPasswordPage(
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
                        screen: ResetPassowrdView(
                          isLogin: false,
                          onTap: () {
                            AuthCubit.get(context).changePassword(context);
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
