import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/models/product_model.dart';
import '../../../domain/models/product_response.dart';

part 'products_state.freezed.dart';

@freezed
class ProductsState with _$ProductsState {
  const factory ProductsState.initial() = _Initial;
  const factory ProductsState.loading() = _Loading;
  const factory ProductsState.success() = _Success;
  const factory ProductsState.newInProductSuccess(ProductResponse products) =
      _NewInProductSuccess;
  const factory ProductsState.randomProductSuccess(ProductResponse products) =
      _RandomProductSuccess;
  const factory ProductsState.followingProductSuccess(
      ProductResponse products) = _FollowingSuccess;
  const factory ProductsState.storeProductSuccess(ProductResponse products) =
      _StoreProductSuccess;
  const factory ProductsState.failure(String msg) = _Failure;
}
