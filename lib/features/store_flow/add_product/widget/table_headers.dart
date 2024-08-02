import 'package:flutter/material.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/resources/appstyles_manager.dart';
import 'package:nilelon/resources/color_manager.dart';

class TableHeaders extends StatelessWidget {
  const TableHeaders({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 36,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        gradient: LinearGradient(
          begin: Alignment(1.00, -0.10),
          end: Alignment(-1, 0.1),
          colors: ColorManager.gradientColors,
        ),
        color: ColorManager.primaryW,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            lang.sizes,
            style: AppStylesManager.customTextStyleW2,
          ),
          Text(
            lang.amount,
            style: AppStylesManager.customTextStyleW2,
          ),
          Text(
            lang.price,
            style: AppStylesManager.customTextStyleW2,
          ),
        ],
      ),
    );
  }
}
