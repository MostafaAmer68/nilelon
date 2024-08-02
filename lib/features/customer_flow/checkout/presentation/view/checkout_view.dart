import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/features/customer_flow/checkout/presentation/cubit/checkout_cubit/checkout_cubit.dart';
import 'package:nilelon/features/customer_flow/checkout/presentation/cubit/progress_cubit/progress_cubit.dart';
import 'package:nilelon/features/customer_flow/checkout/presentation/widgets/page_1.dart';
import 'package:nilelon/features/customer_flow/checkout/presentation/widgets/page_2.dart';
import 'package:nilelon/features/customer_flow/checkout/presentation/widgets/page_3.dart';
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
                index = state;

                return Column(
                  children: [
                    Container(
                      color: ColorManager.primaryW,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: StepIndicator(totalSteps: 3, currentStep: state),
                      ),
                    ),
                    Container(
                      color: ColorManager.primaryW,
                      height: 16,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    index == 0
                        ? const Page1()
                        : index == 1
                            ? const Page2()
                            : const Page3(),
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
