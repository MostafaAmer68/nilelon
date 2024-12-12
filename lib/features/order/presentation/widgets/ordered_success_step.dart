import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/constants/assets.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/widgets/scaffold_image.dart';
import 'package:nilelon/features/order/presentation/cubit/order_cubit.dart';
import 'package:nilelon/features/promo/presentation/cubit/promo_cubit.dart';
import 'package:nilelon/generated/l10n.dart';

import '../../../../core/resources/appstyles_manager.dart';

class OrderedSuccessPage extends StatefulWidget {
  const OrderedSuccessPage({super.key});

  @override
  State<OrderedSuccessPage> createState() => _OrderedSuccessPageState();
}

class _OrderedSuccessPageState extends State<OrderedSuccessPage> {
  late final OrderCubit cubit;
  @override
  void initState() {
    cubit = OrderCubit.get(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // BotToast.closeAllLoading();
    return ScaffoldImage(
      body: BlocListener<OrderCubit, OrderState>(
        listener: (context, state) {
          state.mapOrNull(success: (_) {
            PromoCubit.get(context).isFreeShipping = false;
            PromoCubit.get(context).discount = 0;
            PromoCubit.get(context).totalPrice = 0;
            PromoCubit.get(context).tempTotalPrice = 0;
            PromoCubit.get(context).newPrice = 0;
            PromoCubit.get(context).discount = 0;
            PromoCubit.get(context).discount = 0;

            BotToast.closeAllLoading();
          });
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Image.asset(
                  Assets.assetsImagesInvoice,
                  width: screenWidth(context, 0.5),
                ),
                const SizedBox(height: 20),
                Text(
                  S.of(context).thankYouForOrdering,
                  style: AppStylesManager.customTextStyleBl13
                      .copyWith(fontSize: 25.sp, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  S.of(context).youCanDownloadYourReceiptToViewYourOrderDetails,
                  style: AppStylesManager.customTextStyleG,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 150),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
