import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/core/widgets/text_form_field/text_and_form_field_column/with_icon/text_and_form_field_column_with_icon.dart';
import 'package:nilelon/core/widgets/text_form_field/text_and_form_field_column/with_icon/text_and_form_field_column_with_icon_hide.dart';
import 'package:nilelon/core/widgets/text_form_field/text_field/const_text_form_field.dart';
import 'package:nilelon/core/widgets/text_form_field/text_field/text_form_field_builder.dart';
import 'package:nilelon/features/auth/presentation/view/otp/otp_view.dart';
import 'package:nilelon/core/widgets/pop_ups/success_creation_popup.dart';
import 'package:nilelon/features/store_flow/layout/store_bottom_tab_bar.dart';

import '../../../../../core/widgets/scaffold_image.dart';

class StoreRegisterView extends StatefulWidget {
  const StoreRegisterView({super.key});

  @override
  State<StoreRegisterView> createState() => _StoreRegisterViewState();
}

class _StoreRegisterViewState extends State<StoreRegisterView> {
  bool showPassword = true;
  bool showRePassword = true;
  late final AuthCubit cubit;

  onpressed() {
    setState(
      () {
        showPassword = !showPassword;
      },
    );
  }

  @override
  void initState() {
    cubit = AuthCubit.get(context);
    super.initState();
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
              name: lang.confirmYourEmail,
              phoneOrEmail: AuthCubit.get(context).emailController.text,
              buttonName: lang.verifyAndCreateAccount,
              onSuccess: () {
                if (HiveStorage.get(HiveKeys.isStore)) {
                  AuthCubit.get(context).authStoreRegister(context);
                }
              },
              resend: () {
                AuthCubit.get(context).confirmRegisteration(context);
              },
            ),
          );
        }
        if (state is StoreRegisterSuccess) {
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
                  context: context, screen: const StoreBottomTabBar());
            },
          );
        }
      },
      child: ScaffoldImage(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    lang.createStoreAccount,
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
                title: lang.storeName,
                label: lang.enterStoreName,
                controller: cubit.nameController,
                type: TextInputType.text,
                image: 'assets/images/profile.svg',
              ),
              TextAndFormFieldColumnWithIcon(
                title: lang.email,
                label: lang.enterYourEmail,
                controller: cubit.emailController,
                type: TextInputType.emailAddress,
                image: 'assets/images/sms-tracking.svg',
              ),
              phoneNumber(
                lang.phoneNumber,
                '01234567899',
                cubit.phoneController,
                TextInputType.phone,
              ),
              TextAndFormFieldColumnWithIcon(
                title: lang.storeRepresentativeName,
                label: lang.storeRepresentativeName,
                controller: cubit.repNameController,
                type: TextInputType.text,
                image: 'assets/images/user-tag.svg',
              ),
              phoneNumber(
                lang.storeRepresentativeNumber,
                '01234567899',
                cubit.repPhoneController,
                TextInputType.phone,
              ),
              TextAndFormFieldColumnWithIcon(
                title: lang.warehouseAddress,
                label: lang.enterYourWarehouseAddress,
                controller: cubit.wareHouseAddressController,
                type: TextInputType.text,
                image: 'assets/images/location.svg',
              ),
              TextAndFormFieldColumnWithIcon(
                desc: ' (Facebook or Instagram)',
                title: lang.profileLink,
                label: lang.enterYourProfileLink,
                controller: cubit.profileLinkController,
                type: TextInputType.url,
                image: 'assets/images/Link.svg',
              ),
              TextAndFormFieldColumnWithIcon(
                desc: lang.ifYouHaveOne,
                title: lang.websiteLink,
                label: lang.enterYourWebsiteLink,
                controller: cubit.websiteLinkController,
                type: TextInputType.url,
                image: 'assets/images/global.svg',
              ),
              TextAndFormFieldColumnWithIconHide(
                title: lang.password,
                label: lang.enterYourPassowrd,
                controller: cubit.passwordController,
                type: TextInputType.text,
                image: 'assets/images/lock.svg',
              ),
              TextAndFormFieldColumnWithIconHide(
                title: lang.confirmPassword,
                label: lang.confirmYourPassword,
                controller: cubit.confirmPasswordController,
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
                        style: const TextStyle(
                          color: Color(0xFF3F484A),
                          fontSize: 12,
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
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       SizedBox(
              //           width: screenWidth(context, 0.24),
              //           child: const Divider()),
              //       Text(
              //         'Or sign up with',
              //         style: AppStylesManager.customTextStyleB,
              //       ),
              //       SizedBox(
              //           width: screenWidth(context, 0.24),
              //           child: const Divider()),
              //     ],
              //   ),
              // ),
              // const SizedBox(
              //   height: 30,
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       signWithContainer('assets/images/facebook.svg', () {}),
              //       const SizedBox(
              //         width: 24,
              //       ),
              //       signWithContainer('assets/images/google.svg', () {}),
              //     ],
              //   ),
              // ),
              // const SizedBox(
              //   height: 32,
              // ),
            ],
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
                type: type,
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
}
