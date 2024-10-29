import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/features/order/presentation/pages/checkout_view.dart';

class CartFooter extends StatefulWidget {
  const CartFooter({
    super.key,
    this.visible = true,
  });
  final bool visible;

  @override
  State<CartFooter> createState() => _CartFooterState();
}

class _CartFooterState extends State<CartFooter> {
  num totalPrice = 0;

  late final CartCubit cubit;
  @override
  void initState() {
    cubit = CartCubit.get(context);
    for (var item in cubit.tempCartItems) {
      totalPrice += item.price * item.quantity;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    return Visibility(
      visible: widget.visible,
      child: BlocListener<CartCubit, CartState>(
        listener: (context, state) {
          if (state is GetCartSuccess) {
            totalPrice = 0;
            for (var item in cubit.tempCartItems) {
              totalPrice += item.price * item.quantity;
            }
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: ColorManager.primaryW,
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      lang.totalPrice,
                      style: AppStylesManager.customTextStyleB5,
                    ),
                    // const SizedBox(width: 50),
                    BlocBuilder<CartCubit, CartState>(
                      builder: (context, state) {
                        return state is UpdateQuantityCartLoading
                            ? const CircularProgressIndicator()
                            : Text(
                                '$totalPrice ${lang.le}',
                                style: AppStylesManager.customTextStyleO5,
                              );
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              SizedBox(
                width: screenWidth(context, 0.9),
                child: GradientButtonBuilder(
                  text: lang.checkOut,
                  ontap: () {
                    if (cubit.tempCartItems.isNotEmpty) {
                      navigateTo(
                          context: context, screen: const CheckOutView());
                    } else {
                      BotToast.showText(text: lang.youMustSelectOneProduct);
                    }
                  },
                  width: screenWidth(context, 1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
