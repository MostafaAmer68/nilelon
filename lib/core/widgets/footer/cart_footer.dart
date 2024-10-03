import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/core/service/set_up_locator_service.dart';
import 'package:nilelon/features/cart/domain/model/get_cart_model/cart_item.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/features/checkout/presentation/cubit/checkout_cubit/checkout_cubit.dart';
import 'package:nilelon/features/checkout/presentation/cubit/progress_cubit/progress_cubit.dart';
import 'package:nilelon/features/checkout/presentation/view/checkout_view.dart';
import 'package:nilelon/features/order/data/repositories/order_repo_impl.dart';

class CartFooter extends StatefulWidget {
  const CartFooter({super.key, this.visible = true, required this.cartModel});
  final bool visible;
  final List<CartItem> cartModel;

  @override
  State<CartFooter> createState() => _CartFooterState();
}

class _CartFooterState extends State<CartFooter> {
  num totalPrice = 0;
  @override
  void initState() {
    for (var item in widget.cartModel) {
      totalPrice += item.price!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    return Visibility(
      visible: widget.visible,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  lang.totalPrice,
                  style: AppStylesManager.customTextStyleB5,
                ),
                Text(
                  '$totalPrice L.E',
                  style: AppStylesManager.customTextStyleO5,
                )
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            SizedBox(
              width: screenWidth(context, 0.9),
              child: GradientButtonBuilder(
                text: lang.checkOut,
                ontap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BlocProvider<ProgressCubit>(
                        create: (context) => ProgressCubit(),
                        child: BlocProvider<CheckOutCubit>(
                          create: (context) =>
                              CheckOutCubit(locatorService<OrderRepoImpl>()),
                          child: const ChechOutView(),
                        ),
                      ),
                    ),
                  );
                },
                width: screenWidth(context, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
