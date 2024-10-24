import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/text_form_field/text_and_form_field_column/without_icon/text_and_form_field_column_no_icon.dart';
import 'package:nilelon/features/auth/presentation/view/otp_page.dart';
import 'package:nilelon/features/auth/presentation/view/reset_password_page.dart';

import '../../../../core/widgets/scaffold_image.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key, required this.isLogin});
  final bool isLogin;
  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is VerificationCodeSent) {
          BotToast.closeAllLoading();
          navigateTo(
            context: context,
            screen: OtpView(
              name: lang.forgetYourPassword,
              phoneOrEmail: AuthCubit.get(context).emailController.text,
              buttonName: lang.verify,
              onSuccess: () {
                BotToast.closeAllLoading();
                navigateTo(
                    context: context,
                    screen: ResetPassowrdView(
                      isLogin: isLogin,
                      onTap: () {
                        AuthCubit.get(context).forgotPassword(context);
                      },
                    ));
              },
              resend: () {
                AuthCubit.get(context).resetPasswordEmail(context);
              },
            ),
          );
        }
        if (state is LoginLoading) {
          BotToast.showLoading();
        }
      },
      child: ScaffoldImage(
        appBar: customAppBar(title: lang.forgetPassword2, context: context),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DefaultDivider(),
              const SizedBox(
                height: 45,
              ),
              Text(
                lang.forgetYourPassword,
                style: AppStylesManager.customTextStyleBl2,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                lang.enterYourEmailOrPhoneNumberToVerification,
                style: AppStylesManager.customTextStyleG15,
              ),
              const SizedBox(
                height: 36,
              ),
              TextAndFormFieldColumnNoIcon(
                title: lang.emailOrPhoneNumber,
                label: lang.enterYourEmailOrPhoneNumber,
                controller: AuthCubit.get(context).emailController,
                type: TextInputType.emailAddress,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GradientButtonBuilder(
                    text: lang.continuePress,
                    width: screenWidth(context, 0.9),
                    ontap: () {
                      AuthCubit.get(context).resetPasswordEmail(context);
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
      ),
    );
  }
}
