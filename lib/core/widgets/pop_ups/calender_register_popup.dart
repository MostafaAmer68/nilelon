import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intll;
import 'package:nilelon/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';

Future calenderRegisterDialog(
  BuildContext context,
) {
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
                    maximumYear: DateTime.now().year,
                    onDateTimeChanged: (date) {
                      AuthCubit.get(context).date = date;
                      AuthCubit.get(context).dateFormatted =
                          intll.DateFormat('dd/MM/yyyy').format(date);
                    },
                    mode: CupertinoDatePickerMode.date,
                  ),
                )),
            // CupertinoActionSheetAction(
            //   onPressed: () async {},
            //   child: const Text(
            //     'Done',
            //     style: AppStyles.customTextStyleB4,
            //   ),
            // ),
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
