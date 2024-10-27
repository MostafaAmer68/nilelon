import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/features/order/presentation/progress_cubit/progress_cubit.dart';
import 'package:nilelon/features/order/presentation/widgets/ordered_success_step.dart';
import 'package:nilelon/features/order/presentation/widgets/overview_step.dart';
import 'package:nilelon/features/order/presentation/widgets/billing_details_step.dart';
import 'package:nilelon/features/order/presentation/widgets/payment_stemp.dart';
import 'package:nilelon/features/order/presentation/widgets/step_indicator.dart';

import '../../../../core/widgets/scaffold_image.dart';

class CheckOutView extends StatefulWidget {
  const CheckOutView({super.key});

  @override
  State<CheckOutView> createState() => _CheckOutViewState();
}

class _CheckOutViewState extends State<CheckOutView> {
  int index = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return ScaffoldImage(
      appBar: customAppBar(
        title: lang.checkOut,
        context: context,
        hasIcon: false,
      ),
      body: Column(
        children: [
          BlocBuilder<ProgressCubit, int>(
            builder: (context, state) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: StepIndicator(totalSteps: 3, currentStep: state),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    height: screenHeight(context, 0.78),
                    child: PageView(
                      controller: ProgressCubit.get(context).pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: const [
                        OverViewStep(),
                        BillingDetailsStep(),
                        OrderedSuccessPage(),
                        PaymentPage(),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
