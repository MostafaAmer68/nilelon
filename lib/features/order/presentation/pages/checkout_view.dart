import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nilelon/features/order/presentation/cubit/order_cubit.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/features/order/presentation/progress_cubit/progress_cubit.dart';
import 'package:nilelon/features/order/presentation/widgets/ordered_success_step.dart';
import 'package:nilelon/features/order/presentation/widgets/overview_step.dart';
import 'package:nilelon/features/order/presentation/widgets/billing_details_step.dart';
import 'package:nilelon/features/order/presentation/widgets/payment_stemp.dart';
import 'package:nilelon/features/order/presentation/widgets/step_indicator.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/widgets/button/button_builder.dart';
import '../../../../core/widgets/button/gradient_button_builder.dart';
import '../../../../core/widgets/scaffold_image.dart';
import '../../../shared/pdf_view/pdf_view.dart';

class CheckOutView extends StatefulWidget {
  const CheckOutView({super.key});

  @override
  State<CheckOutView> createState() => _CheckOutViewState();
}

class _CheckOutViewState extends State<CheckOutView> {
  int index = 0;
  late final ProgressCubit cubit;
  late final OrderCubit orderCubit;
  @override
  void initState() {
    cubit = ProgressCubit.get(context);
    orderCubit = OrderCubit.get(context);

    cubit.resetPage();
    super.initState();
  }

  @override
  void dispose() {
    // orderCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    // cubit.previousStep();
    log(orderCubit.customerOrder.total.toString());
    return BlocListener<OrderCubit, OrderState>(
      listener: (context, state) {
        state.mapOrNull(success: (_) {
          setState(() {});
        });
      },
      child: ScaffoldImage(
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
                  ],
                );
              },
            ),
            Expanded(
              child: SizedBox(
                width: screenWidth(context, 1),
                height: screenHeight(context, 1),
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
            ),
          ],
        ),
        persistentFooterButtons: [
          cubit.state == 2
              ? NilelonPdfView(
                  location: orderCubit.customerOrder.governate,
                  orderDate: DateFormat('dd-MM-yyyy')
                      .format(orderCubit.customerOrder.date),
                  orderId: '#${orderCubit.customerOrder.id}',
                  cells: orderCubit.customerOrder.orderProductVariants
                      .map((e) => [
                            e.productName,
                            e.storeName,
                            e.quantity.toString(),
                            e.color,
                            e.size.toString(),
                            e.price.toString()
                          ])
                      .toList(),
                  netTotal: (orderCubit.customerOrder.total -
                          num.parse(orderCubit.customerOrder.shippingCost))
                      .toString(),
                  discount: orderCubit.customerOrder.discount.toString(),
                  total: (orderCubit.customerOrder.total +
                          num.parse(orderCubit.customerOrder.shippingCost))
                      .toString(),
                  delivery: orderCubit.customerOrder.shippingCost,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ButtonBuilder(
                      text: lang.previous,
                      buttonColor: cubit.state != 0
                          ? ColorManager.primaryB2
                          : ColorManager.primaryG2,
                      ontap: () {
                        if (cubit.state == 0) {
                        } else {
                          cubit.previousStep();
                          cubit.pageController.previousPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                          setState(() {});
                        }
                      },
                    ),
                    GradientButtonBuilder(
                      text: lang.continuePress,
                      ontap: () {
                        if (OrderCubit.get(context).formKey.currentState ==
                            null) {
                          cubit.nextStep();
                          cubit.pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                        } else {
                          if (OrderCubit.get(context)
                              .formKey
                              .currentState!
                              .validate()) {
                            OrderCubit.get(context).createOrder(context);
                          }
                        }
                        setState(() {});
                      },
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
