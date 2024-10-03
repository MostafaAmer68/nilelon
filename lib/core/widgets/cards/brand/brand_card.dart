import 'package:flutter/material.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/core/widgets/button/outlined_button_builder.dart';
import 'package:nilelon/features/profile/data/models/store_profile.dart';

import '../../../../features/profile/presentation/pages/store_profile_customer.dart';
import '../../../utils/navigation.dart';

class BrandCard extends StatefulWidget {
  const BrandCard({
    super.key,
    required this.store,
  });
  final StoreProfileModel store;

  @override
  State<BrandCard> createState() => _BrandCardState();
}

class _BrandCardState extends State<BrandCard> {
  bool notFollowing = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(
            context: context,
            screen: StoreProfileCustomer(
              storeId: widget.store.id,
            ));
      },
      child: Container(
        width: screenWidth(context, 0.45),
        height: 200,
        padding:
            const EdgeInsets.only(top: 24, bottom: 12, left: 12, right: 12),
        decoration: BoxDecoration(
          color: ColorManager.primaryB5,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Container(
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x33726363),
                    blurRadius: 16,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(widget.store.profilePic ?? ''),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              widget.store.name,
              style: AppStylesManager.customTextStyleBl3
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            notFollowing
                ? GradientButtonBuilder(
                    text: 'Follow',
                    ontap: () {
                      notFollowing = !notFollowing;
                      setState(() {});
                    },
                    height: 45,
                  )
                : OutlinedButtonBuilder(
                    text: 'Following',
                    ontap: () {
                      notFollowing = !notFollowing;
                      setState(() {});
                    },
                    // width: screenWidth(context, 0.55),
                    height: 45,
                  ),
          ],
        ),
      ),
    );
  }
}
