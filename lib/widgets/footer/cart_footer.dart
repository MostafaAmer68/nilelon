import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/resources/const_functions.dart';
import 'package:nilelon/resources/appstyles_manager.dart';
import 'package:nilelon/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/features/customer_flow/checkout/presentation/cubit/checkout_cubit/checkout_cubit.dart';
import 'package:nilelon/features/customer_flow/checkout/presentation/cubit/progress_cubit/progress_cubit.dart';
import 'package:nilelon/features/customer_flow/checkout/presentation/view/checkout_view.dart';

class CartFooter extends StatelessWidget {
  const CartFooter({super.key, this.visible = true});
  final bool visible;
  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    return Visibility(
      visible: visible,
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
                  '700 L.E',
                  style: AppStylesManager.customTextStyleO5,
                )
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            SizedBox(
              width: screenWidth(context, 1),
              child: GradientButtonBuilder(
                text: lang.checkOut,
                ontap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BlocProvider<ProgressCubit>(
                        create: (context) => ProgressCubit(),
                        child: BlocProvider<CheckOutCubit>(
                          create: (context) => CheckOutCubit(),
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
