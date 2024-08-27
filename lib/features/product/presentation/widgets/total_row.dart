import 'package:flutter/material.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/widgets/text_form_field/text_field/const_text_form_field.dart';

Column totalRow(BuildContext context, int totalItems, String total) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(
          top: 20,
          // bottom: 8,
          left: 30,
          right: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Spacer(
              flex: 2,
            ),
            Text(
              total,
              style: AppStylesManager.customTextStyleBl9,
            ),
            const SizedBox(
              width: 8,
            ),
            ConstTextFieldBuilder(
              label: totalItems.toString(),
              style: AppStylesManager.customTextStyleBl9,
              textAlign: TextAlign.center,
              height: 50,
              disabledBorder: const BorderSide(color: ColorManager.primaryB2),
              width: screenWidth(context, 0.2),
              // noIcon: true,
            ),
            const Spacer(
              flex: 3,
            ),
          ],
        ),
      )
    ],
  );
}
