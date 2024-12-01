import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/core/tools.dart';
import 'package:nilelon/features/promo/presentation/cubit/promo_cubit.dart';

import '../../../../core/resources/const_functions.dart';
import '../../../../core/widgets/button/button_builder.dart';
import '../../../../core/widgets/text_form_field/text_field/text_form_field_builder.dart';

class TxtFieldPromo extends StatefulWidget {
  const TxtFieldPromo({super.key});

  @override
  State<TxtFieldPromo> createState() => _TxtFieldPromoState();
}

class _TxtFieldPromoState extends State<TxtFieldPromo> {
  @override
  Widget build(BuildContext context) {
    final PromoCubit cubit = PromoCubit.get(context);
    return Form(
      key: cubit.applyOfferForm,
      child: Row(
        children: [
          TextFormFieldBuilder(
            label: lang(context).promoCode,
            controller: cubit.promoCode,
            type: TextInputType.text,
            width: screenWidth(context, 0.65),
            validator: (v) {
              if (v!.isEmpty) {
                return lang(context).promoCode;
              }
              return null;
            },
            noIcon: false,
            isIcon: false,
            prefixWidget: const Icon(Iconsax.ticket_discount),
          ),
          const Spacer(),
          BlocConsumer<PromoCubit, PromoState>(
            listener: (context, state) {
              if (state is PromoFailure) {
                BotToast.showText(text: 'Promocode invalid');
              }
              if (state is PromoSuccess) {
                BotToast.showText(text: 'Promocode applied');
              }
            },
            builder: (context, state) => state is PromoLoading
                ? const Center(child: CircularProgressIndicator())
                : ButtonBuilder(
                    text: lang(context).apply,
                    ontap: () {
                      if (cubit.applyOfferForm.currentState!.validate()) {
                        cubit.getPromoCodeType(context);
                      }
                    },
                    isActivated: cubit.discount == 0,
                    height: 54,
                    frameColor: Colors.transparent,
                    width: screenWidth(context, 0.24),
                  ),
          ),
        ],
      ),
    );
  }
}
