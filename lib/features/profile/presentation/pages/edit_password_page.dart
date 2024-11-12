import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/core/constants/assets.dart';
import 'package:nilelon/features/auth/presentation/view/forget_password_page.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/core/widgets/button/outlined_button_builder.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/features/auth/presentation/view/reset_password_page.dart';

import '../../../../core/widgets/scaffold_image.dart';
import '../../../../core/widgets/text_form_field/text_and_form_field_column/with_icon/text_and_form_field_column_with_icon_hide.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../cubit/profile_cubit.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        state.mapOrNull(
          loading: (_) {
            BotToast.showLoading();
          },
          success: (_) {
            BotToast.closeAllLoading();
          },
          failure: (_) {
            BotToast.closeAllLoading();
            BotToast.showText(text: _.er);
          },
        );
      },
      child: ScaffoldImage(
        appBar: customAppBar(
            title: lang.password, context: context, hasIcon: false),
        body: Form(
          key: ProfileCubit.get(context).forgotPasswordForm,
          child: Column(
            children: [
              const DefaultDivider(),
              const SizedBox(
                height: 16,
              ),
              TextAndFormFieldColumnWithIconHide(
                image: Assets.assetsImagesLock,
                title: lang.currentPassword,
                label: lang.enterYourPassowrd,
                // spaceSize: 30,
                validator: (value) {
                  if (!AuthCubit.get(context).passwordRegex.hasMatch(value!)) {
                    return S.of(context).enterYourPassowrd;
                  }
                  return null;
                },
                onChange: (value) {
                  ProfileCubit.get(context)
                      .forgotPasswordForm
                      .currentState!
                      .validate();
                },
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
                      if (ProfileCubit.get(context)
                          .forgotPasswordForm
                          .currentState!
                          .validate()) {
                        navigateTo(
                          context: context,
                          screen: ResetPassowrdView(
                            isLogin: false,
                            form: AuthCubit.get(context).resetPasswordForm,
                            onTap: () {
                              AuthCubit.get(context).changePassword(context);
                            },
                          ),
                        );
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
    );
  }
}
