part of 'notification_cubit.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class Notificationfailure extends NotificationState {
  final String err;

  const Notificationfailure(this.err);
}

class NotificationSuccess extends NotificationState {}
