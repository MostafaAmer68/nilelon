part of 'add_product_cubit.dart';

@freezed
class AddproductState with _$AddproductState {
  const factory AddproductState.initial() = _Initial;
  const factory AddproductState.success() = _Success;
  const factory AddproductState.loading() = _Loading;
  const factory AddproductState.failure(String message) = _Failure;
}
