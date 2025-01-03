import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nilelon/core/color_const.dart';
import 'package:nilelon/features/order/presentation/cubit/order_cubit.dart';
import 'package:nilelon/features/promo/presentation/cubit/promo_cubit.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/features/order/presentation/progress_cubit/progress_cubit.dart';
import 'package:nilelon/features/order/presentation/widgets/ordered_success_step.dart';
import 'package:nilelon/features/order/presentation/widgets/overview_step.dart';
import 'package:nilelon/features/order/presentation/widgets/billing_details_step.dart';
import 'package:nilelon/features/order/presentation/widgets/step_indicator.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/widgets/button/button_builder.dart';
import '../../../../core/widgets/button/gradient_button_builder.dart';
import '../../../../core/widgets/scaffold_image.dart';
import '../../../shared/pdf_view/pdf_view.dart';

class CheckOutView extends StatefulWidget {
  const CheckOutView({super.key, this.isBuNow = false});
  final bool isBuNow;
  @override
  State<CheckOutView> createState() => _CheckOutViewState();
}

class _CheckOutViewState extends State<CheckOutView> {
  int index = 0;
  late final ProgressCubit cubit;
  late final OrderCubit orderCubit;

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    cubit = ProgressCubit.get(context);
    orderCubit = OrderCubit.get(context);
    if (!widget.isBuNow) {
      PromoCubit.get(context).deliveryPrice = 0;
      PromoCubit.get(context).totalPrice = 0;
      PromoCubit.get(context).orderTotal = 0;
      PromoCubit.get(context).discount = 0;
      PromoCubit.get(context).newPrice = 0;
      PromoCubit.get(context).tempTotalPrice = 0;
    }
    cubit.resetPage();
    super.initState();
  }

  @override
  void dispose() {
    PromoCubit.get(context).deliveryPrice = 0;
    PromoCubit.get(context).totalPrice = 0;
    PromoCubit.get(context).tempTotalPrice = 0;
    super.dispose();
  }

  num price = 0;
  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    // cubit.previousStep();
    // BotToast.closeAllLoading();
    price = 0;
    for (var item in orderCubit.customerOrder.orderProductVariants) {
      price += item.price * item.quantity;
    }
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
                    // PaymentPage(),
                  ],
                ),
              ),
            ),
          ],
        ),
        btmBar: cubit.state == 2
            ? Container(
                height: 130,
                color: ColorManager.primaryW,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                child: NilelonPdfView(
                  location: orderCubit.customerOrder.governate,
                  orderDate: DateFormat('dd-MM-yyyy')
                      .format(orderCubit.customerOrder.date),
                  orderId: '#${orderCubit.customerOrder.id}',
                  cells: orderCubit.customerOrder.orderProductVariants
                      .map((e) => [
                            e.productName,
                            e.storeName,
                            e.quantity.toString(),
                            colroName['0x${e.color.toUpperCase()}']!,
                            e.size.toString(),
                            e.price.toString()
                          ])
                      .toList(),
                  netTotal: price.toString(),
                  discount: orderCubit.customerOrder.discount.toString(),
                  total: (orderCubit.customerOrder.total).toString(),
                  delivery: orderCubit.customerOrder.shippingCost,
                ),
              )
            : Container(
                height: 100,
                color: ColorManager.primaryW,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonBuilder(
                      text: lang.previous,
                      buttonColor: cubit.state != 0
                          ? ColorManager.primaryB2
                          : ColorManager.primaryG2,
                      frameColor: Colors.transparent,
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
                        // cubit.pageController.nextPage(
                        //     duration: const Duration(milliseconds: 500),
                        //     curve: Curves.easeInOut);
                        if (OrderCubit.get(context).formKey.currentState ==
                            null) {
                          if (PromoCubit.get(context).selectedGov.isNotEmpty) {
                            cubit.nextStep();
                            cubit.pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
                          } else {
                            BotToast.showText(text: 'Please Select City');
                          }
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
              ),
      ),
    );
  }
}
