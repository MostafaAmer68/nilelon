import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nilelon/features/product/domain/models/product_model.dart';

part 'get_new_in_state.freezed.dart';

@freezed
class GetNewInProductsState with _$GetNewInProductsState {
  const factory GetNewInProductsState.initial() = _Initial;
  const factory GetNewInProductsState.loading() = _Loading;
  const factory GetNewInProductsState.success(List<ProductModel> products) =
      _Success;
  const factory GetNewInProductsState.failure(String msg) = _Failure;
}
