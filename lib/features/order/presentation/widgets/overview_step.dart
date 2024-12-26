import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/features/promo/presentation/cubit/promo_cubit.dart';
import 'package:nilelon/features/promo/presentation/widgets/txt_field_promo.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/font_weight_manger.dart';
import 'package:nilelon/core/widgets/drop_down_menu/drop_down_menu.dart';
import 'package:nilelon/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:nilelon/features/order/presentation/widgets/check_product_item.dart';
import 'package:nilelon/features/order/presentation/cubit/order_cubit.dart';

class OverViewStep extends StatefulWidget {
  const OverViewStep({super.key});

  @override
  State<OverViewStep> createState() => _OverViewStepState();
}

class _OverViewStepState extends State<OverViewStep> {
  late final CartCubit cartCubit;
  late final OrderCubit cubit;
  late final PromoCubit promoCubit;
  @override
  void initState() {
    cartCubit = CartCubit.get(context);
    cubit = OrderCubit.get(context);
    promoCubit = PromoCubit.get(context);
    if (cubit.shippingMethods.isEmpty) {
      cubit.getShippingMethod();
    }
    super.initState();
  }

  @override
  void dispose() {
    // cubit.selectedCity = '';

    // cubit.selectedShippingMethodId = '';

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: BlocListener<PromoCubit, PromoState>(
        listener: (context, state) {
          setState(() {});
          // TODO: implement listener
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 1.sw > 769 ? 170 : 150,
                child: ListView.builder(
                  padding: const EdgeInsetsDirectional.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: CheckProductItem(
                        cartItem: CartCubit.get(context).tempCartItems[index],
                      ),
                    );
                  },
                  itemCount: CartCubit.get(context).tempCartItems.length,
                  scrollDirection: Axis.horizontal,
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
                    const TxtFieldPromo(),
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
                      height: 1.sw > 769 ? 410 : 380,
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
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          BlocBuilder<CartCubit, CartState>(
                            builder: (context, state) {
                              if (state is GetCartSuccess) {
                                if (promoCubit.totalPrice == 0) {
                                  for (var item
                                      in CartCubit.get(context).tempCartItems) {
                                    promoCubit.totalPrice +=
                                        item.price * item.quantity;
                                    promoCubit.orderTotal +=
                                        item.price * item.quantity;
                                    promoCubit.tempTotalPrice +=
                                        item.price * item.quantity;
                                  }
                                }
                              }
                              return Column(
                                children: [
                                  BlocBuilder<OrderCubit, OrderState>(
                                    builder: (context, state) {
                                      return orderSummaryItems(lang.order,
                                          (promoCubit.orderTotal).toString());
                                    },
                                  ),
                                  // BlocBuilder<OrderCubit, OrderState>(
                                  //   builder: (context, state) {
                                  //     return orderDeliveryDetails(
                                  //         lang.estimatedDelivery, lang);
                                  //   },
                                  // ),
                                  BlocBuilder<OrderCubit, OrderState>(
                                    builder: (context, state) {
                                      return orderSummaryItemsWithDropList(
                                          lang.delivery,
                                          '${promoCubit.deliveryPrice} ${lang.le}',
                                          lang);
                                    },
                                  ),
                                  BlocBuilder<OrderCubit, OrderState>(
                                    builder: (context, state) {
                                      return orderSummaryItems(
                                        lang.discount,
                                        '${(promoCubit.discount * 100).toStringAsFixed(0)} %',
                                      );
                                    },
                                  ),
                                  BlocBuilder<OrderCubit, OrderState>(
                                    builder: (context, state) {
                                      return orderSummaryItems(
                                          lang.total,
                                          '${promoCubit.totalPrice} ${lang.le}',
                                          AppStylesManager.customTextStyleO5
                                              .copyWith(
                                                  fontWeight: FontWeight.w600));
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              ),
            ],
          ),
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
      child: promoCubit.isFreeShipping
          ? Text(lang.freeShipping)
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
                          width: screenWidth(context, 0.2),
                          // height: screenWidth(context, 0.),
                          hint: lang.city,
                          style: AppStylesManager.customTextStyleBl.copyWith(
                            fontSize: 8,
                            fontWeight: FontWeightManager.regular400,
                          ),
                          style2: AppStylesManager.customTextStyleBl.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeightManager.regular400,
                          ),
                          selectedValue: cubit.selectedCity,
                          items: cubit.shippingMethods.first.shippingCosts
                              .map((e) => e.governate)
                              .toList(),
                          context: context,
                          // menuMaxHeight: 30,
                          onChanged: (selectedValue) {
                            cubit.selectedCity = cubit
                                .shippingMethods.first.shippingCosts
                                .firstWhere(
                                    (e) => e.governate == selectedValue!)
                                .governate;
                            final newDeliveryPrice = cubit
                                .shippingMethods.first.shippingCosts
                                .firstWhere((e) => e.governate == selectedValue)
                                .price;
                            if (newDeliveryPrice != promoCubit.deliveryPrice) {
                              promoCubit.selectedGov = selectedValue!;
                              promoCubit.totalPrice = promoCubit.totalPrice -
                                  promoCubit.deliveryPrice;
                              promoCubit.deliveryPrice = newDeliveryPrice;

                              if (promoCubit.newPrice == 0) {
                                promoCubit.totalPrice =
                                    promoCubit.deliveryPrice +
                                        promoCubit.totalPrice;
                              } else {
                                promoCubit.totalPrice =
                                    promoCubit.deliveryPrice +
                                        promoCubit.newPrice;
                              }
                              OrderCubit.get(context).selectedShippingMethodId =
                                  cubit.shippingMethods.first.id;
                              OrderCubit.get(context).selectedGovernate = cubit
                                  .shippingMethods.first.shippingCosts
                                  .firstWhere(
                                      (e) => e.governate == selectedValue)
                                  .governate;
                              setState(() {});
                            }
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

  // Padding orderDeliveryDetails(String title, lang) {
  //   return Padding(
  //     padding: const EdgeInsets.all(16.0),
  //     child: promoCubit.isFreeShipping
  //         ? Text(lang.freeShipping)
  //         : Row(
  //             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Text(
  //                 title,
  //                 style: AppStylesManager.customTextStyleBl8
  //                     .copyWith(fontWeight: FontWeight.w600),
  //               ),
  //               const SizedBox(
  //                 width: 8,
  //               ),
  //               BlocBuilder<OrderCubit, OrderState>(
  //                 builder: (context, state) {
  //                   return state.maybeWhen(orElse: () {
  //                     return const SizedBox();
  //                   }, loading: () {
  //                     return const Center(child: CircularProgressIndicator());
  //                   }, success: () {
  //                     if (OrderCubit.get(context).shippingMethods.isEmpty) {
  //                       return const Icon(Icons.error);
  //                     }

  //                     return dropDownMenu(
  //                         width: screenWidth(context, 0.2),
  //                         // height: screenWidth(context, 0.),
  //                         hint: lang.city,
  //                         style: AppStylesManager.customTextStyleBl.copyWith(
  //                           fontSize: 8,
  //                           fontWeight: FontWeightManager.regular400,
  //                         ),
  //                         style2: AppStylesManager.customTextStyleBl.copyWith(
  //                           fontSize: 10,
  //                           fontWeight: FontWeightManager.regular400,
  //                         ),
  //                         selectedValue: cubit.selectedShippingMethod.name,
  //                         items: OrderCubit.get(context)
  //                             .shippingMethods
  //                             .map((e) => e.name)
  //                             .toList(),
  //                         context: context,
  //                         // menuMaxHeight: 30,
  //                         onChanged: (selectedValue) {
  //                           cubit.selectedShippingMethod = cubit.shippingMethods
  //                               .firstWhere((e) => e.name == selectedValue!);
  //                           cubit.selectedCity = cubit
  //                               .selectedShippingMethod.shippingCosts.first;
  //                           setState(() {});
  //                         });
  //                   });
  //                 },
  //               ),
  //               const Spacer(),
  //               Text(
  //                 cubit.selectedShippingMethod.estimatedDelivery,
  //                 style: AppStylesManager.customTextStyleBl8,
  //               )
  //             ],
  //           ),
  //   );
  // }
}
