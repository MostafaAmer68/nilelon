import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/core/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/features/customer_flow/checkout/presentation/cubit/checkout_cubit/checkout_cubit.dart';
import 'package:nilelon/features/customer_flow/checkout/presentation/cubit/progress_cubit/progress_cubit.dart';
import 'package:nilelon/features/customer_flow/checkout/presentation/widgets/overview_step.dart';
import 'package:nilelon/features/customer_flow/checkout/presentation/widgets/payment_details_step.dart';
import 'package:nilelon/features/customer_flow/checkout/presentation/widgets/payment_stemp.dart';
import 'package:nilelon/features/customer_flow/checkout/presentation/widgets/step_indicator.dart';

class ChechOutView extends StatefulWidget {
  const ChechOutView({super.key});

  @override
  State<ChechOutView> createState() => _ChechOutViewState();
}

class _ChechOutViewState extends State<ChechOutView> {
  int index = 0;
  @override
  void initState() {
    CheckOutCubit.get(context);
    ProgressCubit.get(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Scaffold(
      backgroundColor: ColorManager.primaryG17,
      appBar:
          customAppBar(title: lang.checkOut, context: context, hasIcon: false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: ColorManager.primaryW,
              height: 16,
            ),
            BlocBuilder<ProgressCubit, int>(
              builder: (context, state) {
                return Column(
                  children: [
                    Container(
                      color: ColorManager.primaryW,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: StepIndicator(totalSteps: 2, currentStep: state),
                      ),
                    ),
                    Container(
                      color: ColorManager.primaryW,
                      height: 16,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                      height: screenHeight(context, 1.3),
                      child: PageView(
                        controller: ProgressCubit.get(context).pageController,
                        children: const [
                          Page1(),
                          Page2(),
                          Page3(),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
