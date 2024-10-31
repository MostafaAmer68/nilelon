import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intll;
import 'package:nilelon/core/tools.dart';
import 'package:nilelon/features/store_flow/analytics/presentation/cubit/analytics_cubit.dart';
import 'package:nilelon/features/store_flow/analytics/presentation/cubit/reservation_cubit/reservation_date_cubit.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/button/button_builder.dart';
import 'package:nilelon/core/widgets/button/outlined_button_builder.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../core/widgets/scaffold_image.dart';

class DateRangePicker extends StatefulWidget {
  const DateRangePicker({super.key});

  @override
  State<DateRangePicker> createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  intll.DateFormat dateFormat = intll.DateFormat.MMMMd("en");
  intll.DateFormat dateFormat2 = intll.DateFormat.yMMMM("en");
  int numberOfDays = 1;
  DateTime focusedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var cubit = ReservationDateCubit.get(context);
    return BlocBuilder<ReservationDateCubit, ReservationDateState>(
      builder: (context, state) {
        return ScaffoldImage(
          body: SafeArea(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            'From',
                            style: AppStylesManager.customDateStyle,
                          ),
                          Text(
                            dateFormat.format(cubit.rangeStart!).toString(),
                          ),
                        ],
                      ),
                      const SizedBox(
                          width: 5,
                          height: 30,
                          child: VerticalDivider(
                            color: Colors.grey,
                            indent: 0,
                          )),
                      Column(
                        children: [
                          Text(
                            'To',
                            style: AppStylesManager.customDateStyle,
                          ),
                          Text(
                            cubit.rangeEnd.toString() == 'null'
                                ? dateFormat
                                    .format(cubit.rangeStart!)
                                    .toString()
                                : dateFormat.format(cubit.rangeEnd!).toString(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(),
                  TableCalendar(
                    calendarBuilders: CalendarBuilders(
                      headerTitleBuilder: (context, day) {
                        return Column(
                          children: [
                            Text(
                              dateFormat2.format(day).toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            cubit.rangeEnd == null
                                ? const Text('You select 1 day')
                                : Text(
                                    'You select ${BlocProvider.of<ReservationDateCubit>(context).rangeEnd!.difference(BlocProvider.of<ReservationDateCubit>(context).rangeStart!).inDays + 1} day')
                          ],
                        );
                      },
                    ),
                    locale: 'en-US',
                    focusedDay: focusedDay,
                    firstDay: DateTime(2024),
                    lastDay: DateTime(2100),
                    availableCalendarFormats: const {
                      CalendarFormat.month: 'Month',
                    },
                    rangeSelectionMode: RangeSelectionMode.enforced,
                    daysOfWeekStyle: const DaysOfWeekStyle(
                      weekdayStyle: TextStyle(fontWeight: FontWeight.bold),
                      weekendStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    calendarStyle: const CalendarStyle(
                      rangeHighlightColor: ColorManager.primaryO3,
                      todayDecoration: BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      todayTextStyle: TextStyle(
                          color: ColorManager.primaryBL2, fontSize: 16.0),
                      rangeEndDecoration: BoxDecoration(
                        color: ColorManager.primaryO,
                        shape: BoxShape.circle,
                      ),
                      rangeStartDecoration: BoxDecoration(
                        color: ColorManager.primaryO,
                        shape: BoxShape.circle,
                      ),
                    ),
                    // onDaySelected: _onDaySelected,
                    rangeStartDay: cubit.rangeStart,
                    rangeEndDay: cubit.rangeEnd,
                    onDaySelected: (selectedDay, newFocusedDay) {
                      focusedDay = newFocusedDay;
                      cubit.selectReservationDate(selectedDay, newFocusedDay);
                    },
                    headerStyle: const HeaderStyle(
                      leftChevronIcon: Icon(
                        Icons.chevron_left,
                        color: ColorManager.primaryO,
                      ),
                      rightChevronIcon: Icon(
                        Icons.chevron_right,
                        color: ColorManager.primaryO,
                      ),
                    ),
                  ),
                  const Divider(),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ButtonBuilder(
                        buttonColor: ColorManager.primaryO,
                        height: 50,
                        text: lang(context).confirm,
                        ontap: () {
                          AnalyticsCubit.get(context).endDate = cubit.rangeEnd!;
                          AnalyticsCubit.get(context).startDate =
                              cubit.rangeStart!;
                          AnalyticsCubit.get(context).getChartData();
                          navigatePop(context: context);
                        },
                      ),
                      OutlinedButtonBuilder(
                        height: 50,
                        text: lang(context).cancel,
                        ontap: () {
                          navigatePop(context: context);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 18,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

//Arabic language
// must initialize
//await initializeDateFormatting('ar', null);
