part of 'reservation_date_cubit.dart';

abstract class ReservationDateState {}

class ReservationDateInitial extends ReservationDateState {}

class ReservationDateLoading extends ReservationDateState {}

class ReservationDateSuccess extends ReservationDateState {}

class ReservationDateFailure extends ReservationDateState {}

class ReservationTimeLoading extends ReservationDateState {}

class ReservationTimeSuccess extends ReservationDateState {}

class ReservationTimeFailure extends ReservationDateState {}
