import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/core/widgets/replacer/image_replacer.dart';
import 'package:nilelon/features/cart/domain/model/cart_item.dart';
import 'package:nilelon/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/widgets/button/small_button.dart';

import '../../../product/presentation/pages/product_details_page.dart';
import '../../../../core/utils/navigation.dart';

class CartItemCard extends StatefulWidget {
  const CartItemCard({
    super.key,
    required this.cart,
  });
  final CartItem cart;
  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  int localCounter = 1;
  bool isEnabled = true;
  @override
  void initState() {
    localCounter = widget.cart.quantity;
    super.initState();
  }

  void incrementCounter() {
    setState(() {
      localCounter++;
    });
  }

  void decrementCounter() {
    setState(() {
      localCounter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            navigateTo(
                context: context,
                screen: ProductDetailsView(
                  productId: widget.cart.productId,
                ));
          },
          child: SizedBox(
            width: screenWidth(context, 0.9),
            child: Container(
              clipBehavior: Clip.antiAlias,
              // height: 1.sw > 600 ? 160 : 1,
              margin: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: ColorManager.primaryG6,
                    blurRadius: 10,
                    offset: Offset(0, 2),
                    spreadRadius: 0,
                  )
                ],
                color: ColorManager.primaryW,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 12,
                  ),
                  SizedBox(
                    width: 1.sw > 600 ? 110 : 100,
                    height: 1.sw > 600 ? 130 : 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: imageReplacer(
                        url: widget.cart.productImages.isEmpty
                            ? ''
                            : widget.cart.productImages.first.url,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.cart.productName,
                                  style: AppStylesManager.customTextStyleBl7
                                      .copyWith(
                                    fontSize: 1.sw > 600 ? 22 : 14,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Checkbox(
                                splashRadius: 1.sw > 600 ? 20 : 12,
                                value: isEnabled,
                                activeColor: ColorManager.primaryO,
                                onChanged: (value) {
                                  isEnabled = value!;
                                  CartCubit.get(context)
                                      .onSelectedItem(value, widget.cart);
                                  log(
                                      CartCubit.get(context)
                                          .tempCartItems
                                          .length
                                          .toString(),
                                      name: 'temp cart');
                                  log(
                                      CartCubit.get(context)
                                          .cart1
                                          .items
                                          .length
                                          .toString(),
                                      name: 'cart1 cart');
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                          Text(
                            '${lang.size} ${widget.cart.size}',
                            style: AppStylesManager.customTextStyleG5,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${widget.cart.price * localCounter} ${lang.le}',
                                style: AppStylesManager.customTextStyleO2,
                              ),
                              const Spacer(),
                              BlocListener<CartCubit, CartState>(
                                listener: (context, state) {
                                  if (state is UpdateQuantityCartFailure) {
                                    incrementCounter();
                                  }
                                },
                                child: localCounter == 1
                                    ? SmallButton(
                                        icon: Iconsax.minus,
                                        color: ColorManager.primaryG3,
                                        onTap: () {},
                                      )
                                    : SmallButton(
                                        icon: Iconsax.minus,
                                        onTap: () {
                                          decrementCounter();
                                          CartCubit.get(context)
                                              .updateQuantityCart(widget.cart
                                                  .copyWith(
                                                      quantity: localCounter));
                                        },
                                      ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(localCounter.toString()),
                              const SizedBox(
                                width: 8,
                              ),
                              BlocListener<CartCubit, CartState>(
                                listener: (context, state) {
                                  if (state is UpdateQuantityCartFailure) {
                                    decrementCounter();
                                  }
                                },
                                child: SmallButton(
                                  icon: Iconsax.add,
                                  onTap: () {
                                    incrementCounter();
                                    CartCubit.get(context).updateQuantityCart(
                                        widget.cart
                                            .copyWith(quantity: localCounter));
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  // const SizedBox(
                  //   width: 12,
                  // ),
                ],
              ),
            ),
          ),
        ),
        // const SizedBox(
        //   height: 12,
        // )
      ],
    );
  }
}
