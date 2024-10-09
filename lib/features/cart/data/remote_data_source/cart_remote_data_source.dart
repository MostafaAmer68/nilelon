import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/features/auth/domain/model/user_model.dart';
import 'package:nilelon/features/cart/domain/model/add_cart_request_model.dart';
import 'package:nilelon/features/cart/domain/model/change_quantity_model.dart';
import 'package:nilelon/features/cart/domain/model/delete_request_model.dart';
import 'package:nilelon/features/cart/domain/model/get_cart_model/get_cart_model.dart';
import 'package:nilelon/core/service/network/api_service.dart';
import 'package:nilelon/core/service/network/end_point.dart';

abstract class CartRemoteDataSource {
  Future<GetCartModel> getCart();
  Future<void> deleteFromCart(DeleteRequestModel model);
  Future<void> updateQuantityCart(ChangeQuantityModel model);
  Future<void> addToCart(AddToCartModel model);
  Future<void> emptyCart(String customerId);
}

class CartService extends CartRemoteDataSource {
  final ApiService apiService;

  CartService({required this.apiService});

  @override
  Future<GetCartModel> getCart() async {
    final Response data = await apiService.get(
        endPoint: EndPoint.getCartByCustomerIdUrl,
        query: {'id': HiveStorage.get<UserModel>(HiveKeys.userModel).id});
    if (data.statusCode == HttpStatus.ok) {
      return GetCartModel.fromJson(data.data as Map<String, dynamic>);
    } else {
      // Handle other status codes if necessary
      throw Exception(
          'Failed to Get Cart: Unexpected status code ${data.data['result']}');
    }
  }

  @override
  Future<void> deleteFromCart(DeleteRequestModel model) async {
    final Response data = await apiService.delete(
      endPoint: EndPoint.deleteFromCartUrl,
      body: model.toJson(),
    );
    if (data.statusCode == HttpStatus.ok) {
      return data.data;
    } else if (data.statusCode == HttpStatus.badRequest) {
      // Handle the bad request response
      final errorMessage = data.data;
      // errorAlert(context, errorMessage);
      throw Exception('Delete From Cart failed: $errorMessage');
    } else {
      // Handle other status codes if necessary
      throw Exception(
          'Failed to Delete From Cart: Unexpected status code ${data.statusCode}');
    }
  }

  @override
  Future<void> updateQuantityCart(ChangeQuantityModel model) async {
    final Response data = await apiService.put(
      endPoint: EndPoint.updateQuantityCartUrl,
      data: model.toJson(),
    );
    if (data.statusCode == HttpStatus.ok) {
      return data.data;
    } else if (data.statusCode == HttpStatus.badRequest) {
      // Handle the bad request response
      final errorMessage = data.data;
      // errorAlert(context, errorMessage);
      throw Exception('Update Quantity Cart failed: $errorMessage');
    } else {
      // Handle other status codes if necessary
      throw Exception(
          'Failed to Update Quantity Cart: Unexpected status code ${data.statusCode}');
    }
  }

  @override
  Future<void> addToCart(AddToCartModel model) async {
    final Response data = await apiService.post(
      endPoint: EndPoint.addToCartUrl,
      body: model.toJson(),
    );
    if (data.statusCode == HttpStatus.ok) {
      return data.data;
    } else {
      // Handle other status codes if necessary
      throw Exception(
          'Failed to Add to Cart Cart: Unexpected status code ${data.data['result']}');
    }
  }

  @override
  Future<void> emptyCart(String customerId) async {
    final Response data = await apiService.delete(
      endPoint: EndPoint.emptyCartUrl,
      query: {'customerId': customerId},
    );
    if (data.statusCode == HttpStatus.ok) {
      return data.data;
    } else if (data.statusCode == HttpStatus.badRequest) {
      // Handle the bad request response
      final errorMessage = data.data;
      // errorAlert(context, errorMessage);
      throw Exception('Empty Cart failed: $errorMessage');
    } else {
      // Handle other status codes if necessary
      throw Exception(
          'Failed to Empty Cart: Unexpected status code ${data.statusCode}');
    }
  }
}
