import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nilelon/features/product/domain/models/product_model.dart';

part 'get_random_state.freezed.dart';

@freezed
class GetRandomProductsState with _$GetRandomProductsState {
  const factory GetRandomProductsState.initial() = _Initial;
  const factory GetRandomProductsState.loading() = _Loading;
  const factory GetRandomProductsState.success(List<ProductModel> products) =
      _Success;
  const factory GetRandomProductsState.failure(String msg) = _Failure;
}
