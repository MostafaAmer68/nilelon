import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/features/auth/domain/model/user_model.dart';
import 'package:nilelon/features/product/domain/models/add_product/add_product_model.dart';
import 'package:nilelon/features/product/domain/models/create_review_model.dart';
import 'package:nilelon/features/product/domain/models/create_variant_image.dart';
import 'package:nilelon/features/product/domain/models/create_variant_model.dart';
import 'package:nilelon/features/product/domain/models/delete_image_variant.dart';
import 'package:nilelon/features/product/domain/models/delete_variant_model.dart';
import 'package:nilelon/features/product/domain/models/product_model.dart';
import 'package:nilelon/features/product/domain/models/products_response_model.dart';
import 'package:nilelon/core/service/network/api_service.dart';
import 'package:nilelon/core/service/network/end_point.dart';

class ProductsRemoteDataSourceImpl {
  final ApiService apiService;

  ProductsRemoteDataSourceImpl({required this.apiService});

  Future<List<ProductModel>> getFollowedProducts(int page, int pageSize) async {
    final data =
        await apiService.get(endPoint: EndPoint.getFollowedProductsUrl, query: {
      'customerId': JwtDecoder.decode(
          HiveStorage.get<UserModel>(HiveKeys.userModel).token)['id'],
      'page': page,
      'pagesize': pageSize,
    });
    if (data.statusCode == 200) {
      log(page.toString());
      log(pageSize.toString());
      return (data.data['result'] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
    } else if (data.statusCode == 400) {
      // Handle the bad request response
      final errorMessage = data.data;
      // errorAlert(context, errorMessage);
      throw Exception('Get Followed failed: $errorMessage');
    } else {
      // Handle other status codes if necessary
      throw Exception(
          'Failed to Get Followed: Unexpected status code ${data.statusCode}');
    }
  }

  Future<ProductsResponseModel> getNewInProducts(int page, int pageSize) async {
    final Response data =
        await apiService.get(endPoint: EndPoint.getNewProductsUrl, query: {
      'CustomerId': JwtDecoder.decode(
          HiveStorage.get<UserModel>(HiveKeys.userModel).token)['id'],
      'page': page,
      'pageSize': pageSize,
    });
    print(data.data);
    if (data.statusCode == 200) {
      return ProductsResponseModel.fromJson(data.data as Map<String, dynamic>);
    } else if (data.statusCode == 400) {
      // Handle the bad request response
      final errorMessage = data.data;
      // errorAlert(context, errorMessage);
      throw Exception('Get New failed: $errorMessage');
    } else {
      // Handle other status codes if necessary
      throw Exception(
          'Failed to Get New: Unexpected status code ${data.statusCode}');
    }
  }

  Future<ProductsResponseModel> getRandomProducts(
      int page, int pageSize) async {
    final data = await apiService.get(
      endPoint: EndPoint.getRandomProductsUrl,
      query: {
        'Customerid': JwtDecoder.decode(
            HiveStorage.get<UserModel>(HiveKeys.userModel).token)['id'],
        'page': page,
        'pageSize': pageSize,
      },
    );
    if (data.statusCode == 200) {
      return ProductsResponseModel.fromJson(data.data as Map<String, dynamic>);
    } else if (data.statusCode == 400) {
      // Handle the bad request response
      final errorMessage = data.data;
      // errorAlert(context, errorMessage);
      throw Exception('Get Random failed: $errorMessage');
    } else {
      // Handle other status codes if necessary
      throw Exception(
          'Failed to Get Random: Unexpected status code ${data.statusCode}');
    }
  }

  Future<ProductsResponseModel> getStoreProfileItems(
      int page, int pageSize) async {
    final data = await apiService.get(
      endPoint: EndPoint.getStoreProductsUrl,
      query: {
        'storeId': JwtDecoder.decode(
            HiveStorage.get<UserModel>(HiveKeys.userModel).token)['id'],
        'page': page,
        'pageSize': pageSize,
      },
    );
    if (data.statusCode == 200) {
      return ProductsResponseModel.fromJson(data.data as Map<String, dynamic>);
    } else if (data.statusCode == 400) {
      // Handle the bad request response
      final errorMessage = data.data;
      // errorAlert(context, errorMessage);
      throw Exception('Get Store failed: $errorMessage');
    } else {
      // Handle other status codes if necessary
      throw Exception(
          'Failed to Get Store: Unexpected status code ${data.statusCode}');
    }
  }

  Future<ProductsResponseModel> getNewInProductsGuest(
      int page, int pageSize) async {
    final Response data =
        await apiService.get(endPoint: EndPoint.getNewProductsGuestUrl, query: {
      'productType': HiveStorage.get(HiveKeys.shopFor),
      'page': page,
      'pageSize': pageSize,
    });
    if (data.statusCode == 200) {
      return ProductsResponseModel.fromJson(data.data as Map<String, dynamic>);
    } else if (data.statusCode == 400) {
      // Handle the bad request response
      final errorMessage = data.data;
      // errorAlert(context, errorMessage);
      throw Exception('Get New failed: $errorMessage');
    } else {
      // Handle other status codes if necessary
      throw Exception(
          'Failed to Get New: Unexpected status code ${data.statusCode}');
    }
  }

  Future<ProductsResponseModel> getRandomProductsGuest(
      int page, int pageSize) async {
    final data = await apiService.get(
      endPoint: EndPoint.getRandomProductsGuestUrl,
      query: {
        'ProductType': HiveStorage.get(HiveKeys.shopFor),
        'page': page,
        'pageSize': pageSize,
      },
    );
    if (data.statusCode == 200) {
      return ProductsResponseModel.fromJson(data.data as Map<String, dynamic>);
    } else if (data.statusCode == 400) {
      // Handle the bad request response
      final errorMessage = data.data;
      // errorAlert(context, errorMessage);
      throw Exception('Get Random failed: $errorMessage');
    } else {
      // Handle other status codes if necessary
      throw Exception(
          'Failed to Get Random: Unexpected status code ${data.statusCode}');
    }
  }

  Future<void> createProduct(AddProductModel product) async {
    final data = await apiService.post(
      endPoint: EndPoint.createProductUrl,
      body: product.toMap(),
    );
    log(data.data.toString());
    if (data.statusCode == 201) {
      log('fucking success');
      return;
    }

    throw Exception(
        'Failed to Get Random: Unexpected status code ${data.statusCode}');
  }

  Future<void> createReview(CreateReviewModel review) async {
    log(review.toMap().toString());
    final data = await apiService.post(
      endPoint: EndPoint.createReviewUrl,
      body: review.toMap(),
    );
    if (data.statusCode == 201) {
      // return ProductsResponseModel.fromJson(dat  a.data as Map<String, dynamic>);
    } else if (data.statusCode == 400) {
      // Handle the bad request response
      final errorMessage = data.data;
      // errorAlert(context, errorMessage);
      throw Exception('Get Random failed: $errorMessage');
    } else {
      // Handle other status codes if necessary
      throw Exception(
          'Failed to Get Random: Unexpected status code ${data.statusCode}');
    }
  }

  Future<void> createVariant(CreateVariant review) async {
    log(review.toMap().toString());
    final data = await apiService.post(
      endPoint: EndPoint.createProductVariantUrl,
      body: review.toMap(),
    );
    if (data.statusCode == 201) {
      // return ProductsResponseModel.fromJson(dat  a.data as Map<String, dynamic>);
    } else if (data.statusCode == 400) {
      // Handle the bad request response
      final errorMessage = data.data;
      // errorAlert(context, errorMessage);
      throw Exception('Get Random failed: $errorMessage');
    } else {
      // Handle other status codes if necessary
      throw Exception(
          'Failed to Get Random: Unexpected status code ${data.statusCode}');
    }
  }

  Future<void> createVariantImage(CreateVariantImage review) async {
    log(review.toMap().toString());
    final data = await apiService.post(
      endPoint: EndPoint.createProductImagesUrl,
      body: review.toMap(),
    );
    if (data.statusCode == 201) {
      // return ProductsResponseModel.fromJson(dat  a.data as Map<String, dynamic>);
    } else if (data.statusCode == 400) {
      // Handle the bad request response
      final errorMessage = data.data;
      // errorAlert(context, errorMessage);
      throw Exception('Get Random failed: $errorMessage');
    } else {
      // Handle other status codes if necessary
      throw Exception(
          'Failed to Get Random: Unexpected status code ${data.statusCode}');
    }
  }

  Future<void> deleteVariant(DeleteVariant review) async {
    log(review.toMap().toString());
    final data = await apiService.post(
      endPoint: EndPoint.deleteProductVariantUrl,
      body: review.toMap(),
    );
    if (data.statusCode == 201) {
      // return ProductsResponseModel.fromJson(dat  a.data as Map<String, dynamic>);
    } else if (data.statusCode == 400) {
      // Handle the bad request response
      final errorMessage = data.data;
      // errorAlert(context, errorMessage);
      throw Exception('Get Random failed: $errorMessage');
    } else {
      // Handle other status codes if necessary
      throw Exception(
          'Failed to Get Random: Unexpected status code ${data.statusCode}');
    }
  }

  Future<void> deleteVariantImage(DeleteVariantImage review) async {
    log(review.toMap().toString());
    final data = await apiService.post(
      endPoint: EndPoint.createReviewUrl,
      body: review.toMap(),
    );
    if (data.statusCode == 201) {
      // return ProductsResponseModel.fromJson(dat  a.data as Map<String, dynamic>);
    } else if (data.statusCode == 400) {
      // Handle the bad request response
      final errorMessage = data.data;
      // errorAlert(context, errorMessage);
      throw Exception('Get Random failed: $errorMessage');
    } else {
      // Handle other status codes if necessary
      throw Exception(
          'Failed to Get Random: Unexpected status code ${data.statusCode}');
    }
  }

  Future<void> getReviewsForProduct(String productId) async {
    final data = await apiService.post(
      endPoint: '${EndPoint.createReviewUrl}/$productId',
    );
    if (data.statusCode == 200) {
      // return ProductsResponseModel.fromJson(dat  a.data as Map<String, dynamic>);
    } else if (data.statusCode == 400) {
      // Handle the bad request response
      final errorMessage = data.data;
      // errorAlert(context, errorMessage);
      throw Exception('Get Random failed: $errorMessage');
    } else {
      // Handle other status codes if necessary
      throw Exception(
          'Failed to Get Random: Unexpected status code ${data.statusCode}');
    }
  }
}
