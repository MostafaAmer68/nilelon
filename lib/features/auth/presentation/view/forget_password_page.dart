import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/core/constants/assets.dart';
import 'package:nilelon/core/widgets/text_form_field/text_and_form_field_column/with_icon/text_and_form_field_column_with_icon.dart';
import 'package:nilelon/core/widgets/text_form_field/text_and_form_field_column/without_icon/text_and_form_field_column_no_icon_hide.dart';
import 'package:nilelon/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:nilelon/features/profile/presentation/cubit/profile_cubit.dart';
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
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        state.mapOrNull(
          loading: (_) => BotToast.showLoading(),
          failure: (_) {
            BotToast.closeAllLoading();
            BotToast.showText(text: _.er);
          },
          codeSentSuccess: (_) {
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
                      form: AuthCubit.get(context).resetPasswordForm,
                      onTap: () {
                        AuthCubit.get(context).forgotPassword(context);
                      },
                    ),
                  );
                },
                resend: () {
                  ProfileCubit.get(context).resetPasswordEmailOrPhone(context);
                },
              ),
            );
          },
        );
      },
      child: ScaffoldImage(
        appBar: customAppBar(title: lang.forgetPassword2, context: context),
        body: Form(
          key: ProfileCubit.get(context).formResetPass,
          child: Padding(
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
                TextAndFormFieldColumnWithIcon(
                  title: lang.emailOrPhoneNumber,
                  label: lang.enterYourEmailOrPhoneNumber,
                  image: Assets.assetsImagesEmail,
                  validator: (value) {
                    if (value!.startsWith('0')) {
                      if (!AuthCubit.get(context).phoneRegex.hasMatch(value)) {
                        return lang.enterPhoneNumber;
                      }
                    } else {
                      if (!AuthCubit.get(context).emailRegex.hasMatch(value)) {
                        return lang.enterEmail;
                      }
                    }

                    return null;
                  },
                  onChange: (v) {
                    ProfileCubit.get(context)
                        .formResetPass
                        .currentState!
                        .validate();
                  },
                  controller: ProfileCubit.get(context).emailOrPhoneController,
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
                        if (ProfileCubit.get(context)
                            .formResetPass
                            .currentState!
                            .validate()) {
                          ProfileCubit.get(context)
                              .resetPasswordEmailOrPhone(context);
                        }
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
      ),
    );
  }
}
