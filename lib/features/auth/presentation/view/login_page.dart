import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:nilelon/features/auth/presentation/view/forget_password_page.dart';
import 'package:nilelon/features/shared/recommendation/presentation/view/recommendation_view.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/core/widgets/text_form_field/text_and_form_field_column/with_icon/text_and_form_field_column_with_icon.dart';
import 'package:nilelon/core/widgets/text_form_field/text_and_form_field_column/with_icon/text_and_form_field_column_with_icon_hide.dart';
import 'package:nilelon/features/auth/presentation/view/customer_register_view.dart';
import 'package:nilelon/features/auth/presentation/view/store_register_view.dart';
import 'package:nilelon/features/auth/presentation/widgets/sign_with_container.dart';
import 'package:nilelon/features/layout/store_bottom_tab_bar.dart';

import '../../../../core/constants/assets.dart';
import '../../../../core/widgets/scaffold_image.dart';

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
  void dispose() {
    AuthCubit.get(context).emailController.clear();
    AuthCubit.get(context).passwordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    final authCubit = AuthCubit.get(context);

    return ScaffoldImage(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Form(
        key: authCubit.loginForm,
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return S.of(context).enterYourEmail;
                  }
                  if (!AuthCubit.get(context).emailRegex.hasMatch(value)) {
                    return S.of(context).enterValideEmail;
                  }
                  return null;
                },
                onChange: (value) {
                  authCubit.loginForm.currentState!.validate();
                },
                controller: AuthCubit.get(context).emailController,
                type: TextInputType.emailAddress,
                image: Assets.assetsImagesSmsTracking,
              ),
              TextAndFormFieldColumnWithIconHide(
                title: lang.password,
                label: lang.enterYourPassowrd,
                validator: (value) {
                  if (value!.isEmpty) {
                    return S.of(context).enterYourPassowrd;
                  }
                  if (!AuthCubit.get(context).passwordRegex.hasMatch(value)) {
                    return S.of(context).enterValidePass;
                  }
                  return null;
                },
                onChange: (value) {
                  authCubit.loginForm.currentState!.validate();
                },
                controller: AuthCubit.get(context).passwordController,
                type: TextInputType.text,
                image: Assets.assetsImagesLock,
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
                            screen: const ForgetPasswordPage(
                              isLogin: true,
                            ));
                      },
                      child: Text(
                        lang.forgetPassword,
                        style: AppStylesManager.customTextStyleL,
                      ),
                    ),
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
                      authCubit.authLogin(context);
                    },
                    isLoading: isLoading,
                    width: screenWidth(context, 1),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              if (HiveStorage.get(HiveKeys.isStore) == false) ...[
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
                      BlocListener<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state is GoogleInLoading) {
                          } else if (state is GoogleInSuccess) {
                            navigateAndRemoveUntil(
                                context: context,
                                screen: const RecommendationView());
                          } else if (state is GoogleInFailure) {
                            BotToast.showText(
                                text: S.of(context).failedRegister);
                          }
                        },
                        child: signWithContainer(
                          Assets.assetsImagesGoogle,
                          () {
                            BlocProvider.of<AuthCubit>(context)
                                .signInWithGoogle(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
              ],
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
