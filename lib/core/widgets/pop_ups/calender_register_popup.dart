import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';

Future calenderRegisterDialog(
    BuildContext context, Function(DateTime date) onTap,
    [int? maxYear, int? minYear]) {
  return showCupertinoModalPopup(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        width: screenWidth(context, 0.95),
        child: CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
                onPressed: () async {},
                child: SizedBox(
                  height: 200.h,
                  child: CupertinoDatePicker(
                    maximumYear: maxYear ?? DateTime.now().year,
                    onDateTimeChanged: onTap,
                    minimumYear: minYear ?? 1,
                    mode: CupertinoDatePickerMode.date,
                  ),
                )),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              navigatePop(context: context);
            },
            child: Text(
              'Done',
              style: AppStylesManager.customTextStyleB4,
            ),
          ),
        ),
      );
    },
  );
}
//
//
//
//
//
//
//
