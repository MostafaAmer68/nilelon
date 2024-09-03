import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/core/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';

class AnalyticsRatingRow extends StatelessWidget {
  const AnalyticsRatingRow({
    super.key,
    required this.rate,
  });
  final double rate;
  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    return Row(
      children: [
        Text(
          '${lang.rate} :',
          style: AppStylesManager.customTextStyleBl8,
        ),
        const SizedBox(
          width: 8,
        ),
        RatingBar.builder(
          initialRating: rate,
          itemSize: 34,
          ignoreGestures: true,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemBuilder: (context, _) => const Icon(
            Iconsax.star1,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {},
        ),
      ],
    );
  }
}
