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
import 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsRepos productsRepos;

  ProductsCubit(this.productsRepos) : super(const ProductsState.initial());
  static ProductsCubit get(context) => BlocProvider.of<ProductsCubit>(context);
  //?*********************************************************************************
  //! Get Followed
  //?*********************************************************************************

  final TextEditingController comment = TextEditingController();

  num rate = 0;

  ProductModel product = ProductModel.empty();
  CategoryModel category = CategoryModel.empty();
  String gendar = 'All';
  String categoryId = '';

  List<ReviewModel> review = [];
  List<ProductModel> products = [];
  List<ProductModel> productsHandpack = [];

  List<ProductModel> filterListByCategory(
      CategoryModel selectedCategory, List<ProductModel> filteredProducts) {
    if (gendar == 'All' && selectedCategory.id.isEmpty) {
      return filteredProducts;
    }
    return filteredProducts.where((product) {
      final matchesCategory = selectedCategory.id.isEmpty ||
          product.categoryID == selectedCategory.id;
      final matchesGender = gendar == 'All' || product.type == gendar;

      return matchesCategory && matchesGender;
    }).toList();
  }

  Future<void> getProductDetails(String productId) async {
    emit(const ProductsState.loading());
    var result = await productsRepos.getProductDetails(productId);
    result.fold((failure) {
      emit(ProductsState.failure(failure.errorMsg));
    }, (response) {
      product = response;
      getReviews(productId);
      emit(const ProductsState.success());
    });
  }

  Future<void> getProductByCategory(int page, int productSize) async {
    emit(const ProductsState.loading());
    var result =
        await productsRepos.getProductByCategory(categoryId, page, productSize);
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
    emit(const ProductsState.loading());
    var result = await productsRepos.getReviews(productId);
    result.fold((failure) {
      emit(ProductsState.failure(failure.errorMsg));
    }, (response) {
      review = response;
      emit(const ProductsState.success());
    });
  }

  //todo Get Followed Products Pagination
  Future<void> getFollowedProducts(int page, int productSize) async {
    emit(const ProductsState.loading());
    var result = await productsRepos.getFollowedProducts(page, productSize);
    result.fold((failure) {
      emit(ProductsState.failure(failure.errorMsg));
    }, (response) {
      products = response;
      emit(const ProductsState.success());
    });
  }

  //?*********************************************************************************
  //! Get New In
  //?*********************************************************************************

  //todo Get New In Products Pagination
  Future<void> getNewInProducts(int page, int productSize) async {
    emit(const ProductsState.loading());
    late final Either<FailureService, List<ProductModel>> result;

    if (HiveStorage.get(HiveKeys.userModel) != null) {
      result = await productsRepos.getNewInProducts(page, productSize);
    } else {
      result = await productsRepos.getNewInProductsGuest(page, productSize);
    }

    result.fold((failure) {
      emit(ProductsState.failure(failure.errorMsg));
    }, (response) {
      products = response;
      // getRandomProducts(page, productSize);
      emit(const ProductsState.success());
    });
  }

  //?*********************************************************************************
  //! Get Random
  //?*********************************************************************************

  //todo Get Random Products
  Future<void> getRandomProducts(int page, int productSize) async {
    emit(const ProductsState.loading());
    late final Either<FailureService, List<ProductModel>> result;

    if (HiveStorage.get(HiveKeys.userModel) != null) {
      result = await productsRepos.getRandomProduct(page, productSize);
    } else {
      result = await productsRepos.getRandomProductsGuest(page, productSize);
    }

    result.fold((failure) {
      emit(ProductsState.failure(failure.errorMsg));
    }, (response) {
      productsHandpack = response;
      emit(const ProductsState.success());
    });
  }

  Future<void> deleteProduct(String id) async {
    emit(const ProductsState.loading());
    late final Either<FailureService, void> result;

    result = await productsRepos.deleteProduct(id);

    result.fold((failure) {
      emit(ProductsState.failure(failure.errorMsg));
    }, (response) {
      emit(const ProductsState.success());
    });
  }

  //?*********************************************************************************
  //! Get Offers
  //?*********************************************************************************

  //todo Get Offers Products Pagination
  Future<void> getOffersProducts(int page, int productSize) async {
    emit(const ProductsState.loading());
    late final Either<FailureService, List<ProductModel>> result;

    if (HiveStorage.get(HiveKeys.userModel) != null) {
      result = await productsRepos.getOffersProducts(page, productSize);
    } else {
      result = await productsRepos.getOffersProductsGuest(page, productSize);
    }

    result.fold((failure) {
      emit(ProductsState.failure(failure.errorMsg));
    }, (response) {
      products = response;
      emit(const ProductsState.success());
    });
  }

  //?*********************************************************************************
  //! Get Store
  //?*********************************************************************************

  //todo Get Store Products Pagination
  Future<void> getStoreProducts(
      String storeId, int page, int productSize) async {
    emit(const ProductsState.loading());
    var result =
        await productsRepos.getStoreProfileItems(storeId, page, productSize);
    result.fold((failure) {
      emit(ProductsState.failure(failure.errorMsg));
    }, (response) {
      products = response;
      emit(const ProductsState.success());
    });
  }

  //?*********************************************************************************
}
