import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/widgets/button/button_builder.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/core/widgets/text_form_field/text_field/text_form_field_builder.dart';
import 'package:nilelon/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:nilelon/features/checkout/presentation/cubit/checkout_cubit/checkout_cubit.dart';
import 'package:nilelon/features/checkout/presentation/cubit/progress_cubit/progress_cubit.dart';

class BillingDetailsStep extends StatefulWidget {
  const BillingDetailsStep({super.key});

  @override
  State<BillingDetailsStep> createState() => _BillingDetailsStepState();
}

class _BillingDetailsStepState extends State<BillingDetailsStep> {
  GlobalKey<FormState> formKey = GlobalKey();
  String _tempSelectedOption = '';
  List<String> options = [
    'Visa Card',
    'Credit Card',
    'Cash',
  ];
  late final CheckOutCubit cubit;
  @override
  void initState() {
    cubit = CheckOutCubit.get(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // BotToast.closeAllLoading();
    final progressCubit = BlocProvider.of<ProgressCubit>(context);
    final lang = S.of(context);
    return BlocListener<CheckOutCubit, CheckOutState>(
      listener: (context, state) {
        if (state is CheckOutLoading) {
          BotToast.showLoading();
        }
        if (state is CheckOutFailure) {
          BotToast.closeAllLoading();
          BotToast.showText(text: state.errorMessage);
        }
        if (state is CheckOutSuccess) {
          BotToast.closeAllLoading();
          CartCubit.get(context).emptyCart();

          progressCubit.nextStep();
        }
      },
      child: Form(
        key: formKey,
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: ColorManager.primaryG17,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textAndTextField(
                    title: lang.phoneNumber,
                    label: lang.phoneNumber,
                    controller: cubit.phoneController,
                    type: TextInputType.phone),
                textAndTextField(
                    title: lang.addressLine1,
                    label: lang.enterYourStreetAddress,
                    controller: cubit.addressLine1,
                    type: TextInputType.text),
                textAndTextField(
                    title: lang.addressLine2,
                    label: lang.enterYourStreetAddress,
                    controller: cubit.addressLine2,
                    type: TextInputType.text),
                textAndTextField(
                    title: lang.streetAddress,
                    label: lang.enterYourStreetAddress,
                    controller: cubit.streetAddress,
                    type: TextInputType.text),
                textAndTextField(
                    title: lang.unitNumber,
                    label: lang.enterYourUnitNumber,
                    controller: cubit.unitNumber,
                    type: TextInputType.text),
                textAndTextField(
                    title: lang.landmark,
                    label: lang.enterLandmark,
                    controller: cubit.landmark,
                    type: TextInputType.text),
                textAndTextField(
                    title: lang.city,
                    label: lang.enterYourCity,
                    controller: cubit.city,
                    type: TextInputType.text),
                const SizedBox(
                  height: 16,
                ),
                paymentItems(),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonBuilder(
                      text: lang.previous,
                      ontap: () {
                        progressCubit.previousStep();
                      },
                    ),
                    GradientButtonBuilder(
                      text: lang.pay,
                      ontap: () {
                        // progressCubit.nextStep();
                        if (formKey.currentState!.validate()) {
                          cubit.createOrder(context);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column paymentItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).paymentMethod,
          style: AppStylesManager.customTextStyleBl8
              .copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 12,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: options
              .map((option) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Container(
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFBF9F9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
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
                      child: Center(
                        child: RadioListTile(
                          title: Text(
                            option,
                            style: AppStylesManager.customTextStyleBl9,
                          ),
                          value: option,
                          activeColor: ColorManager.primaryO,
                          groupValue: _tempSelectedOption,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 6,
                          ),
                          onChanged: (value) {
                            setState(() {
                              CheckOutCubit.get(context).selectedOption =
                                  value!;
                              _tempSelectedOption = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Column textAndTextField({
    required String title,
    required String label,
    required controller,
    required type,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppStylesManager.customTextStyleBl8
              .copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 12,
        ),
        TextFormFieldBuilder(
          label: label,
          controller: controller,
          type: type,
          width: screenWidth(context, 1),
          noIcon: true,
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
