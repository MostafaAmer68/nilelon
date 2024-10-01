import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nilelon/features/product/domain/models/add_product/add_product_model.dart';
import 'package:nilelon/features/product/domain/models/create_review_model.dart';
import 'package:nilelon/features/product/domain/models/create_variant_image.dart';
import 'package:nilelon/features/product/domain/models/create_variant_model.dart';
import 'package:nilelon/features/product/domain/models/delete_image_variant.dart';
import 'package:nilelon/features/product/domain/models/delete_variant_model.dart';
import 'package:nilelon/features/product/domain/models/products_response_model.dart';
import 'package:nilelon/features/product/data/datasources/products_remote_data_source.dart';
import 'package:nilelon/core/service/failure_service.dart';
import 'package:nilelon/features/product/domain/models/update_product.dart';

import '../../domain/models/product_model.dart';
import '../../domain/repositories/products_repos.dart';

class ProductsReposImpl extends ProductsRepos {
  final ProductsRemoteDataSourceImpl productsRemoteDataSource;
  ProductsReposImpl(this.productsRemoteDataSource);
  @override
  Future<Either<FailureService, List<ProductModel>>> getFollowedProducts(
      int page, int productSize) async {
    try {
      final result =
          await productsRemoteDataSource.getFollowedProducts(page, productSize);
      return Right(result);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure(e.toString()));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<FailureService, List<ProductModel>>> getProductByCategory(
      String categoryId, int page, int productSize) async {
    try {
      final result = await productsRemoteDataSource.getProductByCategory(
          categoryId, page, productSize);
      return Right(result);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure(e.toString()));
      }
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
        return left(ServerFailure.fromDioException(e));
      }
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
        return left(ServerFailure.fromDioException(e));
      }
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
        return left(ServerFailure(e.toString()));
      }
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
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<FailureService, ProductsResponseModel>> getStoreProfileItems(
      String storeId, int page, int productSize) async {
    try {
      final result = await productsRemoteDataSource.getStoreProfileItems(
          storeId, page, productSize);
      return Right(result);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<FailureService, void>> createProduct(
      AddProductModel model) async {
    try {
      await productsRemoteDataSource.createProduct(model);
      return const Right(null);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure(e.toString()));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<FailureService, void>> createReview(
      CreateReviewModel model) async {
    try {
      await productsRemoteDataSource.createReview(model);
      return const Right(null);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure(e.toString()));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<FailureService, void>> createProductVariant(
      CreateVariant model) async {
    try {
      await productsRemoteDataSource.createVariant(model);
      return const Right(null);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure(e.toString()));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<FailureService, void>> createVariantImage(
      CreateVariantImage model) async {
    try {
      await productsRemoteDataSource.createVariantImage(model);
      return const Right(null);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure(e.toString()));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<FailureService, void>> deleteVariant(
      DeleteVariant model) async {
    try {
      await productsRemoteDataSource.deleteVariant(model);
      return const Right(null);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure(e.toString()));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<FailureService, void>> deleteVariantImage(
      DeleteVariantImage model) async {
    try {
      await productsRemoteDataSource.deleteVariantImage(model);
      return const Right(null);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure(e.toString()));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<FailureService, void>> updateProduct(
      UpdateProduct model) async {
    try {
      await productsRemoteDataSource.updateProduct(model);
      return const Right(null);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure(e.toString()));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<FailureService, ProductsResponseModel>> getOffersProducts(
      int page, int productSize) async {
    try {
      final result = await productsRemoteDataSource.getCustomersOffersProducts(
          page, productSize);
      return Right(result);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<FailureService, ProductsResponseModel>> getOffersProductsGuest(
      int page, int productSize) async {
    try {
      final result = await productsRemoteDataSource.getOffersProductsGuest(
          page, productSize);
      return Right(result);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
