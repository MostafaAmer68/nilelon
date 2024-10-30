import 'package:flutter_bloc/flutter_bloc.dart';

part 'reservation_date_state.dart';

class ReservationDateCubit extends Cubit<ReservationDateState> {
  ReservationDateCubit() : super(ReservationDateInitial());
  DateTime? rangeStart = DateTime.now();
  DateTime? rangeEnd = DateTime.now();
  DateTime? timeStart;
  DateTime? timeEnd;
  DateTime focusedDay = DateTime.now();

  static ReservationDateCubit get(context) => BlocProvider.of(context);
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

    emit(ReservationDateSuccess());
  }

  void reservationDateCancelled() {
    emit(ReservationTimeLoading());
    rangeStart = null;
    rangeEnd = null;
    emit(ReservationDateFailure());
  }
}
