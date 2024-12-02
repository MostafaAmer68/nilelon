import 'package:flutter/material.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/features/profile/presentation/pages/store_temp.dart';

class StoreBrandCard extends StatefulWidget {
  const StoreBrandCard({
    super.key,
    required this.image,
    required this.name,
    required this.description,
  });
  final String image;
  final String name;
  final String description;

  @override
  State<StoreBrandCard> createState() => _StoreBrandCardState();
}

class _StoreBrandCardState extends State<StoreBrandCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(
            context: context,
            screen: StoreProfileStore(
              storeName: widget.name,
              image: widget.image,
              description: widget.description,
            ));
      },
      child: Container(
        width: screenWidth(context, 0.45),
        height: 170,
        padding:
            const EdgeInsets.only(top: 24, bottom: 12, left: 12, right: 12),
        decoration: BoxDecoration(
          color: ColorManager.primaryB5,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Container(
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(widget.image),
              ),
            ),
            const Spacer(),
            Text(
              widget.name,
              style: AppStylesManager.customTextStyleBl3
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            const Spacer(
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }
}
