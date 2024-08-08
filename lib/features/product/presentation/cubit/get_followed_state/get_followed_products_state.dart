import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nilelon/features/product/domain/models/product_model.dart';

part 'get_followed_products_state.freezed.dart';

@freezed
class GetFollowedProductsState with _$GetFollowedProductsState {
  const factory GetFollowedProductsState.initial() = _Initial;
  const factory GetFollowedProductsState.loading() = _Loading;
  const factory GetFollowedProductsState.success(List<ProductModel> products) =
      _Success;
  const factory GetFollowedProductsState.failure(String msg) = _Failure;
}
