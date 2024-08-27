import 'dart:developer';

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
import 'package:nilelon/core/widgets/text_form_field/text_field/text_form_field_builder.dart';
import 'package:nilelon/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:nilelon/features/customer_flow/checkout/presentation/cubit/progress_cubit/progress_cubit.dart';
import 'package:nilelon/features/customer_flow/order_details/widget/order_details_card.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  late GlobalKey<FormState> formKey;
  List<String> city = ['Cairo', 'Fayoum', 'Giza', 'Alexandria'];
  String? selectedCity;
  num totalPrice = 0;
  late final CartCubit cubit;
  @override
  void initState() {
    cubit = CartCubit.get(context);
    cubit.getCart();

    formKey = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final progressCubit = BlocProvider.of<ProgressCubit>(context);
    final lang = S.of(context);
    return Form(
      key: formKey,
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: ColorManager.primaryG17,
        child: Column(
          children: [
            SizedBox(
              height: 150,
              child: BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  return ListView.builder(
                    padding: const EdgeInsetsDirectional.symmetric(
                        vertical: 16, horizontal: 16),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: OrderDetailsCard(
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
                        controller: TextEditingController(),
                        type: TextInputType.text,
                        width: screenWidth(context, 0.65),
                        noIcon: false,
                        isIcon: false,
                        prefixWidget: const Icon(Iconsax.ticket_discount),
                      ),
                      const Spacer(),
                      ButtonBuilder(
                        text: lang.apply,
                        ontap: () {},
                        height: 54,
                        width: screenWidth(context, 0.24),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    lang.orderSummary,
                    style: AppStylesManager.customTextStyleBl8
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: screenWidth(context, 1),
                    height: 240,
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
                            if (totalPrice == 0) {
                              for (var item in CartCubit.get(context)
                                  .cartItems
                                  .result!
                                  .items!) {
                                totalPrice += item.price!;
                                log(item.price!.toString());
                              }
                            }
                          }
                          return orderSummaryItems(
                              lang.order, totalPrice.toString());
                        },
                      ),
                      const Divider(),
                      orderSummaryItemsWithDropList(
                          lang.delivery, '50 L.E', lang),
                      const Divider(),
                      orderSummaryItems(lang.total, '650 L.E'),
                    ]),
                  ),
                  const SizedBox(
                    height: 24,
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

  Padding orderSummaryItems(String title, String content) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppStylesManager.customTextStyleBl8
                .copyWith(fontWeight: FontWeight.w600),
          ),
          Text(
            content,
            style: AppStylesManager.customTextStyleBl8,
          )
        ],
      ),
    );
  }

  Padding orderSummaryItemsWithDropList(String title, String content, lang) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
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
          dropDownMenu(
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
              items: city,
              context: context,
              onChanged: (selectedValue) {
                selectedCity = selectedValue;
              }),
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
