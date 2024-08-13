import 'package:dartz/dartz.dart';
import 'package:nilelon/features/product/domain/models/products_response_model.dart';
import 'package:nilelon/service/failure_service.dart';

abstract class ProductsRepos {
  Future<Either<FailureService, ProductsResponseModel>> getFollowedProducts(
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
}
