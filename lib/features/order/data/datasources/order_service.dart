import 'dart:developer';
import 'dart:io';

import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/features/auth/domain/model/user_model.dart';
import 'package:nilelon/features/order/data/models/create_order_model.dart';
import 'package:nilelon/core/service/network/api_service.dart';
import 'package:nilelon/core/service/network/end_point.dart';
import 'package:nilelon/features/order/data/models/order_customer_model.dart';
import 'package:nilelon/features/order/data/models/order_store_model.dart';
import 'package:nilelon/features/order/data/models/shipping_method.dart';

import '../models/order_model.dart';

class OrderService {
  final ApiService _apiService;

  OrderService(this._apiService);

  Future<void> createOrder(CreateOrderModel order) async {
    log(order.toJson());
    final response = await _apiService.post(
      endPoint: EndPoint.createOrderUlr,
      body: order.toMap(),
    );
    if (response.statusCode == HttpStatus.ok) {
      return;
    }
    log(response.data['result'].toString());
    throw response.data['result'];
  }

  Future<List<OrderModel>> getStoreOrder(String orderStatus) async {
    final response = await _apiService.get(
      endPoint: EndPoint.getStoreOrderUrl,
      query: {
        'storeId': HiveStorage.get<UserModel>(HiveKeys.userModel).id,
        'status': orderStatus,
        'page': 1,
        'pageSize': 100,
      },
    );
    print(response);
    if (response.statusCode == HttpStatus.ok) {
      if (response.data['result'] == []) {
        return [];
      } else {
        return List<OrderModel>.from(
            response.data['result'].map((e) => OrderModel.fromMap(e)));
      }
    }
    // return [];
    throw response.data['result'];
  }

  Future<List<OrderModel>> getCustomerOrder(String orderStatus) async {
    final response = await _apiService.get(
      endPoint: EndPoint.getCustomerOrderUrl,
      query: {
        'customerId': HiveStorage.get<UserModel>(HiveKeys.userModel).id,
        'status': orderStatus,
        'pageNumber': 1,
        'pageSize': 100,
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      return List<OrderModel>.from(
          response.data['result'].map((e) => OrderModel.fromMap(e)));
    }
    throw response.data['result'];
  }

  Future<List<ShippingMethod>> getShippingMethod() async {
    final response = await _apiService.get(
      endPoint: EndPoint.getShippingMethodUrl,
    );

    if (response.statusCode == HttpStatus.ok) {
      return List<ShippingMethod>.from((response.data['result'] as List)
          .map((e) => ShippingMethod.fromJson(e))
          .toList());
    }
    throw response.data['result'];
  }

  Future<List<OrderModel>> getStoreOrderByDate(String date) async {
    final response = await _apiService.post(
      endPoint: EndPoint.getStoreOderByDateUrl,
      query: {
        'storeId': HiveStorage.get<UserModel>(HiveKeys.userModel).id,
        'date': date,
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      return List<OrderModel>.from(response.data);
    }
    throw response.data['result'];
  }

  Future<void> changeOrderState(String orderId, String orderStatus) async {
    final response = await _apiService.put(
      endPoint: EndPoint.changeOrderStateUrl,
      query: {
        'storeId': HiveStorage.get<UserModel>(HiveKeys.userModel).id,
        'status': orderStatus,
        'orderId': orderId,
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      return;
    }
    throw response.data['result'];
  }

  Future<OrderCustomerModel> getOrderById(String orderId) async {
    final response = await _apiService.get(
      endPoint: EndPoint.getOrderDetailsByIdUrl,
      query: {
        'orderId': orderId,
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      return OrderCustomerModel.fromJson(response.data['result']);
    }
    throw response.data['result'];
  }

  Future<OrderStoreModel> getStoreOrderById(
    String orderId,
  ) async {
    final response = await _apiService.get(
      endPoint: EndPoint.getStoreOrderDetailsUrl,
      query: {
        'storeId': HiveStorage.get<UserModel>(HiveKeys.userModel).id,
        'orderId': orderId,
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      return OrderStoreModel.fromJson(response.data['result']);
    }
    throw response.data['result'];
  }
}
