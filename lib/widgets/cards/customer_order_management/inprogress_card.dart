import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/resources/const_functions.dart';
import 'package:nilelon/resources/appstyles_manager.dart';
import 'package:nilelon/utils/navigation.dart';
import 'package:nilelon/features/customer_flow/order_details/order_details_view.dart';
import 'package:svg_flutter/svg.dart';

class InProgressCard extends StatelessWidget {
  const InProgressCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(
            context: context,
            screen: const OrderDetailsView(
              index: 0,
              recievedDate: '',
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
              child: SvgPicture.asset('assets/images/package accept.svg'),
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
                      'Your package is being delivered by courier',
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
                          '370 L.E',
                          style: AppStylesManager.customTextStyleO
                              .copyWith(fontSize: 1.sw > 600 ? 18 : 10),
                        ),
                        const Spacer(),
                        Text(
                          '11:56 AM',
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
