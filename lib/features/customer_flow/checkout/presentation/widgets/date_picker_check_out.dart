import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:nilelon/resources/appstyles_manager.dart';
import 'package:nilelon/resources/color_manager.dart';

Future datePickerCheckOut(BuildContext context) async {
  return await showMonthPicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      backgroundColor: ColorManager.primaryG2,
      headerColor: ColorManager.primaryG2,
      currentMonthTextColor: ColorManager.primaryW,
      headerTextColor: ColorManager.primaryW,
      selectedMonthTextColor: ColorManager.primaryW,
      unselectedMonthTextColor: ColorManager.primaryW,
      selectedMonthBackgroundColor: ColorManager.primaryB,
      confirmWidget: Text(
        'Confirm',
        style: AppStylesManager.customTextStyleW2,
      ),
      cancelWidget: Text(
        'Cancel',
        style: AppStylesManager.customTextStyleW2,
      ));
}
