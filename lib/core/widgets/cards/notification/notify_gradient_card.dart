import 'package:flutter/material.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/tools.dart';
import 'package:nilelon/features/notification/data/models/notification_data.dart';
import 'package:nilelon/features/order/presentation/pages/order_store_details_view.dart';

import '../../../utils/navigation.dart';

class NotifyGradientCard extends StatelessWidget {
  const NotifyGradientCard({
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
        switch (notify.type) {
          case 'Order':
            navigateTo(
                context: context,
                screen: OrderStoreDetailsView(id: notify.targetId, index: 0));
            break;
          // case 'ProductRare':
          //   navigateTo(
          //     context: context,
          //     screen: ProductDetailsView(
          //         size: notify.targetId.split(' ')[1],
          //         color: notify.targetId.split(' ').last,
          //         productId: notify.targetId.split(' ').first),
          //   );
          //   break;
          // case 'Product':
          //   navigateTo(
          //     context: context,
          //     screen: ProductDetailsView(productId: notify.targetId),
          //   );
          //   break;
        }
      },
      child: SizedBox(
        width: screenWidth(context, 0.9),
        child: Stack(
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: ColorManager.gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
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
            ),
            Positioned.fill(
              child: Container(
                clipBehavior: Clip.antiAlias,
                height: 100,
                margin: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: ColorManager.primaryG10,
                  borderRadius: BorderRadius.circular(12),
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
                      child: Image.asset(image, fit: BoxFit.cover),
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
                              notify.message,
                              style: AppStylesManager.customTextStyleBl7,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 4,
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
            ),
          ],
        ),
      ),
    );
  }
}
