import 'dart:developer';
import 'dart:io';

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
import 'package:nilelon/features/product/domain/models/review_model.dart';

import '../../domain/models/update_product.dart';

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

  Future<List<ProductModel>> getProductByCategory(
      String categoryId, int page, int pageSize) async {
    final Response data =
        await apiService.get(endPoint: EndPoint.getProductByCategory, query: {
      'categoryId': categoryId,
      'page': page,
      'pageSize': pageSize,
    });
    if (data.statusCode == 200) {
      return (data.data['result'] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
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
      String storeId, int page, int pageSize) async {
    final data = await apiService.get(
      endPoint: EndPoint.getStoreProductsUrl,
      query: {
        'storeId': HiveStorage.get(HiveKeys.isStore)
            ? HiveStorage.get<UserModel>(HiveKeys.userModel).id
            : storeId,
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

  Future<ProductModel> getProductDetails(String productId) async {
    final data = await apiService.get(
      endPoint: EndPoint.getProductById + productId,
      query: {
        'customerId': HiveStorage.get<UserModel>(HiveKeys.userModel).id,
      },
    );
    if (data.statusCode == 200) {
      return ProductModel.fromJson(data.data['result']);
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

  Future<ProductsResponseModel> getCustomersOffersProducts(
      int page, int pageSize) async {
    final data = await apiService.get(
      endPoint: EndPoint.getCustomersOffersUrl,
      query: {
        'customerId': JwtDecoder.decode(
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
      throw Exception('Get Offers failed: $errorMessage');
    } else {
      // Handle other status codes if necessary
      throw Exception(
          'Failed to Get Offers: Unexpected status code ${data.statusCode}');
    }
  }

  Future<ProductsResponseModel> getOffersProductsGuest(
      int page, int pageSize) async {
    final data = await apiService.get(
      endPoint: EndPoint.getStoreOffersUrl,
      query: {
        // 'customerId': JwtDecoder.decode(
        //     HiveStorage.get<UserModel>(HiveKeys.userModel).token)['id'],
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
      throw Exception('Get Offers failed: $errorMessage');
    } else {
      // Handle other status codes if necessary
      throw Exception(
          'Failed to Get Offers: Unexpected status code ${data.statusCode}');
    }
  }
  // Future<ProductsResponseModel> getRandomProductsGuest(
  //     int page, int pageSize) async {
  //   final data = await apiService.get(
  //     endPoint: EndPoint.getRandomProductsGuestUrl,
  //     query: {
  //       'ProductType': HiveStorage.get(HiveKeys.shopFor),
  //       'page': page,
  //       'pageSize': pageSize,
  //     },
  //   );
  //   if (data.statusCode == 200) {
  //     return ProductsResponseModel.fromJson(data.data as Map<String, dynamic>);
  //   } else if (data.statusCode == 400) {
  //     // Handle the bad request response
  //     final errorMessage = data.data;
  //     // errorAlert(context, errorMessage);
  //     throw Exception('Get Random failed: $errorMessage');
  //   } else {
  //     // Handle other status codes if necessary
  //     throw Exception(
  //         'Failed to Get Random: Unexpected status code ${data.statusCode}');
  //   }
  // }

  Future<void> createProduct(AddProductModel product) async {
    final data = await apiService.post(
      endPoint: EndPoint.createProductUrl,
      body: product.toMap(),
    );
    if (data.statusCode == 201) {
      return;
    }

    throw Exception(
        'Failed to Get Random: Unexpected status code ${data.data}');
  }

  Future<void> updateProduct(UpdateProduct product) async {
    final data = await apiService.post(
      endPoint: EndPoint.updateProductUrl,
      body: product.toJson(),
    );
    if (data.statusCode == 201) {
      return;
    }

    throw Exception(
        'Failed to Get Random: Unexpected status code ${data.data}');
  }

  Future<void> createReview(CreateReviewModel review) async {
    log(review.toMap().toString());
    final data = await apiService.post(
      endPoint: EndPoint.createReviewUrl,
      body: review.toMap(),
    );
    if (data.statusCode == HttpStatus.ok) {
      // return ProductsResponseModel.fromJson(dat  a.data as Map<String, dynamic>);
    } else {
      // Handle other status codes if necessary
      throw Exception(
          'Failed to Get Random: Unexpected status code ${data.statusCode}');
    }
  }

  Future<List<ReviewModel>> getReviews(String productId) async {
    final data = await apiService.get(
      endPoint: '${EndPoint.getReviewsForProductUrl}/$productId',
    );
    if (data.statusCode == HttpStatus.ok || data.data['isSuccess']) {
      print(data.data['result']);
      return List<ReviewModel>.from(
          data.data['result'].map((e) => ReviewModel.fromMap(e)));
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
