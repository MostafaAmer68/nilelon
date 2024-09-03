import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/features/store_flow/analytics/presentation/widget/date_range_picker.dart';
import 'package:nilelon/core/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/view_all_row/view_all_row.dart';
import 'package:intl/intl.dart' as intll;

class DateRow extends StatelessWidget {
  const DateRow({
    super.key,
    this.dateStart,
    this.dateEnd,
  });
  final DateTime? dateStart;
  final DateTime? dateEnd;
  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    var formattedDate = intll.DateFormat('d/M');
    return ViewAllRow(
      text: lang.date,
      onPressed: () {
        navigateTo(context: context, screen: const DateRangePicker());
      },
      buttonWidget: Container(
        width: screenWidth(context, 0.4),
        height: 30.h,
        decoration: BoxDecoration(
            color: ColorManager.primaryO3,
            borderRadius: BorderRadius.circular(24)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: screenWidth(context, 0.15),
              height: 30.h,
              decoration: BoxDecoration(
                  color: ColorManager.primaryO,
                  borderRadius: BorderRadius.circular(24)),
              child: Center(
                child: Text(
                  formattedDate.format(dateStart ?? DateTime.now()),
                  style: AppStylesManager.customTextStyleW5,
                ),
              ),
            ),
            Text(
              lang.to,
              style: AppStylesManager.customTextStyleBl9,
            ),
            Container(
              width: screenWidth(context, 0.15),
              height: 30.h,
              decoration: BoxDecoration(
                  color: ColorManager.primaryO,
                  borderRadius: BorderRadius.circular(24)),
              child: Center(
                child: Text(
                  formattedDate.format(dateEnd ?? DateTime.now()),
                  style: AppStylesManager.customTextStyleW5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
