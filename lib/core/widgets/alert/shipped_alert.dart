import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/button/button_builder.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/features/order/data/models/order_model.dart';
import 'package:nilelon/features/order/presentation/cubit/order_cubit.dart';

Future shippedAlert(context, OrderModel order) => showDialog(
    context: context,
    builder: (BuildContext context) {
      final lang = S.of(context);

      return AlertDialog(
        content: SizedBox(
          height: 90.h,
          child: Column(
            children: [
              SizedBox(
                height: 24.h,
              ),
              Text(
                'Are you sure your Order 48031 is  shipped ?',
                style: AppStylesManager.customTextStyleBl8,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ButtonBuilder(
                  text: lang.no,
                  width: screenWidth(context, 0.32),
                  height: screenHeight(context, 0.06),
                  buttonColor: Colors.transparent,
                  frameColor: ColorManager.primaryB2,
                  style: AppStylesManager.customTextStyleB4,
                  ontap: () {
                    navigatePop(context: context);
                  }),
              SizedBox(
                width: 12.w,
              ),
              GradientButtonBuilder(
                  text: lang.yes,
                  width: screenWidth(context, 0.32),
                  height: screenHeight(context, 0.06),
                  ontap: () {
                    navigatePop(context: context);
                    OrderCubit.get(context)
                        .changeOrderStatus(order.id, 'Shipped');
                  }),
            ],
          ),
        ],
      );
    });
