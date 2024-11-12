import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/features/home/view/customer_home_view.dart';
import 'package:nilelon/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/core/widgets/button/outlined_button_builder.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/text_form_field/text_and_form_field_column/without_icon/text_and_form_field_column_no_icon.dart';
import 'package:nilelon/features/auth/presentation/view/otp_page.dart';

import '../../../../core/tools.dart';
import '../../../../core/widgets/pop_ups/success_creation_popup.dart';
import '../../../../core/widgets/scaffold_image.dart';
import '../../../auth/domain/model/user_model.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';

class ChangeEmailPage extends StatelessWidget {
  const ChangeEmailPage({super.key});

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
            successCreationDialog(
              context: context,
              highlightedText: lang.emailChangedSuccessfully,
              regularText: lang
                  .yourEmailHasBeenChangedSuccessfullyWeWillLetYouKnowIfThereAnyProblem,
              buttonText: lang.ok,
              ontap: () {
                navigateTo(context: context, screen: const CustomerHomeView());
              },
            );
          },
          codeSentSuccess: (_) {
            BotToast.closeAllLoading();
            navigateTo(
              context: context,
              screen: OtpView(
                name: lang.verifyEmail,
                phoneOrEmail: currentUsr<CustomerModel>().email,
                buttonName: lang.verify,
                onSuccess: () {
                  ProfileCubit.get(context).resetEmail(context);
                },
                resend: () {
                  ProfileCubit.get(context).sendOtpEmail(context);
                },
              ),
            );
          },
          failure: (_) {
            BotToast.closeAllLoading();
            BotToast.showText(text: _.er);
          },
        );
      },
      child: ScaffoldImage(
        appBar:
            customAppBar(title: lang.email, context: context, hasIcon: false),
        body: Form(
          key: ProfileCubit.get(context).formEmail,
          child: Column(
            children: [
              const DefaultDivider(),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextAndFormFieldColumnNoIcon(
                  title: lang.addNewEmail,
                  validator: (value) {
                    if (!AuthCubit.get(context).emailRegex.hasMatch(value!)) {
                      return S.of(context).enterYourEmailToVerification;
                    }
                    return null;
                  },
                  label: lang.enterEmail,
                  controller: ProfileCubit.get(context).emailController,
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
                      if (ProfileCubit.get(context)
                          .formEmail
                          .currentState!
                          .validate()) {
                        ProfileCubit.get(context).sendOtpEmail(context);
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
