import 'package:flutter/material.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/widgets/decoration/decoration_with_fade.dart';

Container dropDownMenu(
    {required String hint,
    required String? selectedValue,
    required List<String> items,
    required context,
    required void Function(String?) onChanged,
    double? menuMaxHeight,
    double? width,
    double? height,
    TextStyle? style,
    TextStyle? style2}) {
  return Container(
    width: width,
    height: height,
    decoration: decorationWithFade(),
    child: DropdownButtonFormField<String>(
      // itemHeight: height,
      iconSize: height == null ? 24 : 12,
      hint: Text(
        hint,
        style: style ?? AppStylesManager.customTextStyleG2,
      ),
      elevation: 1,
      menuMaxHeight: menuMaxHeight, borderRadius: BorderRadius.circular(12),
      decoration: InputDecoration(
        fillColor: const Color(0xFFFBF9F9),
        filled: true,
        errorStyle: AppStylesManager.customTextStyleR,
        // AppStyles.customTextStyle.copyWith(
        //   color: Colors.red[900]!,
        //   fontSize: 10,
        // ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
      isExpanded: true,
      value: selectedValue,
      validator: (value) {
        // if (value == null || value.id!.isEmpty) {
        //   return 'Select room first';
        // }
        return null;
      },
      // style: AppStyles.customTextStyleG,
      items: items.map(
        (e) {
          return DropdownMenuItem<String>(
            value: e,
            child: SizedBox(
                width: width ?? screenWidth(context, 1),
                // height: height,
                child: Text(
                  e,
                  style: style2 ?? AppStylesManager.customTextStyleBl,
                )),
          );
        },
      ).toList(),
      onChanged: onChanged,
    ),
  );
}
