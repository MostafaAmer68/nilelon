import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:nilelon/features/auth/presentation/view/otp_view.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/core/widgets/pop_ups/calender_register_popup.dart';
import 'package:nilelon/core/widgets/text_form_field/text_and_form_field_column/with_icon/text_and_form_field_column_with_icon.dart';
import 'package:nilelon/core/widgets/text_form_field/text_and_form_field_column/with_icon/text_and_form_field_column_with_icon_hide.dart';
import 'package:nilelon/core/widgets/text_form_field/text_field/const_text_form_field.dart';
import 'package:nilelon/core/widgets/text_form_field/text_field/text_form_field_builder.dart';
import 'package:nilelon/features/auth/presentation/widgets/sign_with_container.dart';
import 'package:nilelon/features/shared/recommendation/presentation/view/recommendation_view.dart';
import 'package:svg_flutter/svg.dart';

import '../../../../core/widgets/pop_ups/success_creation_popup.dart';
import '../../../../core/data/hive_stroage.dart';
import '../../../../core/widgets/scaffold_image.dart';

class CustomerRegisterView extends StatefulWidget {
  const CustomerRegisterView({super.key});

  @override
  State<CustomerRegisterView> createState() => _CustomerRegisterViewState();
}

class _CustomerRegisterViewState extends State<CustomerRegisterView> {
  bool showPassword = true;
  bool showRePassword = true;
  DateTime? datee;
  final List<String> _gender = ['Male', 'Female'];
  String _tempSelectedOption = '';

  onpressed() {
    setState(
      () {
        showPassword = !showPassword;
      },
    );
  }

  onrepressed() {
    setState(
      () {
        showRePassword = !showRePassword;
      },
    );
  }

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
              name: lang.confirmYourEmail,
              phoneOrEmail: AuthCubit.get(context).emailController.text,
              buttonName: lang.verifyAndCreateAccount,
              onSuccess: () {
                if (!HiveStorage.get(HiveKeys.isStore)) {
                  AuthCubit.get(context).authCustomerRegister(context);
                }
              },
              resend: () {
                AuthCubit.get(context).confirmRegisteration(context);
              },
            ),
          );
        }
        if (state is CustomerRegisterSuccess) {
          BotToast.closeAllLoading();
          successCreationDialog(
            isDismissible: false,
            context: context,
            highlightedText: lang.signUpSuccessfully,
            regularText:
                lang.youWillBeMovedToHomeScreenRightNowEnjoyTheFeatures,
            buttonText: lang.letsStart,
            ontap: () {
              navigateAndRemoveUntil(
                context: context,
                screen: const RecommendationView(),
              );
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
      },
      child: ScaffoldImage(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Form(
          key: AuthCubit.get(context).regFormCuts,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      lang.createAccount,
                      style: AppStylesManager.customTextStyleBl4,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      lang.registerWithYourValidEmailAddress,
                      style: AppStylesManager.customTextStyleG,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextAndFormFieldColumnWithIcon(
                    title: lang.fullName,
                    label: lang.enterYourName,
                    controller: AuthCubit.get(context).nameController,
                    type: TextInputType.text,
                    image: 'assets/images/profile.svg',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return S.of(context).enterYourName;
                      }
                      return null;
                    }),
                TextAndFormFieldColumnWithIcon(
                  title: lang.email,
                  label: lang.enterYourEmail,
                  validator: (value) {
                    if (!AuthCubit.get(context).emailRegex.hasMatch(value!)) {
                      return S.of(context).enterYourEmailToVerification;
                    }
                    return null;
                  },
                  controller: AuthCubit.get(context).emailController,
                  type: TextInputType.emailAddress,
                  image: 'assets/images/sms-tracking.svg',
                ),
                phoneNumber(
                  lang.phoneNumber,
                  '01234567899',
                  AuthCubit.get(context).phoneController,
                  TextInputType.phone,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      lang.gender,
                      style: AppStylesManager.customTextStyleBl5,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _gender
                        .map((option) => genderOptions(context, option))
                        .toList(),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                calender(
                  lang.dateOfBirth,
                  '00/00/0000',
                ),
                TextAndFormFieldColumnWithIconHide(
                  title: lang.password,
                  label: lang.enterYourPassowrd,
                  validator: (value) {
                    if (!AuthCubit.get(context)
                        .passwordRegex
                        .hasMatch(value!)) {
                      return S.of(context).enterYourPassowrd;
                    }
                    return null;
                  },
                  onChange: (value) {
                    AuthCubit.get(context).regFormCuts.currentState!.validate();
                  },
                  controller: AuthCubit.get(context).passwordController,
                  type: TextInputType.text,
                  image: 'assets/images/lock.svg',
                ),
                TextAndFormFieldColumnWithIconHide(
                  title: lang.confirmPassword,
                  label: lang.confirmYourPassword,
                  validator: (value) {
                    if (!AuthCubit.get(context)
                        .passwordRegex
                        .hasMatch(value!)) {
                      return S.of(context).enterYourPassowrd;
                    } else if (value !=
                        AuthCubit.get(context).passwordController.text) {
                      return S.of(context).confirmPassword;
                    }
                    return null;
                  },
                  onChange: (value) {
                    AuthCubit.get(context).regFormCuts.currentState!.validate();
                  },
                  controller: AuthCubit.get(context).confirmPasswordController,
                  type: TextInputType.text,
                  image: 'assets/images/lock.svg',
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: lang.byClickingRegisterYouAgreeTo,
                          style: TextStyle(
                            color: const Color(0xFF3F484A),
                            fontSize: 1.sw > 600 ? 18 : 12,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.w500,
                            height: 0.11,
                          ),
                        ),
                        TextSpan(
                          text: lang.ourTermsAndConditionsOfUse,
                          style: AppStylesManager.customTextStyleL2,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                GradientButtonBuilder(
                  text: lang.register,
                  ontap: () {
                    AuthCubit.get(context).confirmRegisteration(context);
                  },
                  width: screenWidth(context, 0.92),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: screenWidth(context, 0.24),
                          child: const Divider()),
                      Text(
                        lang.orSignUpWith,
                        style: AppStylesManager.customTextStyleB,
                      ),
                      SizedBox(
                          width: screenWidth(context, 0.24),
                          child: const Divider()),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // signWithContainer('assets/images/facebook.svg', () {}),
                      // const SizedBox(
                      //   width: 24,
                      // ),
                      BlocListener<AuthCubit, AuthState>(
                          listener: (context, state) {
                            if (state is GoogleRegisterLoading) {
                            } else if (state is GoogleRegisterSuccess) {
                              navigateAndRemoveUntil(
                                  context: context,
                                  screen: const RecommendationView());
                            } else if (state is GoogleRegisterFailure) {
                              BotToast.showText(
                                  text: S.of(context).failedRegister);
                            }
                          },
                          child:
                              signWithContainer('assets/images/google.svg', () {
                            BlocProvider.of<AuthCubit>(context)
                                .signUpWithGoogle(context);
                          })),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
              ],
            ),
          ),
        ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ConstTextFieldBuilder(
                label: '+20',
                width: screenWidth(context, 0.15),
                style: AppStylesManager.customTextStyleBl3,
              ),
              TextFormFieldBuilder(
                label: label,
                controller: controller,
                maxLength: 11,
                type: type,
                validator: (value) {
                  if (!AuthCubit.get(context).phoneRegex.hasMatch(value!)) {
                    return S.of(context).plsEnterValidNumber;
                  }
                  return null;
                },
                onchanged: (value) {
                  AuthCubit.get(context).regFormCuts.currentState!.validate();
                },
                width: screenWidth(context, 0.75),
                noIcon: true,
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Padding calender(
    String title,
    String label,
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
          GestureDetector(
            onTap: () async {
              await calenderRegisterDialog(context);
              setState(() {});
            },
            child: ConstTextFieldBuilder(
              textAlign: TextAlign.start,
              label: AuthCubit.get(context).dateFormatted ?? label,
              prefixWidget: Container(
                  width: 20,
                  height: 20,
                  padding: const EdgeInsets.all(8),
                  child: SvgPicture.asset('assets/images/Calendar.svg')),
              width: screenWidth(context, 0.92),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Container genderOptions(BuildContext context, String option) {
    return Container(
      decoration: ShapeDecoration(
        color: Colors.transparent, //AppStyles.primaryB5,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 2,
            color: Color(0xFFFBF9F9),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x33726363),
            blurRadius: 16,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.43,
        decoration: _tempSelectedOption == option
            ? BoxDecoration(
                color: const Color(0xFFFBF9F9),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFFBF9F9)))
            : BoxDecoration(
                color: const Color(0xFFFBF9F9),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFFBF9F9))),
        child: Center(
          child: RadioListTile(
            title: Text(option),
            value: option,
            activeColor: ColorManager.primaryB,
            groupValue: _tempSelectedOption,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
            onChanged: (value) {
              setState(() {
                // _serverOptionSelected
                AuthCubit.get(context).gender = value == 'Male';
                _tempSelectedOption = value!;
              });
            },
          ),
        ),
      ),
    );
  }
}
