import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nilelon/data/hive_stroage.dart';
import 'package:nilelon/features/auth/domain/model/user_model.dart';
import 'package:nilelon/features/product/domain/models/add_product/add_product_model.dart';
import 'package:nilelon/features/product/domain/models/products_response_model.dart';
import 'package:nilelon/service/network/api_service.dart';
import 'package:nilelon/service/network/end_point.dart';

class ProductsRemoteDataSourceImpl {
  final ApiService apiService;

  ProductsRemoteDataSourceImpl({required this.apiService});

  Future<ProductsResponseModel> getFollowedProducts(
      int page, int pageSize) async {
    final data =
        await apiService.get(endPoint: EndPoint.getFollowedProductsUrl, query: {
      'CustomerId': HiveStorage.get(HiveKeys.userId),
      'page': page,
      'pagesize': pageSize,
    });
    if (data.statusCode == 200) {
      return ProductsResponseModel.fromJson(data.data as Map<String, dynamic>);
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
      'CustomerId': HiveStorage.get(HiveKeys.userId),
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
        'Customerid': HiveStorage.get(HiveKeys.userId),
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

  Future<ProductsResponseModel> createProduct(ProductModel product) async {
    final data = await apiService.post(
      endPoint: EndPoint.createProductUrl,
      body: product.toMap(),
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
}
