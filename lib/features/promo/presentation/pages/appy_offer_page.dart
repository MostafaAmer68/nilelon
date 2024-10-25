import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/tools.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/pop_ups/success_creation_popup.dart';
import 'package:nilelon/core/widgets/scaffold_image.dart';
import 'package:nilelon/features/promo/presentation/cubit/promo_cubit.dart';
import 'package:nilelon/features/layout/store_bottom_tab_bar.dart';

import '../../../../core/widgets/text_form_field/text_and_form_field_column/without_icon/text_and_form_field_column_no_icon.dart';

class ApplyOfferPage extends StatefulWidget {
  const ApplyOfferPage({super.key});

  @override
  State<ApplyOfferPage> createState() => _ApplyOfferPageState();
}

class _ApplyOfferPageState extends State<ApplyOfferPage> {
  late final PromoCubit cubit;
  @override
  void initState() {
    cubit = PromoCubit.get(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldImage(
      appBar: customAppBar(title: lang(context).applyOffer, context: context),
      body: BlocListener<PromoCubit, PromoState>(
        listener: (context, state) {
          if (state is PromoLoading) {
            BotToast.showLoading();
          } else if (state is PromoFailure) {
            BotToast.closeAllLoading();
            BotToast.showText(text: state.errMsg);
          } else {
            BotToast.closeAllLoading();
            successCreationDialog(
              context: context,
              highlightedText: lang(context).offerApplied,
              regularText: '',
              buttonText: lang(context).ok,
              ontap: () {
                navigateTo(
                  context: context,
                  screen: const StoreBottomTabBar(),
                );
              },
            );
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              child: TextAndFormFieldColumnNoIcon(
                title: lang(context).offerPercentage,
                label: lang(context).enterOfferPercentage,
                controller: cubit.amount,
                type: TextInputType.number,
              ),
            ),
            const Spacer(),
            GradientButtonBuilder(
              text: lang(context).apply,
              width: screenWidth(context, 0.9),
              ontap: () {
                cubit.craetePromo(context);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
