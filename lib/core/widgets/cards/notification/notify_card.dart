import 'package:flutter/material.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/tools.dart';
import 'package:nilelon/features/notification/data/models/notification_data.dart';
import 'package:nilelon/features/product/presentation/pages/product_details_page.dart';
import 'package:svg_flutter/svg.dart';

import '../../../../features/notification/presentation/cubit/notification_cubit.dart';
import '../../../../features/order/presentation/pages/order_customer_details.dart';
import '../../../utils/navigation.dart';

class NotifyCard extends StatelessWidget {
  const NotifyCard({
    super.key,
    required this.image,
    required this.notify,
  });
  final String image;
  final NotificationData notify;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!notify.isRead) {
          NotificationCubit.get(context).markNotifyAsRead(notify.id);
        }
        switch (notify.type) {
          case 'Order':
            navigateTo(
                context: context,
                screen: OrderDetailsView(id: notify.targetId));
            break;
          case 'ProductRare':
            navigateTo(
              context: context,
              screen: ProductDetailsView(
                  size: notify.targetId.split(' ')[1],
                  color: notify.targetId.split(' ').last,
                  productId: notify.targetId.split(' ').first),
            );
            break;
          case 'Product':
            navigateTo(
              context: context,
              screen: ProductDetailsView(productId: notify.targetId),
            );
            break;
        }
      },
      child: Container(
        height: 100,
        width: screenWidth(context, 0.9),
        margin: EdgeInsets.symmetric(vertical: 10),
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
              clipBehavior: Clip.antiAliasWithSaveLayer,
              width: 70,
              height: 70,
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color(0xFFECE7FF),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(image, fit: BoxFit.cover),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          notify.message,
                          style: AppStylesManager.customTextStyleBl7,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                        ),
                        Visibility(
                          visible: !notify.isRead,
                          child: const CircleAvatar(
                            radius: 7,
                            backgroundColor: ColorManager.primaryO,
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    Text(
                      formatDate(notify.date),
                      style: AppStylesManager.customTextStyleG7,
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
