import 'package:dartz/dartz.dart';
import 'package:nilelon/features/product/domain/models/create_review_model.dart';
import 'package:nilelon/features/product/domain/models/create_variant_image.dart';
import 'package:nilelon/features/product/domain/models/delete_image_variant.dart';
import 'package:nilelon/features/product/domain/models/delete_variant_model.dart';
import 'package:nilelon/core/service/failure_service.dart';
import 'package:nilelon/features/product/domain/models/review_model.dart';
import 'package:nilelon/features/product/domain/models/update_variant_model.dart';

import '../models/add_product/add_product_model.dart';
import '../models/product_model.dart';
import '../models/update_product.dart';

abstract class ProductsRepos {
  Future<Either<FailureService, List<ProductModel>>> getProductByCategory(
      String categoryId, int page, int productSize);
  Future<Either<FailureService, ProductModel>> getProductDetails(
      String productId);

  Future<Either<FailureService, List<ProductModel>>> getFollowedProducts(
      int page, int productSize);
  Future<Either<FailureService, List<ProductModel>>> getNewInProducts(
      int page, int productSize);
  Future<Either<FailureService, List<ProductModel>>> getRandomProduct(
      int page, int productSize, String productType);
  Future<Either<FailureService, List<ProductModel>>> getNewInProductsGuest(
      int page, int productSize, String productType);
  Future<Either<FailureService, List<ProductModel>>> getRandomProductsGuest(
      int page, int productSize, String productType);
  Future<Either<FailureService, List<ProductModel>>> getStoreProfileItems(
      String storeId, int page, int productSize);
  Future<Either<FailureService, List<ProductModel>>> getOffersProducts(
      int page, int productSize, String productTypes);
  Future<Either<FailureService, List<ProductModel>>> getOffersProductsGuest(
      int page, int productSize, String productType);
  Future<Either<FailureService, void>> createProduct(AddProductModel model);
  Future<Either<FailureService, void>> updateProduct(UpdateProduct model);
  Future<Either<FailureService, void>> updateVariant(UpdateVariantsModel model);
  Future<Either<FailureService, void>> createReview(CreateReviewModel model);
  Future<Either<FailureService, List<ReviewModel>>> getReviews(
      String productId);
  Future<Either<FailureService, void>> deleteVariant(DeleteVariant model);
  Future<Either<FailureService, void>> deleteProduct(String id);
  Future<Either<FailureService, void>> deleteVariantImage(
      DeleteVariantImage model);
  Future<Either<FailureService, void>> createProductVariant(
      UpdateVariantsModel model);
  Future<Either<FailureService, void>> createVariantImage(
      CreateVariantImage model);
}
