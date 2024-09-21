import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/core/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/font_weight_manger.dart';
import 'package:nilelon/core/widgets/button/button_builder.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/core/widgets/drop_down_menu/drop_down_menu.dart';
import 'package:nilelon/core/widgets/shimmer_indicator/build_shimmer.dart';
import 'package:nilelon/core/widgets/text_form_field/text_field/text_form_field_builder.dart';
import 'package:nilelon/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:nilelon/features/customer_flow/checkout/presentation/cubit/checkout_cubit/checkout_cubit.dart';
import 'package:nilelon/features/customer_flow/checkout/presentation/cubit/progress_cubit/progress_cubit.dart';
import 'package:nilelon/features/customer_flow/checkout/presentation/widgets/check_product_item.dart';
import 'package:nilelon/features/order/presentation/widgets/order_product_item.dart';
import 'package:nilelon/features/order/presentation/cubit/order_cubit.dart';

class OverViewStep extends StatefulWidget {
  const OverViewStep({super.key});

  @override
  State<OverViewStep> createState() => _OverViewStepState();
}

class _OverViewStepState extends State<OverViewStep> {
  late GlobalKey<FormState> formKey;
  String selectedCity = 'Cairo';
  late final CartCubit cubit;
  @override
  void initState() {
    cubit = CartCubit.get(context);
    cubit.getCart();
    OrderCubit.get(context).getShippingMethod();
    selectedCity = OrderCubit.get(context).shippingMethods.first.name;
    formKey = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final progressCubit = BlocProvider.of<ProgressCubit>(context);
    final lang = S.of(context);
    return Form(
      key: formKey,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        // color: ColorManager.primaryG17,
        child: Column(
          children: [
            SizedBox(
              height: 150,
              child: BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  if (state is CartLoading) {
                    return buildShimmerIndicatorSmall();
                  }
                  return ListView.builder(
                    padding: const EdgeInsetsDirectional.symmetric(
                        vertical: 16, horizontal: 16),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: CheckProductItem(
                            cartItem: CartCubit.get(context)
                                .cartItems
                                .result!
                                .items![index]),
                      );
                    },
                    itemCount: cubit.cartItems.result!.items!.length,
                    scrollDirection: Axis.horizontal,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      TextFormFieldBuilder(
                        label: lang.promoCode,
                        controller: CheckOutCubit.get(context).promoCode,
                        type: TextInputType.text,
                        width: screenWidth(context, 0.65),
                        noIcon: false,
                        isIcon: false,
                        prefixWidget: const Icon(Iconsax.ticket_discount),
                      ),
                      const Spacer(),
                      BlocConsumer<CheckOutCubit, CheckOutState>(
                        listener: (context, state) {
                          if (state is CheckOutFailure) {
                            BotToast.showText(text: 'Promocode invalid');
                          }
                          if (state is CheckOutSuccess) {
                            BotToast.showText(text: 'Promocode applied');
                          }
                        },
                        builder: (context, state) => state is CheckOutLoading
                            ? const Center(child: CircularProgressIndicator())
                            : ButtonBuilder(
                                text: lang.apply,
                                ontap: () {
                                  CheckOutCubit.get(context)
                                      .getPromoCodeType(context);
                                },
                                height: 54,
                                width: screenWidth(context, 0.24),
                              ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    lang.orderSummary,
                    style: AppStylesManager.customTextStyleBl8
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: screenWidth(context, 1),
                    height: 320,
                    decoration: ShapeDecoration(
                      color: ColorManager.primaryW,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: ColorManager.primaryBL4,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Column(children: [
                      const SizedBox(
                        height: 16,
                      ),
                      BlocBuilder<CartCubit, CartState>(
                        builder: (context, state) {
                          if (state is GetCartSuccess) {
                            if (CheckOutCubit.get(context).totalPrice == 0) {
                              for (var item in CartCubit.get(context)
                                  .cartItems
                                  .result!
                                  .items!) {
                                CheckOutCubit.get(context).totalPrice +=
                                    item.price!;
                              }
                            }
                          }
                          return Column(
                            children: [
                              BlocBuilder<CheckOutCubit, CheckOutState>(
                                builder: (context, state) {
                                  return orderSummaryItems(
                                      lang.order,
                                      CheckOutCubit.get(context)
                                          .totalPrice
                                          .toString());
                                },
                              ),
                              const Divider(),
                              BlocBuilder<CheckOutCubit, CheckOutState>(
                                builder: (context, state) {
                                  return orderSummaryItemsWithDropList(
                                      lang.delivery,
                                      '${CheckOutCubit.get(context).deliveryPrice} L.E',
                                      lang);
                                },
                              ),
                              const Divider(),
                              BlocBuilder<CheckOutCubit, CheckOutState>(
                                builder: (context, state) {
                                  return orderSummaryItems(
                                    'Discount',
                                    '${CheckOutCubit.get(context).discount} L.E',
                                  );
                                },
                              ),
                              const Divider(),
                              BlocBuilder<CheckOutCubit, CheckOutState>(
                                builder: (context, state) {
                                  return orderSummaryItems(
                                      lang.total,
                                      '${CheckOutCubit.get(context).totalPrice} L.E',
                                      AppStylesManager.customTextStyleO5
                                          .copyWith(
                                              fontWeight: FontWeight.w600));
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ]),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonBuilder(
                        text: lang.previous,
                        buttonColor: ColorManager.primaryG2,
                        ontap: () {
                          progressCubit.pageController.previousPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                        },
                      ),
                      GradientButtonBuilder(
                          text: lang.continuePress,
                          ontap: () {
                            if (formKey.currentState!.validate()) {
                              progressCubit.pageController.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                            }
                          })
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding orderSummaryItems(String title, String content,
      [TextStyle? customStyle]) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: customStyle ??
                AppStylesManager.customTextStyleBl8
                    .copyWith(fontWeight: FontWeight.w600),
          ),
          Text(
            content,
            style: customStyle ?? AppStylesManager.customTextStyleBl8,
          )
        ],
      ),
    );
  }

  Padding orderSummaryItemsWithDropList(String title, String content, lang) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: CheckOutCubit.get(context).isFreeShipping
          ? const Text('Free Shipping')
          : Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppStylesManager.customTextStyleBl8
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  width: 8,
                ),
                BlocBuilder<OrderCubit, OrderState>(
                  builder: (context, state) {
                    return state.maybeWhen(orElse: () {
                      return const SizedBox();
                    }, loading: () {
                      return const Center(child: CircularProgressIndicator());
                    }, success: () {
                      if (OrderCubit.get(context).shippingMethods.isEmpty) {
                        return const Icon(Icons.error);
                      }
                      return dropDownMenu(
                          width: screenWidth(context, 0.3),
                          height: screenWidth(context, 0.11),
                          hint: lang.city,
                          style: AppStylesManager.customTextStyleBl.copyWith(
                            fontSize: 8,
                            fontWeight: FontWeightManager.regular400,
                          ),
                          style2: AppStylesManager.customTextStyleBl.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeightManager.regular400,
                          ),
                          selectedValue: selectedCity,
                          items: OrderCubit.get(context)
                              .shippingMethods
                              .first
                              .shippingCosts
                              .map((e) => e.governate)
                              .toList(),
                          context: context,
                          onChanged: (selectedValue) {
                            selectedCity = selectedValue ?? '';
                            CheckOutCubit.get(context).deliveryPrice =
                                OrderCubit.get(context)
                                    .shippingMethods
                                    .first
                                    .shippingCosts
                                    .firstWhere(
                                        (e) => e.governate == selectedValue)
                                    .price;
                            CheckOutCubit.get(context).totalPrice +=
                                CheckOutCubit.get(context).deliveryPrice;
                            CheckOutCubit.get(context)
                                    .selectedShippingMethodId =
                                OrderCubit.get(context)
                                    .shippingMethods
                                    .first
                                    .id;
                            CheckOutCubit.get(context).selectedGovernate =
                                OrderCubit.get(context)
                                    .shippingMethods
                                    .first
                                    .shippingCosts
                                    .firstWhere(
                                        (e) => e.governate == selectedValue)
                                    .governate;
                            setState(() {});
                          });
                    });
                  },
                ),
                const Spacer(),
                Text(
                  content,
                  style: AppStylesManager.customTextStyleBl8,
                )
              ],
            ),
    );
  }
}
