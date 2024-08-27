import 'package:dartz/dartz.dart';
import 'package:nilelon/features/product/domain/models/create_review_model.dart';
import 'package:nilelon/features/product/domain/models/create_variant_image.dart';
import 'package:nilelon/features/product/domain/models/create_variant_model.dart';
import 'package:nilelon/features/product/domain/models/delete_image_variant.dart';
import 'package:nilelon/features/product/domain/models/delete_variant_model.dart';
import 'package:nilelon/features/product/domain/models/products_response_model.dart';
import 'package:nilelon/core/service/failure_service.dart';

import '../models/add_product/add_product_model.dart';
import '../models/product_model.dart';

abstract class ProductsRepos {
  Future<Either<FailureService, List<ProductModel>>> getFollowedProducts(
      int page, int productSize);
  Future<Either<FailureService, ProductsResponseModel>> getNewInProducts(
      int page, int productSize);
  Future<Either<FailureService, ProductsResponseModel>> getRandomProduct(
      int page, int productSize);
  Future<Either<FailureService, ProductsResponseModel>> getNewInProductsGuest(
      int page, int productSize);
  Future<Either<FailureService, ProductsResponseModel>> getRandomProductsGuest(
      int page, int productSize);
  Future<Either<FailureService, ProductsResponseModel>> getStoreProfileItems(
      int page, int productSize);
  Future<Either<FailureService, void>> createProduct(AddProductModel model);
  Future<Either<FailureService, void>> createReview(CreateReviewModel model);
  Future<Either<FailureService, void>> deleteVariant(DeleteVariant model);
  Future<Either<FailureService, void>> deleteVariantImage(
      DeleteVariantImage model);
  Future<Either<FailureService, void>> createProductVariant(
      CreateVariant model);
  Future<Either<FailureService, void>> createVariantImage(
      CreateVariantImage model);
}
