import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/core/tools.dart';
import 'package:nilelon/features/auth/domain/model/user_model.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/core/widgets/button/outlined_button_builder.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/pop_ups/success_creation_popup.dart';
import 'package:nilelon/core/widgets/text_form_field/text_and_form_field_column/without_icon/text_and_form_field_column_no_icon.dart';
import 'package:nilelon/features/auth/presentation/view/otp_page.dart';

import '../../../../core/resources/appstyles_manager.dart';
import '../../../../core/resources/const_functions.dart';
import '../../../../core/widgets/scaffold_image.dart';
import '../../../../core/widgets/text_form_field/text_field/const_text_form_field.dart';
import '../../../../core/widgets/text_form_field/text_field/text_form_field_builder.dart';
import '../cubit/profile_cubit.dart';

class EditPhoneNumPage extends StatefulWidget {
  const EditPhoneNumPage({super.key});

  @override
  State<EditPhoneNumPage> createState() => _EditPhoneNumPageState();
}

class _EditPhoneNumPageState extends State<EditPhoneNumPage> {
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
          phoneNumber(
            lang.enterPhoneNumber,
            '01234567899',
            ProfileCubit.get(context).phoneController,
            TextInputType.phone,
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
                          phoneOrEmail:
                              ' ${HiveStorage.get(HiveKeys.isStore) ? HiveStorage.get<UserModel>(HiveKeys.userModel).getUserData<StoreModel>().email : currentUsr<CustomerModel>().email}',
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
                            ProfileCubit.get(context)
                                .resetPasswordEmailOrPhone(context);
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

  Padding phoneNumber(
    String title,
    String label,
    TextEditingController controller,
    TextInputType type,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStylesManager.customTextStyleBl5,
          ),
          const SizedBox(
            height: 12,
          ),
          TextFormFieldBuilder(
            label: label,
            controller: controller,
            // maxLength: 11,

            onchanged: (value) {
              // ProfileCubit.get(context).regFormSto.currentState!.validate();
            },
            inputFormater: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              LengthLimitingTextInputFormatter(11),
            ],
            type: type,
            width: screenWidth(context, 0.9),
            noIcon: true,
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
