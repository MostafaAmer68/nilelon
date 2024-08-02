import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/resources/const_functions.dart';
import 'package:nilelon/resources/appstyles_manager.dart';
import 'package:nilelon/widgets/text_form_field/text_field/text_form_field_builder.dart';
import 'package:nilelon/features/store_flow/add_product/widget/size_container.dart';

Column sizeRow(BuildContext context, String size, void Function() onTap,
    bool isEdit, TextEditingController priceController) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(
          top: 16,
          // bottom: 8,
          left: 30,
          right: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            sizeContainer(context, size),
            TextFormFieldBuilder(
              label: '0',
              controller: TextEditingController(),
              type: TextInputType.number,
              textAlign: TextAlign.center,
              height: 50,
              disabledBorder: const BorderSide(color: ColorManager.primaryB2),
              width: screenWidth(context, 0.2),
              noIcon: true,
            ),
            isEdit
                ? TextFormFieldBuilder(
                    label:
                        priceController.text == '' ? '0' : priceController.text,
                    controller: TextEditingController(),
                    type: TextInputType.number,
                    textAlign: TextAlign.center,
                    height: 50,
                    disabledBorder: const BorderSide(
                      color: ColorManager.primaryB2,
                    ),
                    width: screenWidth(context, 0.15),
                    noIcon: true,
                  )
                : Row(
                    children: [
                      Text(
                        priceController.text == '' ? '0' : priceController.text,
                        style: AppStylesManager.customTextStyleO3,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: onTap,
                        child: const Icon(
                          Iconsax.edit_2,
                          color: ColorManager.primaryG,
                          size: 20,
                        ),
                      )
                    ],
                  )
          ],
        ),
      )
    ],
  );
}
