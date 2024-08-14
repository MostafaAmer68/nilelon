import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nilelon/features/product/domain/models/products_response_model.dart';
import 'package:nilelon/features/product/data/datasources/products_remote_data_source.dart';
import 'package:nilelon/service/failure_service.dart';

import '../../domain/repositories/products_repos.dart';

class ProductsReposImpl extends ProductsRepos {
  final ProductsRemoteDataSourceImpl productsRemoteDataSource;
  ProductsReposImpl(this.productsRemoteDataSource);
  @override
  Future<Either<FailureService, ProductsResponseModel>> getFollowedProducts(
      int page, int productSize) async {
    try {
      final result =
          await productsRemoteDataSource.getFollowedProducts(page, productSize);
      return Right(result);
    } catch (e) {
      if (e is DioException) {
        // print(e.toString());
        return left(ServerFailure.fromDioException(e));
      }
      // print(e.toString());
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<FailureService, ProductsResponseModel>> getNewInProducts(
      int page, int productSize) async {
    try {
      final result =
          await productsRemoteDataSource.getNewInProducts(page, productSize);
      return Right(result);
    } catch (e) {
      if (e is DioException) {
        // print(e.toString());
        return left(ServerFailure.fromDioException(e));
      }
      // print(e.toString());
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<FailureService, ProductsResponseModel>> getRandomProduct(
      int page, int productSize) async {
    try {
      final result =
          await productsRemoteDataSource.getRandomProducts(page, productSize);
      return Right(result);
    } catch (e) {
      if (e is DioException) {
        // print(e.toString());
        return left(ServerFailure.fromDioException(e));
      }
      // print(e.toString());
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<FailureService, ProductsResponseModel>> getNewInProductsGuest(
      int page, int productSize) async {
    try {
      final result = await productsRemoteDataSource.getNewInProductsGuest(
          page, productSize);
      return Right(result);
    } catch (e) {
      if (e is DioException) {
        // print(e.toString());
        return left(ServerFailure.fromDioException(e));
      }
      // print(e.toString());
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<FailureService, ProductsResponseModel>> getRandomProductsGuest(
      int page, int productSize) async {
    try {
      final result = await productsRemoteDataSource.getRandomProductsGuest(
          page, productSize);
      return Right(result);
    } catch (e) {
      if (e is DioException) {
        // print(e.toString());
        return left(ServerFailure.fromDioException(e));
      }
      // print(e.toString());
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<FailureService, ProductsResponseModel>> getStoreProfileItems(
      int page, int productSize) async {
    try {
      final result = await productsRemoteDataSource.getStoreProfileItems(
          page, productSize);
      return Right(result);
    } catch (e) {
      if (e is DioException) {
        // print(e.toString());
        return left(ServerFailure.fromDioException(e));
      }
      // print(e.toString());
      return left(ServerFailure(e.toString()));
    }
  }
}
