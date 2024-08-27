import 'package:flutter/cupertino.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';

Future customerStoreDialog(
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
              child: Text(
                'Report',
                style: AppStylesManager.customTextStyleB4
                    .copyWith(color: ColorManager.primaryR),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () async {},
              child: Text(
                'Share Store Profile',
                style: AppStylesManager.customTextStyleB4,
              ),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              navigatePop(context: context);
            },
            child: Text(
              'Cancel',
              style: AppStylesManager.customTextStyleB4,
            ),
          ),
        ),
      );
    },
  );
}
