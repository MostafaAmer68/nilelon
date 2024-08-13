import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/data/hive_stroage.dart';
import 'package:nilelon/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/resources/const_functions.dart';
import 'package:nilelon/resources/appstyles_manager.dart';
import 'package:nilelon/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/widgets/text_form_field/text_field/text_field_pin.dart';

import '../../../../../utils/navigation.dart';
import '../../../../../widgets/pop_ups/success_creation_popup.dart';
import '../../../../shared/recommendation/recommendation_view.dart';

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
  int resendTime = 59;
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
            resendTime = resendTime - 1;
          },
        );
        if (resendTime < 1) {
          countDownTimer.cancel();
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
          BotToast.closeAllLoading();
        }
      },
      child: Scaffold(
        backgroundColor: ColorManager.primaryW,
        appBar: AppBar(
          backgroundColor: ColorManager.primaryW,
        ),
        body: SingleChildScrollView(
          reverse: true,
          // padding:
          //     EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    PinCodeView(
                      onCompleted: (code) {
                        AuthCubit.get(context).code = code;
                      },
                      length: 6,
                    ),
                  ],
                ),
              ),
              isValid
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              widget.resend;
                              resendTime = 59;
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
                          resendTime < 10
                              ? '00:0${resendTime.toString()}'
                              : '00:${resendTime.toString()}',
                          style: AppStylesManager.customTextStyleG,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                      ],
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
