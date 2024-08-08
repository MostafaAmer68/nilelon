import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nilelon/features/product/domain/models/product_model.dart';

part 'get_store_products_state.freezed.dart';

@freezed
class GetStoreProductsState with _$GetStoreProductsState {
  const factory GetStoreProductsState.initial() = _Initial;
  const factory GetStoreProductsState.loading() = _Loading;
  const factory GetStoreProductsState.success(List<ProductModel> products) =
      _Success;
  const factory GetStoreProductsState.failure(String msg) = _Failure;
}
