import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/features/customer_flow/order_details/order_details_view.dart';
import 'package:nilelon/features/order/data/models/order_model.dart';

class RecievedCard extends StatelessWidget {
  const RecievedCard({
    super.key,
    required this.order,
  });
  final OrderModel order;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(
            context: context,
            screen: const OrderDetailsView(
              index: 2,
              recievedDate: '14/5/2024',
            ));
      },
      child: Container(
        height: 1.sw > 600 ? 110 : 90,
        width: screenWidth(context, 0.9),
        decoration: BoxDecoration(
          color: ColorManager.primaryG10,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: ColorManager.primaryG6,
              blurRadius: 10,
              offset: Offset(0, 2),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 16,
            ),
            Container(
              width: 70,
              height: 70,
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFFECE7FF),
                shape: BoxShape.circle,
              ),
              child: Image.asset('assets/images/arrived2.png'),
            ),
            const SizedBox(
              width: 4,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Your package has arrived at your destination',
                      style: AppStylesManager.customTextStyleBl7,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          'Order Price: ',
                          style: AppStylesManager.customTextStyleB3,
                        ),
                        Text(
                          '${order.total} L.E',
                          style: AppStylesManager.customTextStyleO
                              .copyWith(fontSize: 1.sw > 600 ? 18 : 10),
                        ),
                        const Spacer(),
                        Text(
                          order.date,
                          style: AppStylesManager.customTextStyleG7,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
          ],
        ),
      ),
    );
  }
}
