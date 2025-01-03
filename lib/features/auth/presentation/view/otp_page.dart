import 'dart:async';
import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/core/widgets/text_form_field/text_field/text_field_pin.dart';

import '../../../../core/tools.dart';
import '../../../../core/widgets/scaffold_image.dart';

class OtpView extends StatefulWidget {
  const OtpView(
      {super.key,
      required this.name,
      required this.phoneOrEmail,
      required this.buttonName,
      required this.onSuccess,
      required this.resend});
  final String name;
  final String phoneOrEmail;
  final String buttonName;
  final void Function() onSuccess;
  final void Function() resend;
  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  bool invalidOTP = false;
  int resendTime = 180;
  late Timer countDownTimer;
  bool isValid = false;
  @override
  void initState() {
    startTimer();

    super.initState();
  }

  startTimer() {
    countDownTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(
          () {
            log('tes 22');
            resendTime = resendTime - 1;
          },
        );
        if (resendTime == 0) {
          stopTimer();
          isValid = true;
          setState(() {});
        }
      },
    );
  }

  stopTimer() {
    if (countDownTimer.isActive) {
      countDownTimer.cancel();
    }
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
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is VerificationSuccess) {
          widget.onSuccess();
        }
        if (state is LoginFailure) {
          BotToast.showText(text: state.errorMessage);
          stopTimer();
          isValid = true;
          setState(() {});
          BotToast.closeAllLoading();
        }
        if (state is CustomerRegisterFailure) {
          BotToast.showText(text: state.errorMessage);
          stopTimer();
          isValid = true;
          setState(() {});
          BotToast.closeAllLoading();
        }
        if (state is StoreRegisterFailure) {
          BotToast.showText(text: state.errorMessage);
          stopTimer();
          isValid = true;
          setState(() {});
          BotToast.closeAllLoading();
        }
      },
      child: ScaffoldImage(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: screenWidth(context, 1),
                height: screenHeight(context, 0.34),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/otp.png'),
                )),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                widget.name,
                style: AppStylesManager.customTextStyleBl4,
              ),
              const SizedBox(
                height: 14,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: lang.weHaveSent6DigitsVerificationCodeTo,
                      style: AppStylesManager.customTextStyleG,
                    ),
                    TextSpan(
                      text: widget.phoneOrEmail,
                      style: AppStylesManager.customTextStyleL,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 40,
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: PinCodeView(
                  onCompleted: (code) {
                    AuthCubit.get(context).code = code;
                  },
                  length: 6,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: isValid
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                widget.resend();
                                resendTime = 180;
                                isValid = false;
                                startTimer();
                                setState(() {});
                              },
                              child: Text(
                                lang.resend,
                                style: AppStylesManager.customTextStyleO2,
                              )),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            lang.resendIn,
                            style: AppStylesManager.customTextStyleG,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            formatDuration(Duration(seconds: resendTime)),
                            style: AppStylesManager.customTextStyleG,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                        ],
                      ),
              ),
              const SizedBox(
                height: 80,
              ),
              GradientButtonBuilder(
                text: widget.buttonName,
                ontap: () {
                  AuthCubit.get(context).validateOtp(context);
                },
                width: screenWidth(context, 0.92),
              )
            ],
          ),
        ),
      ),
    );
  }
}
