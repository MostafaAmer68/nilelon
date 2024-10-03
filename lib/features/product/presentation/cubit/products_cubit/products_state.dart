import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/models/product_model.dart';

part 'products_state.freezed.dart';

@freezed
class ProductsState with _$ProductsState {
  const factory ProductsState.initial() = _Initial;
  const factory ProductsState.loading() = _Loading;
  const factory ProductsState.success() = _Success;
  const factory ProductsState.failure(String msg) = _Failure;
}
