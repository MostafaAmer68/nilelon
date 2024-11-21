import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/core/service/failure_service.dart';
import 'package:nilelon/features/auth/domain/model/user_model.dart';
import 'package:nilelon/features/product/domain/models/review_model.dart';
import 'package:nilelon/features/product/domain/repositories/products_repos.dart';

import '../../../../categories/domain/model/result.dart';
import '../../../domain/models/create_review_model.dart';
import '../../../domain/models/product_model.dart';
import '../../../domain/models/product_response.dart';
import 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsRepos productsRepos;

  ProductsCubit(this.productsRepos) : super(const ProductsState.initial());
  static ProductsCubit get(context) => BlocProvider.of<ProductsCubit>(context);

  final TextEditingController comment = TextEditingController();
  ScrollController scroll = ScrollController();

  num rate = 0;

  ProductModel product = ProductModel.empty();
  CategoryModel category = CategoryModel.empty();
  String gendar = 'All';
  String categoryId = '';

  int page = 1;
  int limit = 10;

  List<ReviewModel> review = [];
  ProductResponse products = ProductResponse.empty();
  ProductResponse newInProducts = ProductResponse.empty();
  ProductResponse randomProducts = ProductResponse.empty();
  ProductResponse followingProducts = ProductResponse.empty();
  ProductResponse storeProducts = ProductResponse.empty();

  bool loadMore = false;

  List<ProductModel> filterListByCategory(
      CategoryModel selectedCategory, List<ProductModel> filteredProducts) {
    if (selectedCategory.id.isEmpty) {
      return filteredProducts;
    }
    return filteredProducts.where(
      (product) {
        final matchesCategory = selectedCategory.id.isEmpty ||
            product.categoryID == selectedCategory.id;

        return matchesCategory;
      },
    ).toList();
  }

  Future<void> getProductDetails(String productId,
      [bool isSearch = true]) async {
    if (isSearch) {
      emit(const ProductsState.initial());
      product = ProductModel.empty();
    }
      emit(const ProductsState.loading());
    var result = await productsRepos.getProductDetails(productId);
    result.fold((failure) {
      emit(ProductsState.failure(failure.errorMsg));
    }, (response) {
      product = response;
      if (isSearch) {
        getReviews(productId);
      }
      emit(const ProductsState.success());
    });
  }

  Future<void> getProductByCategory() async {
    emit(const ProductsState.loading());
    var result =
        await productsRepos.getProductByCategory(categoryId, page, limit);
    result.fold((failure) {
      emit(ProductsState.failure(failure.errorMsg));
    }, (response) {
      products = response;
      emit(const ProductsState.success());
    });
  }

  Future<void> createReview() async {
    emit(const ProductsState.loading());
    var result = await productsRepos.createReview(CreateReviewModel(
        comment: comment.text,
        rate: rate.toInt(),
        productId: product.id,
        customerId: HiveStorage.get<UserModel>(HiveKeys.userModel).id));
    result.fold((failure) {
      emit(ProductsState.failure(failure.errorMsg));
    }, (response) {
      emit(const ProductsState.success());
    });
  }

  Future<void> getReviews(String productId) async {
    emit(const ProductsState.initial());
    // review.clear();
    emit(const ProductsState.loading());
    var result = await productsRepos.getReviews(productId);
    result.fold((failure) {
      emit(ProductsState.failure(failure.errorMsg));
    }, (response) {
      emit(const ProductsState.loading());
      review = response;
      emit(const ProductsState.success());
    });
  }

  //todo Get Followed Products Pagination
  Future<void> getFollowedProducts([bool isPagination = true]) async {
    if (isPagination) {
      emit(const ProductsState.loading());
    }
    var result = await productsRepos.getFollowedProducts(page, limit);
    result.fold((failure) {
      emit(ProductsState.failure(failure.errorMsg));
    }, (response) {
      followingProducts = response;
      emit(ProductsState.followingProductSuccess(response));
    });
  }

  //todo Get New In Products Pagination
  Future<void> getNewInProducts([bool isPagination = true]) async {
    if (isPagination) {
      emit(const ProductsState.loading());
    }
    late final Either<FailureService, ProductResponse> result;

    if (HiveStorage.get(HiveKeys.userModel) != null &&
        !HiveStorage.get(HiveKeys.isStore)) {
      result = await productsRepos.getNewInProducts(page, limit);
    } else {
      result = await productsRepos.getNewInProductsGuest(
        page,
        limit,
        gendar == 'All' ? 'UniSex' : gendar,
      );
    }

    result.fold((failure) {
      emit(ProductsState.failure(failure.errorMsg));
    }, (response) {
      newInProducts = response;
      emit(ProductsState.newInProductSuccess(response));
    });
  }

  //todo Get Random Products
  Future<void> getRandomProducts([bool isPagination = true]) async {
    if (isPagination) {
      emit(const ProductsState.loading());
    }
    late final Either<FailureService, ProductResponse> result;

    if (HiveStorage.get(HiveKeys.userModel) != null &&
        !HiveStorage.get(HiveKeys.isStore)) {
      result = await productsRepos.getRandomProduct(
          page, limit, gendar == 'All' ? 'UniSex' : gendar);
    } else {
      result = await productsRepos.getRandomProductsGuest(
          page, limit, gendar == 'All' ? 'UniSex' : gendar);
    }

    result.fold((failure) {
      emit(ProductsState.failure(failure.errorMsg));
    }, (response) {
      emit(const ProductsState.loading());

      randomProducts = response;

      emit(ProductsState.randomProductSuccess(response));
    });
  }

  Future<void> deleteProduct(String id) async {
    emit(const ProductsState.loading());
    late final Either<FailureService, void> result;

    result = await productsRepos.deleteProduct(id);

    result.fold((failure) {
      emit(ProductsState.failure(failure.errorMsg));
    }, (response) {
      getStoreProducts(HiveStorage.get<UserModel>(HiveKeys.userModel).id);
      // emit(const ProductsState.success());
    });
  }

  Future<void> getOffersProducts([bool isPagination = true]) async {
    if (isPagination) {
      emit(const ProductsState.loading());
    }
    late final Either<FailureService, ProductResponse> result;

    if (HiveStorage.get(HiveKeys.userModel) != null &&
        !HiveStorage.get(HiveKeys.isStore)) {
      result = await productsRepos.getOffersProducts(
          page, limit, gendar == 'All' ? 'UniSex' : gendar);
    } else {
      result = await productsRepos.getOffersProductsGuest(
          page, limit, gendar == 'All' ? 'UniSex' : gendar);
    }

    result.fold((failure) {
      emit(ProductsState.failure(failure.errorMsg));
    }, (response) {
      products = response;
      emit(ProductsState.randomProductSuccess(response));
    });
  }

  //todo Get Store Products Pagination
  Future<void> getStoreProducts(String storeId,
      [bool isPagination = true]) async {
    if (isPagination) {
      emit(const ProductsState.loading());
    }
    var result = await productsRepos.getStoreProfileItems(storeId, page, limit);
    result.fold((failure) {
      emit(ProductsState.failure(failure.errorMsg));
    }, (response) {
      storeProducts = response;
      emit(ProductsState.storeProductSuccess(response));
    });
  }
}
