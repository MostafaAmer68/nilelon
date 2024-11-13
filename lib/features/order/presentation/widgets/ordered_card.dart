import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/tools.dart';
import 'package:nilelon/features/order/data/models/order_model.dart';

class OrderCustomerCard extends StatelessWidget {
  const OrderCustomerCard({
    super.key,
    required this.order,
    required this.onTap,
    required this.icon,
    required this.name,
  });
  final OrderModel order;
  final Widget icon;
  final String name;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 1.sw > 600 ? 110 : 90,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
            Container(
              width: 50,
              height: 50,
              // padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFFECE7FF),
                shape: BoxShape.circle,
              ),
              child: icon,
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
                      name,
                      style: AppStylesManager.customTextStyleBl7,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          '${lang(context).orderPrice}: ',
                          style: AppStylesManager.customTextStyleB3,
                        ),
                        Text(
                          '${order.total} ${lang(context).le}',
                          style: AppStylesManager.customTextStyleO
                              .copyWith(fontSize: 1.sw > 600 ? 18 : 10),
                        ),
                        const Spacer(),
                        Text(
                          DateFormat('dd-MM-yyyy').format(
                            DateFormat(
                              'yyyy-MM-ddTHH:mm:ss.ssssss',
                            ).parse(order.date),
                          ),
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
