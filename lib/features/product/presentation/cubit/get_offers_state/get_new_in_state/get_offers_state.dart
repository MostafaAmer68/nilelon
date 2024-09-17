import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nilelon/features/product/domain/models/product_model.dart';

part 'get_offers_state.freezed.dart';

@freezed
class GetOffersProductsState with _$GetOffersProductsState {
  const factory GetOffersProductsState.initial() = _Initial;
  const factory GetOffersProductsState.loading() = _Loading;
  const factory GetOffersProductsState.success(List<ProductModel> products) =
      _Success;
  const factory GetOffersProductsState.failure(String msg) = _Failure;
}
