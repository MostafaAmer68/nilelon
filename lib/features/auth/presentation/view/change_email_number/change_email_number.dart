import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:nilelon/core/generated/l10n.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/core/widgets/button/outlined_button_builder.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/text_form_field/text_and_form_field_column/without_icon/text_and_form_field_column_no_icon.dart';
import 'package:nilelon/features/auth/presentation/view/otp/otp_view.dart';

import '../../../../../core/widgets/pop_ups/success_creation_popup.dart';
import '../../../../../core/widgets/scaffold_image.dart';

class ChangeEmail extends StatelessWidget {
  const ChangeEmail({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ResetEmailSuccess) {
          BotToast.closeAllLoading();
          successCreationDialog(
            context: context,
            highlightedText: lang.emailChangedSuccessfully,
            regularText: lang
                .yourEmailHasBeenChangedSuccessfullyWeWillLetYouKnowIfThereAnyProblem,
            buttonText: lang.ok,
            ontap: () {
              navigatePop(context: context);
            },
          );
        }
        if (state is LoginLoading) {
          BotToast.showLoading();
        }
        if (state is LoginFailure) {
          BotToast.closeAllLoading();
          BotToast.showText(text: state.errorMessage);
        }
        if (state is VerificationCodeSent) {
          BotToast.closeAllLoading();
          navigateTo(
            context: context,
            screen: OtpView(
              name: lang.verifyEmail,
              phoneOrEmail: AuthCubit.get(context).emailController.text,
              buttonName: lang.verify,
              onSuccess: () {
                AuthCubit.get(context).resetEmail(context);
              },
              resend: () {
                AuthCubit.get(context).sendOtpEmail(context);
              },
            ),
          );
        }
      },
      child: ScaffoldImage(
        appBar:
            customAppBar(title: lang.email, context: context, hasIcon: false),
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
                controller: AuthCubit.get(context).emailController,
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
                    AuthCubit.get(context).sendOtpEmail(context);
                  },
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
