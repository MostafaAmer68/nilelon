import 'package:dartz/dartz.dart';
import 'package:nilelon/features/product/domain/models/add_product/add_product_model.dart';
import 'package:nilelon/features/product/domain/models/create_review_model.dart';
import 'package:nilelon/features/product/domain/models/create_variant_image.dart';
import 'package:nilelon/features/product/domain/models/delete_image_variant.dart';
import 'package:nilelon/features/product/domain/models/delete_variant_model.dart';
import 'package:nilelon/features/product/data/datasources/products_service.dart';
import 'package:nilelon/core/service/failure_service.dart';
import 'package:nilelon/features/product/domain/models/product_response.dart';
import 'package:nilelon/features/product/domain/models/review_model.dart';
import 'package:nilelon/features/product/domain/models/update_product.dart';
import 'package:nilelon/features/product/domain/models/update_variant_model.dart';

import '../../../../core/service/catch_func.dart';
import '../../domain/models/product_model.dart';
import '../../domain/repositories/products_repos.dart';

class ProductsReposImpl extends ProductsRepos {
  final ProductsService _productService;
  ProductsReposImpl(this._productService);
  @override
  Future<Either<FailureService, ProductResponse>> getFollowedProducts(
      int page, int productSize, String productType) async {
    return exe(() => _productService.getFollowedProducts(page, productSize, productType));
  }

  @override
  Future<Either<FailureService, ProductResponse>> getProductByCategory(
      String categoryId, int page, int productSize) async {
    return exe(() =>
        _productService.getProductByCategory(categoryId, page, productSize));
  }

  @override
  Future<Either<FailureService, ProductResponse>> getNewInProducts(
      int page, int productSize, String productType) async {
    return exe(() => _productService.getNewInProducts(page, productSize, productType));
  }

  @override
  Future<Either<FailureService, ProductResponse>> getRandomProduct(
      int page, int productSize, String productType) async {
    return exe(() =>
        _productService.getRandomProducts(page, productSize, productType));
  }

  @override
  Future<Either<FailureService, ProductResponse>> getNewInProductsGuest(
      int page, int productSize, String productType) async {
    return exe(() =>
        _productService.getNewInProductsGuest(page, productSize, productType));
  }

  @override
  Future<Either<FailureService, ProductResponse>> getRandomProductsGuest(
      int page, int productSize, String productType) async {
    return exe(() =>
        _productService.getRandomProductsGuest(page, productSize, productType));
  }

  @override
  Future<Either<FailureService, ProductResponse>> getStoreProfileItems(
      String storeId, int page, int productSize) async {
    return exe(
        () => _productService.getStoreProfileItems(storeId, page, productSize));
  }

  @override
  Future<Either<FailureService, void>> createProduct(
      AddProductModel model) async {
    return exe(() => _productService.createProduct(model));
  }

  @override
  Future<Either<FailureService, void>> createReview(
      CreateReviewModel model) async {
    return exe(() => _productService.createReview(model));
  }

  @override
  Future<Either<FailureService, bool>> createProductVariant(
      UpdateVariantsModel model) async {
    return exe(() => _productService.createVariant(model));
  }

  @override
  Future<Either<FailureService, void>> createVariantImage(
      CreateVariantImage model) async {
    return exe(() => _productService.createVariantImage(model));
  }

  @override
  Future<Either<FailureService, void>> deleteVariant(
      DeleteVariant model) async {
    return exe(() => _productService.deleteVariant(model));
  }

  @override
  Future<Either<FailureService, void>> deleteVariantImage(
      DeleteVariantImage model) async {
    return exe(() => _productService.deleteVariantImage(model));
  }

  @override
  Future<Either<FailureService, void>> updateProduct(
      UpdateProduct model) async {
    return exe(() => _productService.updateProduct(model));
  }

  @override
  Future<Either<FailureService, ProductResponse>> getOffersProducts(
      int page, int productSize, String productType) async {
    return exe(() => _productService.getCustomersOffersProducts(
        page, productSize, productType));
  }

  @override
  Future<Either<FailureService, ProductResponse>> getOffersProductsGuest(
      int page, int productSize, String productType) async {
    return exe(() =>
        _productService.getOffersProductsGuest(page, productSize, productType));
  }

  @override
  Future<Either<FailureService, ProductModel>> getProductDetails(
      String productId) async {
    return exe(() => _productService.getProductDetails(productId));
  }

  @override
  Future<Either<FailureService, List<ReviewModel>>> getReviews(
      String productId) async {
    return exe(() => _productService.getReviews(productId));
  }

  @override
  Future<Either<FailureService, void>> updateVariant(
      UpdateVariantsModel model) {
    return exe(() => _productService.updateVariant(model));
  }

  @override
  Future<Either<FailureService, void>> deleteProduct(String id) {
    return exe(() => _productService.deleteProduct(id));
  }
}
