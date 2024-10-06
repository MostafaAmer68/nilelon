import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/core/widgets/button/outlined_button_builder.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/pop_ups/success_creation_popup.dart';
import 'package:nilelon/core/widgets/text_form_field/text_and_form_field_column/without_icon/text_and_form_field_column_no_icon.dart';
import 'package:nilelon/features/auth/presentation/view/otp_view.dart';

import '../../../../core/widgets/scaffold_image.dart';

class ChangePhoneNumber extends StatelessWidget {
  const ChangePhoneNumber({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return ScaffoldImage(
      appBar: customAppBar(
          title: lang.phoneNumber, context: context, hasIcon: false),
      body: Column(
        children: [
          const DefaultDivider(),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: EdgeInsets.all(16.0.sp),
            child: TextAndFormFieldColumnNoIcon(
              title: lang.newPhoneNumber,
              label: lang.enterPhoneNumber,
              controller: TextEditingController(),
              type: TextInputType.phone,
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
                    navigateTo(
                        context: context,
                        screen: OtpView(
                          name: lang.verifyPhoneNumber,
                          phoneOrEmail: 'Ra****@gmail.com',
                          buttonName: lang.verify,
                          onSuccess: () {
                            successCreationDialog(
                              context: context,
                              highlightedText:
                                  lang.phoneNumberChangedSuccessfully,
                              regularText: lang
                                  .yourPhoneNumberHasBeenChangedSuccessfullyWeWillLetYouKnowIfThereAnyProblem,
                              buttonText: S.of(context).ok,
                              ontap: () {},
                            );
                          },
                          resend: () {
                            AuthCubit.get(context).resetPasswordEmail(context);
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
