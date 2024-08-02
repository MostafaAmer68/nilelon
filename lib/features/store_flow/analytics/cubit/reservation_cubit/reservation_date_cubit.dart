import 'package:flutter_bloc/flutter_bloc.dart';

part 'reservation_date_state.dart';

class ReservationDateCubit extends Cubit<ReservationDateState> {
  ReservationDateCubit() : super(ReservationDateInitial());
  DateTime? rangeStart = DateTime.now();
  DateTime? rangeEnd = DateTime.now();
  DateTime? timeStart;
  DateTime? timeEnd;
  DateTime focusedDay = DateTime.now();
  void selectReservationDate(
    DateTime selectedDay,
    DateTime getfocusedDay,
  ) {
    emit(ReservationDateLoading());
    // rangeStart = DateTime.now();
    // rangeEnd = DateTime.now();
    focusedDay = getfocusedDay;
    if (rangeStart == null || rangeEnd != null) {
      rangeStart = selectedDay;

      rangeEnd = null;
    } else {
      if (selectedDay.isBefore(rangeStart!)) {
        rangeEnd = rangeStart;
        rangeStart = selectedDay;
      } else {
        rangeEnd = selectedDay;
      }
    }
    // CacheService.setData(
    //     key: ConstText().pickupDate, value: rangeStart!.toString());

    // print(CacheService.getData(key: ConstText().pickupDate));
    // CacheService.setData(
    //     key: ConstText().returnDate, value: rangeEnd!.toString());
    // print(CacheService.getData(key: ConstText().returnDate));
    emit(ReservationDateSuccess());
  }

  void reservationDateCancelled() {
    emit(ReservationTimeLoading());
    rangeStart = null;
    rangeEnd = null;
    emit(ReservationDateFailure());
  }
}
