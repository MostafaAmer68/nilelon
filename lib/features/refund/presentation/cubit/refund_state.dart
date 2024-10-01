part of 'refund_cubit.dart';

abstract class RefundState extends Equatable {
  const RefundState();

  @override
  List<Object> get props => [];
}

class RefundInitial extends RefundState {}

class RefundLoading extends RefundState {}

class RefundSuccess extends RefundState {}

class RefundFailure extends RefundState {
  final String erroMsg;

  const RefundFailure(this.erroMsg);
}
