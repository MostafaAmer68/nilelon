import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nilelon/features/product/presentation/cubit/get_followed_state/get_followed_products_state.dart';
import 'package:nilelon/features/product/presentation/cubit/get_new_in_state/get_new_in_state.dart';
import 'package:nilelon/features/product/presentation/cubit/get_offers_state/get_new_in_state/get_offers_state.dart';
import 'package:nilelon/features/product/presentation/cubit/get_random_state/get_random_state.dart';
import 'package:nilelon/features/product/presentation/cubit/get_store_products/get_store_products_state.dart';

part 'products_state.freezed.dart';

@freezed
class ProductsState with _$ProductsState {
  const factory ProductsState({
    required GetFollowedProductsState getFollowedProducts,
    required GetNewInProductsState getNewInProducts,
    required GetRandomProductsState getRandomProducts,
    required GetStoreProductsState getStoreProducts,
    required GetOffersProductsState getOffersProducts,
  }) = _ProductsState;

  factory ProductsState.initial() => const ProductsState(
        getFollowedProducts: GetFollowedProductsState.initial(),
        getNewInProducts: GetNewInProductsState.initial(),
        getRandomProducts: GetRandomProductsState.initial(),
        getStoreProducts: GetStoreProductsState.initial(),
        getOffersProducts: GetOffersProductsState.initial(),
      );
}
