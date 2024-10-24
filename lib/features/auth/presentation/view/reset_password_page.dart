import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/core/widgets/button/outlined_button_builder.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/text_form_field/text_and_form_field_column/without_icon/text_and_form_field_column_no_icon_hide.dart';
import 'package:nilelon/features/auth/presentation/view/login_page.dart';

import '../../../../core/widgets/scaffold_image.dart';

class ResetPassowrdView extends StatefulWidget {
  const ResetPassowrdView({
    super.key,
    required this.isLogin,
    required this.onTap,
  });
  final bool isLogin;
  final VoidCallback onTap;
  @override
  State<ResetPassowrdView> createState() => _ResetPassowrdViewState();
}

class _ResetPassowrdViewState extends State<ResetPassowrdView> {
  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return ScaffoldImage(
      appBar:
          customAppBar(title: lang.password, context: context, hasIcon: false),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ResetPasswordLoading) {
            BotToast.showLoading();
          }
          if (state is ResetPasswordSuccess) {
            BotToast.closeAllLoading();
            navigateTo(context: context, screen: const LoginView());
          }
          if (state is LoginFailure) {
            BotToast.closeAllLoading();
            BotToast.showText(text: state.errorMessage);
          }
        },
        child: Column(
          children: [
            const DefaultDivider(),
            const SizedBox(
              height: 50,
            ),
            TextAndFormFieldColumnNoIconHide(
              title: lang.newPassword,
              label: lang.enterNewPassword,
              controller: AuthCubit.get(context).newPasswordController,
              type: TextInputType.emailAddress,
            ),
            TextAndFormFieldColumnNoIconHide(
              title: lang.confirmPassword,
              label: lang.enterConfirmPassword,
              controller: AuthCubit.get(context).confirmPasswordController,
              type: TextInputType.emailAddress,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButtonBuilder(
                    text: lang.cancel,
                    ontap: () {
                      navigateTo(
                        context: context,
                        screen: const LoginView(),
                      );
                    }),
                GradientButtonBuilder(
                  text: lang.save,
                  ontap: widget.onTap,
                )
              ],
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
