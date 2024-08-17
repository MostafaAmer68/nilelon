part of 'payment_cubit.dart';

@freezed
class PaymentState with _$PaymentState {
  const factory PaymentState.initial() = _Initial;
  const factory PaymentState.loading() = _Loading;
  const factory PaymentState.success() = _Success;
  const factory PaymentState.failure() = _Failure;
}
