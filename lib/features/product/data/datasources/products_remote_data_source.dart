import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:nilelon/data/hive_stroage.dart';
import 'package:nilelon/features/product/domain/models/products_response_model.dart';
import 'package:nilelon/service/network/api_service.dart';
import 'package:nilelon/service/network/end_point.dart';

abstract class ProductsRemoteDataSource {
  Future<ProductsResponseModel> getFollowedItems(int page, int pageSize);
  Future<ProductsResponseModel> getNewInItems(int page, int pageSize);
  Future<ProductsResponseModel> getHandPickedItems(int page, int pageSize);
  Future<ProductsResponseModel> getStoreProfileItems(int page, int pageSize);
}

class ProductsRemoteDataSourceImpl extends ProductsRemoteDataSource {
  final ApiService apiService;

  ProductsRemoteDataSourceImpl({required this.apiService});
  @override
  Future<ProductsResponseModel> getFollowedItems(int page, int pageSize) async {
    final data =
        await apiService.get(endPoint: EndPoint.getFollowedProductsUrl, query: {
      'CustomerId': HiveStorage.get(HiveKeys.userId),
      'page': page,
      'pagesize': pageSize,
    });
    print(data);
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

  @override
  Future<ProductsResponseModel> getNewInItems(int page, int pageSize) async {
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

  @override
  Future<ProductsResponseModel> getHandPickedItems(
      int page, int pageSize) async {
    final data = await apiService.get(
      endPoint: EndPoint.getRandomProductsUrl,
      query: {
        'Customerid': HiveStorage.get(HiveKeys.userId),
        'page': page,
        'pageSize': pageSize,
      },
    );
    print(data);
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

  @override
  Future<ProductsResponseModel> getStoreProfileItems(
      int page, int pageSize) async {
    final data = await apiService.get(
      endPoint:
          '${EndPoint.getStoreProductsUrl}${HiveStorage.get(HiveKeys.userId)}${EndPoint.page}$page${EndPoint.pageSize}$pageSize',
    );
    print(data);
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
}
