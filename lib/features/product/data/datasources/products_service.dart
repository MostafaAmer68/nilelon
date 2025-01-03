import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/features/auth/domain/model/user_model.dart';
import 'package:nilelon/features/product/domain/models/add_product/add_product_model.dart';
import 'package:nilelon/features/product/domain/models/create_review_model.dart';
import 'package:nilelon/features/product/domain/models/create_variant_image.dart';
import 'package:nilelon/features/product/domain/models/delete_image_variant.dart';
import 'package:nilelon/features/product/domain/models/delete_variant_model.dart';
import 'package:nilelon/features/product/domain/models/product_model.dart';
import 'package:nilelon/core/service/network/api_service.dart';
import 'package:nilelon/core/service/network/end_point.dart';
import 'package:nilelon/features/product/domain/models/review_model.dart';
import 'package:nilelon/features/product/domain/models/update_variant_model.dart';

import '../../domain/models/product_response.dart';
import '../../domain/models/update_product.dart';

class ProductsService {
  final ApiService apiService;

  ProductsService({required this.apiService});

  Future<ProductResponse> getFollowedProducts(
      int page, int pageSize, String productType) async {
    final data =
        await apiService.get(endPoint: EndPoint.getFollowedProductsUrl, query: {
      'customerId': HiveStorage.get<UserModel>(HiveKeys.userModel).id,
      'page': page,
      'productType': HiveStorage.get(HiveKeys.isStore)
          ? productType.isEmpty
              ? 'UniSex'
              : productType
          : productType.isEmpty
              ? HiveStorage.get(HiveKeys.shopFor)
              : productType,
      'pagesize': pageSize,
    });
    if (data.statusCode == 200) {
      return ProductResponse.fromMap(data.data['result'] ?? []);
    } else {
      throw Exception('Unexpected error ${data.data.first}');
    }
  }

  Future<ProductResponse> getNewInProducts(
      int page, int pageSize, String productType) async {
    final Response data =
        await apiService.get(endPoint: EndPoint.getNewProductsUrl, query: {
      'CustomerId': HiveStorage.get<UserModel>(HiveKeys.userModel).id,
      'page': page,
      'productType': HiveStorage.get(HiveKeys.isStore)
          ? productType.isEmpty
              ? 'UniSex'
              : productType
          : productType.isEmpty
              ? HiveStorage.get(HiveKeys.shopFor)
              : productType,
      'pageSize': pageSize,
    });
    if (data.statusCode == 200) {
      return ProductResponse.fromMap(data.data['result']);
    } else {
      throw Exception('Unexpected error ${data.data["errorMessages"]}');
    }
  }

  Future<ProductResponse> getProductByCategory(
      String categoryId, int page, int pageSize) async {
    final Response data =
        await apiService.get(endPoint: EndPoint.getProductByCategory, query: {
      'categoryId': categoryId,
      'page': page,
      'pageSize': pageSize,
    });
    if (data.statusCode == 200) {
      return ProductResponse.fromMap(data.data['result']);
    } else {
      throw Exception('Unexpected error ${data.data["errorMessages"]}');
    }
  }

  Future<ProductResponse> getRandomProducts(
      int page, int pageSize, String productType) async {
    final data = await apiService.get(
      endPoint: EndPoint.getRandomProductsUrl,
      query: {
        'customerId': HiveStorage.get<UserModel>(HiveKeys.userModel).id,
        'productType': HiveStorage.get(HiveKeys.isStore)
            ? productType.isEmpty
                ? 'UniSex'
                : productType
            : productType.isEmpty
                ? HiveStorage.get(HiveKeys.shopFor)
                : productType,
        'page': page,
        'pageSize': pageSize,
      },
    );
    if (data.statusCode == 200) {
      return ProductResponse.fromMap(data.data['result']);
    } else {
      throw Exception('Unexpected error ${data.data["errorMessages"]}');
    }
  }

  Future<ProductResponse> getStoreProfileItems(
      String storeId, int page, int pageSize) async {
    final data = await apiService.get(
      endPoint: EndPoint.getStoreProductsUrl,
      query: {
        'storeId': HiveStorage.get(HiveKeys.isStore)
            ? storeId.isEmpty
                ? HiveStorage.get<UserModel>(HiveKeys.userModel).id
                : storeId
            : storeId,
        'page': page,
        'pageSize': pageSize,
      },
    );
    if (data.statusCode == 200) {
      return ProductResponse.fromMap(data.data['result']);
    } else {
      throw Exception('Unexpected error ${data.data["errorMessages"]}');
    }
  }

  Future<ProductModel> getProductDetails(String productId) async {
    final data = await apiService.get(
      endPoint: EndPoint.getProductById + productId,
      query: {
        'customerId': HiveStorage.get(HiveKeys.userModel) != null
            ? HiveStorage.get(HiveKeys.isStore)
                ? ''
                : HiveStorage.get<UserModel>(HiveKeys.userModel).id
            : '',
      },
    );
    if (data.statusCode == 200) {
      return ProductModel.fromJson(data.data['result']);
    } else {
      throw Exception('Unexpected error ${data.data["errorMessages"]}');
    }
  }

  Future<ProductResponse> getNewInProductsGuest(
      int page, int pageSize, String productType) async {
    final Response data =
        await apiService.get(endPoint: EndPoint.getNewProductsGuestUrl, query: {
      'productType': HiveStorage.get(HiveKeys.isStore)
          ? productType.isEmpty
              ? 'UniSex'
              : productType
          : productType.isEmpty
              ? HiveStorage.get(HiveKeys.shopFor)
              : productType,
      'page': page,
      'pageSize': pageSize,
    });
    if (data.statusCode == 200) {
      return ProductResponse.fromMap(data.data['result']);
    } else {
      throw Exception('Unexpected error ${data.data["errorMessages"]}');
    }
  }

  Future<ProductResponse> getRandomProductsGuest(
      int page, int pageSize, String productType) async {
    final data = await apiService.get(
      endPoint: EndPoint.getRandomProductsGuestUrl,
      query: {
        'productType': HiveStorage.get(HiveKeys.isStore)
            ? productType.isEmpty
                ? 'UniSex'
                : productType
            : productType.isEmpty
                ? HiveStorage.get(HiveKeys.shopFor)
                : productType,
        'page': page,
        'pageSize': pageSize,
      },
    );
    if (data.statusCode == 200) {
      return ProductResponse.fromMap(data.data['result']);
    } else {
      throw Exception('Unexpected error ${data.data["errorMessages"]}');
    }
  }

  Future<ProductResponse> getCustomersOffersProducts(
      int page, int pageSize, String productType) async {
    final data = await apiService.get(
      endPoint: EndPoint.getOffers,
      query: {
        'customerId': HiveStorage.get<UserModel>(HiveKeys.userModel).id,
        'productType': HiveStorage.get(HiveKeys.isStore)
            ? productType.isEmpty
                ? 'UniSex'
                : productType
            : productType.isEmpty
                ? HiveStorage.get(HiveKeys.shopFor)
                : productType,
        'page': page,
        'pageSize': pageSize,
      },
    );
    if (data.statusCode == 200) {
      return ProductResponse.fromMap(data.data['result']);
    } else {
      throw Exception('Unexpected error ${data.data["errorMessages"]}');
    }
  }

  Future<ProductResponse> getOffersProductsGuest(
      int page, int pageSize, String productType) async {
    final data = await apiService.get(
      endPoint: EndPoint.getStoreOffersUrl,
      query: {
        'productType': HiveStorage.get(HiveKeys.isStore)
            ? productType.isEmpty
                ? 'UniSex'
                : productType
            : productType.isEmpty
                ? HiveStorage.get(HiveKeys.shopFor)
                : productType,
        'page': page,
        'pageSize': pageSize,
      },
    );
    if (data.statusCode == 200) {
      return ProductResponse.fromMap(data.data['result']);
    } else {
      throw Exception('Unexpected error ${data.data["errorMessages"]}');
    }
  }

  Future<void> createProduct(AddProductModel product) async {
    final data = await apiService.post(
      endPoint: EndPoint.createProductUrl,
      body: product.toMap(),
    );
    if (data.statusCode == 201 ||
        data.statusCode == 200 && data.data['result'] != null) {
      return;
    } else {
      throw Exception((data.data["errorMessages"] as List).join(','));
    }
  }

  Future<void> updateProduct(UpdateProduct product) async {
    final data = await apiService.put(
      endPoint: EndPoint.updateProductUrl,
      body: product.toJson(),
    );
    if (data.statusCode == 200) {
      return;
    } else {
      throw Exception('Unexpected error ${data.data["errorMessages"]}');
    }
  }

  Future<void> updateVariant(UpdateVariantsModel product) async {
    final data = await apiService.put(
      endPoint: EndPoint.changeProductVariantPriceQuantity,
      body: product.toMap(),
    );
    if (data.statusCode == 200) {
      return;
    } else {
      throw Exception('Unexpected error ${data.data["errorMessages"]}');
    }
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
      throw Exception('Unexpected error ${data.data["errorMessages"]}');
    }
  }

  Future<List<ReviewModel>> getReviews(String productId) async {
    final data = await apiService.get(
      endPoint: '${EndPoint.getReviewsForProductUrl}/$productId',
    );
    if (data.statusCode == HttpStatus.ok || data.data['isSuccess']) {
      return List<ReviewModel>.from(
          data.data['result'].map((e) => ReviewModel.fromMap(e)));
    } else {
      throw Exception('Unexpected error ${data.data["errorMessages"]}');
    }
  }

  Future<bool> createVariant(UpdateVariantsModel review) async {
    final data = await apiService.post(
      endPoint: EndPoint.createProductVariantUrl,
      body: review.toMap(),
    );
    if (data.statusCode == 200 || data.statusCode == 201) {
      return data.data['isSuccess'];
    } else {
      throw Exception('Unexpected error ${data.data["errorMessages"]}');
    }
  }

  Future<void> createVariantImage(CreateVariantImage review) async {
    log(review.toMap().toString());
    final data = await apiService.post(
      endPoint: EndPoint.createProductImagesUrl,
      body: review.toMap(),
    );
    if (data.statusCode == 200 || data.statusCode == 201) {
      // return ProductsResponseModel.fromJson(dat  a.data as Map<String, dynamic>);
    } else {
      throw Exception('Unexpected error ${data.data["errorMessages"]}');
    }
  }

  Future<void> deleteVariant(DeleteVariant review) async {
    final data = await apiService.post(
      endPoint: EndPoint.deleteProductVariantUrl,
      body: review.toMap(),
    );
    if (data.statusCode == 200) {
      // return ProductsResponseModel.fromJson(dat  a.data as Map<String, dynamic>);
    } else {
      throw Exception('Unexpected error ${data.data["errorMessages"]}');
    }
  }

  Future<void> deleteProduct(String id) async {
    final data = await apiService.delete(
      endPoint: EndPoint.deleteProductUrl,
      query: {
        'id': id,
      },
    );
    if (data.statusCode == 200) {
    } else {
      throw Exception('Unexpected error ${data.data["errorMessages"]}');
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
    } else {
      throw Exception('Unexpected error ${data.data["errorMessages"]}');
    }
  }

  Future<void> getReviewsForProduct(String productId) async {
    final data = await apiService.post(
      endPoint: '${EndPoint.createReviewUrl}/$productId',
    );
    if (data.statusCode == 200) {
      // return ProductsResponseModel.fromJson(dat  a.data as Map<String, dynamic>);
    } else {
      throw Exception('Unexpected error ${data.data["errorMessages"]}');
    }
  }
}
