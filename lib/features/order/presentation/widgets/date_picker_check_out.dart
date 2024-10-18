import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';

import '../../../../core/tools.dart';

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
        lang(context).confirm,
        style: AppStylesManager.customTextStyleW2,
      ),
      cancelWidget: Text(
        lang(context).cancel,
        style: AppStylesManager.customTextStyleW2,
      ));
}
