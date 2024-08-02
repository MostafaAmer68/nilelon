part of 'checkout_cubit.dart';

class CheckOutState extends Equatable {
  const CheckOutState();

  @override
  List<Object> get props => [];
}

class CheckOutInitial extends CheckOutState {}

class CheckOutLoading extends CheckOutState {}

class CheckOutSuccess extends CheckOutState {}

class CheckOutFailure extends CheckOutState {
  final String errorMessage;

  const CheckOutFailure(this.errorMessage);
}

class BookedLoading extends CheckOutState {}

class BookedSuccess extends CheckOutState {
  const BookedSuccess();
}

class BookedFailure extends CheckOutState {
  final String errorMessage;

  const BookedFailure(this.errorMessage);
}
