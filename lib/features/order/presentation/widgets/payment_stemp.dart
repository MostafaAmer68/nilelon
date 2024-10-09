import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/widgets/button/button_builder.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/core/widgets/text_form_field/text_field/const_text_form_field.dart';
import 'package:nilelon/core/widgets/text_form_field/text_field/text_form_field_builder.dart';
import 'package:nilelon/features/order/presentation/widgets/date_picker_check_out.dart';
import 'package:svg_flutter/svg.dart';

import '../progress_cubit/progress_cubit.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool isLoading = false;
  late DateTime time;
  String? formattedDate;
  @override
  Widget build(BuildContext context) {
    final progressCubit = BlocProvider.of<ProgressCubit>(context);
    final lang = S.of(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      color: ColorManager.primaryG17,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            textAndTextField(
                title: lang.cardNumber,
                label: 'xxxx-xxxx-xxxx-xxxx',
                prefix: 'assets/images/Card.svg',
                controller: TextEditingController(),
                type: TextInputType.number,
                width: 1),
            textAndTextField(
                title: lang.cardHolderName,
                label: lang.enterHolderName,
                prefix: 'assets/images/profile.svg',
                controller: TextEditingController(),
                type: TextInputType.text,
                width: 1),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lang.expDate,
                      style: AppStylesManager.customTextStyleBl8
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    GestureDetector(
                      onTap: () async {
                        time = await datePickerCheckOut(context);
                        formattedDate = DateFormat('MM/yyyy').format(time);
                        setState(() {});
                        log(time.toString());
                      },
                      child: ConstTextFieldBuilder(
                        label: formattedDate ?? 'MM/YYYY',
                        prefixWidget: Container(
                            width: 20,
                            height: 20,
                            padding: const EdgeInsets.all(12),
                            child:
                                SvgPicture.asset('assets/images/Calendar.svg')),
                        width: screenWidth(context, 0.43),
                      ),
                    ),
                  ],
                ),
                textAndTextField(
                  title: 'CVV',
                  label: 'XXX',
                  prefix: 'assets/images/lock.svg',
                  controller: TextEditingController(),
                  type: TextInputType.number,
                  width: 0.43,
                ),
              ],
            ),
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
                  isLoading: isLoading,
                  ontap: () {
                    progressCubit.nextStep();
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column textAndTextField(
      {required String title,
      required String label,
      required String prefix,
      required controller,
      required type,
      required double width}) {
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
          width: screenWidth(context, width),
          noIcon: false,
          isIcon: false,
          prefixWidget: Container(
              width: 20,
              height: 20,
              padding: const EdgeInsets.all(12),
              child: SvgPicture.asset(prefix)),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
