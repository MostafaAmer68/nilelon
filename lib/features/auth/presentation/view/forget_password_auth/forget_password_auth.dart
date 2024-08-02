import 'package:flutter/material.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/resources/const_functions.dart';
import 'package:nilelon/resources/appstyles_manager.dart';
import 'package:nilelon/utils/navigation.dart';
import 'package:nilelon/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/widgets/divider/default_divider.dart';
import 'package:nilelon/widgets/text_form_field/text_and_form_field_column/without_icon/text_and_form_field_column_no_icon.dart';
import 'package:nilelon/features/auth/presentation/view/otp/otp_view.dart';
import 'package:nilelon/features/auth/presentation/view/new_password/new_password_view.dart';

class ForgetPasswordAuthView extends StatelessWidget {
  const ForgetPasswordAuthView({super.key, required this.isLogin});
  final bool isLogin;
  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Scaffold(
      appBar: customAppBar(title: lang.forgetPassword2, context: context),
      backgroundColor: ColorManager.primaryW,
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
              controller: TextEditingController(),
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
                      navigateTo(
                          context: context,
                          screen: OtpView(
                            name: lang.forgetYourPassword,
                            phoneOrEmail: 'Rawan@gmail.com',
                            buttonName: lang.verify,
                            ontap: () {
                              navigateTo(
                                  context: context,
                                  screen: NewPasswordView(
                                    isLogin: isLogin,
                                  ));
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
      ),
    );
  }
}
