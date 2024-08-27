import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:nilelon/features/shared/recommendation/recommendation_view.dart';
import 'package:nilelon/core/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/core/widgets/text_form_field/text_and_form_field_column/with_icon/text_and_form_field_column_with_icon.dart';
import 'package:nilelon/core/widgets/text_form_field/text_and_form_field_column/with_icon/text_and_form_field_column_with_icon_hide.dart';
import 'package:nilelon/features/auth/presentation/view/forget_password_auth/forget_password_auth.dart';
import 'package:nilelon/features/auth/presentation/view/customer_register/customer_register_view.dart';
import 'package:nilelon/features/auth/presentation/view/store_register/store_register_view.dart';
import 'package:nilelon/features/auth/presentation/widgets/sign_with_container.dart';
import 'package:nilelon/features/store_flow/layout/store_bottom_tab_bar.dart';

class LoginView extends StatefulWidget {
  const LoginView({
    super.key,
  });
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool showPassword = true;
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();

  onpressed() {
    setState(
      () {
        showPassword = !showPassword;
      },
    );
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    final authCubit = AuthCubit.get(context);

    return Scaffold(
      backgroundColor: ColorManager.primaryW,
      appBar: AppBar(
        backgroundColor: ColorManager.primaryW,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.sp),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    lang.welcomeBackToNilelon,
                    style: AppStylesManager.customTextStyleBl4,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.sp),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    HiveStorage.get(HiveKeys.isStore)
                        ? lang.pleasesigninwithyourStoreAccount
                        : lang.pleaseSignInWithYourAccount,
                    style: AppStylesManager.customTextStyleG,
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              TextAndFormFieldColumnWithIcon(
                title: lang.email,
                label: lang.enterYourEmail,
                controller: AuthCubit.get(context).emailController,
                type: TextInputType.emailAddress,
                image: 'assets/images/sms-tracking.svg',
              ),
              TextAndFormFieldColumnWithIconHide(
                title: lang.password,
                label: lang.enterYourPassowrd,
                controller: AuthCubit.get(context).passwordController,
                type: TextInputType.text,
                image: 'assets/images/lock.svg',
                spaceHeight: 12,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          navigateTo(
                              context: context,
                              screen: const ForgetPasswordAuthView(
                                isLogin: true,
                              ));
                        },
                        child: Text(
                          lang.forgetPassword,
                          style: AppStylesManager.customTextStyleL,
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.sp),
                child: BlocListener<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is LoginLoading) {
                      setState(() {
                        isLoading = true;
                      });
                    } else if (state is LoginSuccess) {
                      BotToast.closeAllLoading();
                      setState(() {
                        isLoading = false;
                      });
                      HiveStorage.get(HiveKeys.isStore)
                          ? navigateAndRemoveUntil(
                              context: context,
                              screen: const StoreBottomTabBar())
                          : navigateAndRemoveUntil(
                              context: context,
                              screen: const RecommendationView());
                      BotToast.showText(
                        text: state.successMSG,
                      );
                    } else if (state is LoginFailure) {
                      setState(() {
                        isLoading = false;
                      });
                      BotToast.showText(
                        text: state.errorMessage,
                      );
                    } else {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  child: GradientButtonBuilder(
                    text: lang.signIn,
                    ontap: () {
                      if (formKey.currentState!.validate()) {
                        authCubit.authLogin(context);
                      }
                    },
                    isLoading: isLoading,
                    width: screenWidth(context, 1),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: screenWidth(context, 0.24),
                        child: const Divider()),
                    Text(
                      lang.orSignInWith,
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
                    signWithContainer('assets/images/facebook.svg', () {}),
                    const SizedBox(
                      width: 24,
                    ),
                    signWithContainer('assets/images/google.svg', () {}),
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    lang.dontHaveAnAccount,
                    style: AppStylesManager.customTextStyleG3,
                  ),
                  TextButton(
                      onPressed: () {
                        HiveStorage.get(HiveKeys.isStore)
                            ? navigateTo(
                                context: context,
                                screen: const StoreRegisterView(),
                              )
                            : navigateTo(
                                context: context,
                                screen: const CustomerRegisterView(),
                              );
                      },
                      child: Text(
                        lang.createAccount,
                        style: AppStylesManager.customTextStyleL,
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
