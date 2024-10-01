import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/features/product/presentation/cubit/get_followed_state/get_followed_products_state.dart';
import 'package:nilelon/features/product/presentation/cubit/get_new_in_state/get_new_in_state.dart';
import 'package:nilelon/features/product/presentation/cubit/get_offers_state/get_new_in_state/get_offers_state.dart';
import 'package:nilelon/features/product/presentation/cubit/get_random_state/get_random_state.dart';
import 'package:nilelon/features/product/presentation/cubit/get_store_products/get_store_products_state.dart';
import 'package:nilelon/features/product/domain/repositories/products_repos.dart';

import 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsRepos productsRepos;

  ProductsCubit(this.productsRepos) : super(ProductsState.initial());
  static ProductsCubit get(context) => BlocProvider.of<ProductsCubit>(context);
  //?*********************************************************************************
  //! Get Followed
  //?*********************************************************************************

  //todo Get Followed Products
  final TextEditingController comment = TextEditingController();
  String categoryId = '';
  Future<void> getFollowedProducts(int page, int productSize) async {
    emit(state.copyWith(
        getFollowedProducts: const GetFollowedProductsState.loading()));
    var result = await productsRepos.getFollowedProducts(page, productSize);
    result.fold((failure) {
      emit(state.copyWith(
          getFollowedProducts:
              GetFollowedProductsState.failure(failure.errorMsg)));
    }, (response) {
      emit(state.copyWith(
          getFollowedProducts: GetFollowedProductsState.success(response)));
    });
  }

  Future<void> getProductByCategory(int page, int productSize) async {
    emit(state.copyWith(
        getNewInProducts: const GetNewInProductsState.loading()));
    var result =
        await productsRepos.getProductByCategory(categoryId, page, productSize);
    result.fold((failure) {
      emit(state.copyWith(
          getNewInProducts: GetNewInProductsState.failure(failure.errorMsg)));
    }, (response) {
      emit(state.copyWith(
          getNewInProducts: GetNewInProductsState.success(response)));
    });
  }

  // Future<void> createReview() async {
  //   emit(state.copyWith(
  //       getFollowedProducts: const GetFollowedProductsState.loading()));
  //   // var result = await productsRepos.createReview(CreateReviewModel(comment: comment.text, rate: rate, productId: productId, customerId: customerId));
  //   result.fold((failure) {
  //     emit(state.copyWith(
  //         getFollowedProducts:
  //             GetFollowedProductsState.failure(failure.errorMsg)));
  //   }, (response) {
  //     emit(state.copyWith(
  //         getFollowedProducts: GetFollowedProductsState.success(response)));
  //   });
  // }

  //todo Get Followed Products Pagination
  Future<void> getFollowedProductsPagination(int page, int productSize) async {
    emit(state.copyWith(
        getFollowedProducts: const GetFollowedProductsState.loading()));
    var result = await productsRepos.getFollowedProducts(page, productSize);
    result.fold((failure) {
      emit(state.copyWith(
          getFollowedProducts:
              GetFollowedProductsState.failure(failure.errorMsg)));
    }, (response) {
      emit(state.copyWith(
          getFollowedProducts: GetFollowedProductsState.success(response)));
    });
  }

  //?*********************************************************************************
  //! Get New In
  //?*********************************************************************************

  //todo Get New In Products
  Future<void> getNewInProducts(int page, int productSize) async {
    emit(state.copyWith(
        getNewInProducts: const GetNewInProductsState.loading()));
    var result = await productsRepos.getNewInProducts(page, productSize);
    result.fold((failure) {
      emit(state.copyWith(
          getNewInProducts: const GetNewInProductsState.failure(
              'There is no new in products.')));
    }, (response) {
      emit(state.copyWith(
          getNewInProducts:
              GetNewInProductsState.success(response.result ?? [])));
    });
  }

  //todo Get New In Products Pagination
  Future<void> getNewInProductsPagination(int page, int productSize) async {
    emit(state.copyWith(
        getNewInProducts: const GetNewInProductsState.loading()));
    var result = await productsRepos.getNewInProducts(page, productSize);
    result.fold((failure) {
      emit(state.copyWith(
          getNewInProducts: GetNewInProductsState.failure(failure.errorMsg)));
    }, (response) {
      emit(state.copyWith(
          getNewInProducts: GetNewInProductsState.success(response.result!)));
    });
  }

  //?*********************************************************************************
  //! Get Random
  //?*********************************************************************************

  //todo Get Random Products
  Future<void> getRandomProducts(int page, int productSize) async {
    emit(state.copyWith(
        getRandomProducts: const GetRandomProductsState.loading()));
    var result = await productsRepos.getRandomProduct(page, productSize);
    result.fold((failure) {
      emit(state.copyWith(
          getRandomProducts: const GetRandomProductsState.failure(
              'There is no hand picked products.')));
    }, (response) {
      emit(state.copyWith(
          getRandomProducts:
              GetRandomProductsState.success(response.result ?? [])));
    });
  }

  //todo Get Random Products Pagination
  Future<void> getRandomProductsPagination(int page, int productSize) async {
    emit(state.copyWith(
        getRandomProducts: const GetRandomProductsState.loading()));
    var result = await productsRepos.getRandomProduct(page, productSize);
    result.fold((failure) {
      emit(state.copyWith(
          getRandomProducts: GetRandomProductsState.failure(failure.errorMsg)));
    }, (response) {
      emit(state.copyWith(
          getRandomProducts:
              GetRandomProductsState.success(response.result ?? [])));
    });
  }

  Future<void> getNewInProductsGuest(int page, int productSize) async {
    emit(state.copyWith(
        getNewInProducts: const GetNewInProductsState.loading()));
    var result = await productsRepos.getNewInProductsGuest(page, productSize);
    result.fold((failure) {
      emit(state.copyWith(
          getNewInProducts: GetNewInProductsState.failure(failure.errorMsg)));
    }, (response) {
      emit(state.copyWith(
          getNewInProducts:
              GetNewInProductsState.success(response.result ?? [])));
    });
  }

  //todo Get New In Products Pagination
  Future<void> getNewInProductsGuestPagination(
      int page, int productSize) async {
    emit(state.copyWith(
        getNewInProducts: const GetNewInProductsState.loading()));
    var result = await productsRepos.getNewInProductsGuest(page, productSize);
    result.fold((failure) {
      emit(state.copyWith(
          getNewInProducts: GetNewInProductsState.failure(failure.errorMsg)));
    }, (response) {
      emit(state.copyWith(
          getNewInProducts: GetNewInProductsState.success(response.result!)));
    });
  }

  //?*********************************************************************************
  //! Get Random
  //?*********************************************************************************

  //todo Get Random Products
  Future<void> getRandomProductsGuest(int page, int productSize) async {
    emit(state.copyWith(
        getRandomProducts: const GetRandomProductsState.loading()));
    var result = await productsRepos.getNewInProductsGuest(page, productSize);
    result.fold((failure) {
      emit(state.copyWith(
          getRandomProducts: GetRandomProductsState.failure(failure.errorMsg)));
    }, (response) {
      emit(state.copyWith(
          getRandomProducts:
              GetRandomProductsState.success(response.result ?? [])));
    });
  }

  //todo Get Random Products Pagination
  Future<void> getRandomProductsGuestPagination(
      int page, int productSize) async {
    emit(state.copyWith(
        getRandomProducts: const GetRandomProductsState.loading()));
    var result = await productsRepos.getNewInProductsGuest(page, productSize);
    result.fold((failure) {
      emit(state.copyWith(
          getRandomProducts: GetRandomProductsState.failure(failure.errorMsg)));
    }, (response) {
      emit(state.copyWith(
          getRandomProducts:
              GetRandomProductsState.success(response.result ?? [])));
    });
  }

  //?*********************************************************************************
  //! Get Offers
  //?*********************************************************************************

  //todo Get Offers Products
  Future<void> getOffersProducts(int page, int productSize) async {
    emit(state.copyWith(
        getOffersProducts: const GetOffersProductsState.loading()));
    var result = await productsRepos.getOffersProducts(page, productSize);
    result.fold((failure) {
      emit(state.copyWith(
          getOffersProducts: GetOffersProductsState.failure(failure.errorMsg)));
    }, (response) {
      emit(state.copyWith(
          getOffersProducts:
              GetOffersProductsState.success(response.result ?? [])));
    });
  }

  //todo Get Offers Products Pagination
  Future<void> getOffersProductsPagination(int page, int productSize) async {
    emit(state.copyWith(
        getOffersProducts: const GetOffersProductsState.loading()));
    var result = await productsRepos.getOffersProducts(page, productSize);
    result.fold((failure) {
      emit(state.copyWith(
          getOffersProducts: GetOffersProductsState.failure(failure.errorMsg)));
    }, (response) {
      emit(state.copyWith(
          getOffersProducts:
              GetOffersProductsState.success(response.result ?? [])));
    });
  }

  //todo Get Offers Products Guest
  Future<void> getOffersProductsGuest(int page, int productSize) async {
    emit(state.copyWith(
        getOffersProducts: const GetOffersProductsState.loading()));
    var result = await productsRepos.getOffersProductsGuest(page, productSize);
    result.fold((failure) {
      emit(state.copyWith(
          getOffersProducts: GetOffersProductsState.failure(failure.errorMsg)));
    }, (response) {
      emit(state.copyWith(
          getOffersProducts:
              GetOffersProductsState.success(response.result ?? [])));
    });
  }

  //todo Get Offers Products Pagination Guest
  Future<void> getOffersProductsPaginationGuest(
      int page, int productSize) async {
    emit(state.copyWith(
        getOffersProducts: const GetOffersProductsState.loading()));
    var result = await productsRepos.getOffersProductsGuest(page, productSize);
    result.fold((failure) {
      emit(state.copyWith(
          getOffersProducts: GetOffersProductsState.failure(failure.errorMsg)));
    }, (response) {
      emit(state.copyWith(
          getOffersProducts:
              GetOffersProductsState.success(response.result ?? [])));
    });
  }

  //?*********************************************************************************
  //! Get Store
  //?*********************************************************************************

  //todo Get Store Products
  Future<void> getStoreProducts(
      String storeId, int page, int productSize) async {
    emit(state.copyWith(
        getStoreProducts: const GetStoreProductsState.loading()));
    var result =
        await productsRepos.getStoreProfileItems(storeId, page, productSize);
    result.fold((failure) {
      emit(state.copyWith(
          getStoreProducts: GetStoreProductsState.failure(failure.errorMsg)));
    }, (response) {
      emit(state.copyWith(
          getStoreProducts:
              GetStoreProductsState.success(response.result ?? [])));
    });
  }

  //todo Get Store Products Pagination
  Future<void> getStoreProductsPagination(
      String storeId, int page, int productSize) async {
    emit(state.copyWith(
        getStoreProducts: const GetStoreProductsState.loading()));
    var result =
        await productsRepos.getStoreProfileItems(storeId, page, productSize);
    result.fold((failure) {
      emit(state.copyWith(
          getStoreProducts: GetStoreProductsState.failure(failure.errorMsg)));
    }, (response) {
      emit(state.copyWith(
          getStoreProducts:
              GetStoreProductsState.success(response.result ?? [])));
    });
  }

  //?*********************************************************************************
}
