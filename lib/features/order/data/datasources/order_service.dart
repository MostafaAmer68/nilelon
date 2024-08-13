import 'dart:io';

import 'package:nilelon/data/hive_stroage.dart';
import 'package:nilelon/features/order/data/models/order_model.dart';
import 'package:nilelon/service/network/api_service.dart';
import 'package:nilelon/service/network/end_point.dart';

class OrderService {
  final ApiService _apiService;

  OrderService(this._apiService);

  Future<void> createOrder(OrderModel order) async {
    final response = await _apiService.post(
      endPoint: EndPoint.createOrderUlr,
      body: order.toJson(),
    );

    if (response.statusCode == HttpStatus.ok) {
      return;
    }
    throw response.data['result'];
  }

  Future<void> getStoreOrder(String orderStatus) async {
    final response = await _apiService.post(
      endPoint: EndPoint.getStoreOrderUrl,
      query: {
        'storeId': HiveStorage.get(HiveKeys.userId),
        'status': orderStatus,
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      return;
    }
    throw response.data['result'];
  }

  Future<void> getCustomerOrder(String orderStatus) async {
    final response = await _apiService.post(
      endPoint: EndPoint.getCustomerOrderUrl,
      query: {
        'customerId': HiveStorage.get(HiveKeys.userId),
        'status': orderStatus,
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      return;
    }
    throw response.data['result'];
  }

  Future<void> getStoreOrderByDate(String date) async {
    final response = await _apiService.post(
      endPoint: EndPoint.getStoreOderByDateUrl,
      query: {
        'storeId': HiveStorage.get(HiveKeys.userId),
        'date': date,
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      return;
    }
    throw response.data['result'];
  }

  Future<void> changeOrderState(String orderId, String orderStatus) async {
    final response = await _apiService.post(
      endPoint: EndPoint.changeOrderStateUrl,
      query: {
        'storeId': HiveStorage.get(HiveKeys.userId),
        'status': orderStatus,
        'orderId': orderId,
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      return;
    }
    throw response.data['result'];
  }
}
