import 'dart:developer';
import 'dart:io';

import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/features/auth/domain/model/user_model.dart';
import 'package:nilelon/features/order/data/models/create_order_model.dart';
import 'package:nilelon/core/service/network/api_service.dart';
import 'package:nilelon/core/service/network/end_point.dart';
import 'package:nilelon/features/order/data/models/order_customer_model.dart';
import 'package:nilelon/features/order/data/models/order_store_model.dart';
import 'package:nilelon/features/order/data/models/return_model.dart';
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

  Future<List<OrderModel>> getCustomerOrder(String orderStatus,
      [page, pageSize]) async {
    final response = await _apiService.get(
      endPoint: EndPoint.getCustomerOrderUrl,
      query: {
        'customerId': HiveStorage.get<UserModel>(HiveKeys.userModel).id,
        'status': orderStatus,
        'page': page ?? 1,
        'pageSize': pageSize ?? 10,
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

  Future<Map<String, dynamic>> getPromoCodeType(
    String code,
  ) async {
    final response = await _apiService.get(
      endPoint: EndPoint.getPromoCodeType,
      query: {
        'code': code,
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      return {
        'promotionId': response.data['result']['promotionId'],
        'type': response.data['result']['type'],
      };
    }
    throw response.data['result'];
  }

  Future<Map<String, dynamic>> getOrderDiscount(
    String promotionId,
    num totalOrderPrice,
  ) async {
    final response = await _apiService.post(
      endPoint: EndPoint.getOrderDiscount,
      body: {
        'promotionId': promotionId,
        'oldPrice': totalOrderPrice,
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      return {
        'discount': response.data['result']['discount'],
        'newPrice': response.data['result']['newPrice'],
      };
    }
    throw response.data['result'];
  }

  Future<bool> getFreeShipping(String code, String governate) async {
    final response = await _apiService.post(
        endPoint: EndPoint.getFreeShipping,
        body: {'promotionId': code, 'governate': governate});

    print(response.data['result'] as bool);
    if (response.statusCode == HttpStatus.ok) {
      return response.data['result'] as bool;
    }
    throw response.data['result'];
  }

  Future<List<ReturnModel>> getCustomerReturens() async {
    final response = await _apiService
        .post(endPoint: EndPoint.getCustomerReturensUrl, query: {
      'customerId': HiveStorage.get<UserModel>(HiveKeys.userModel).id,
    });

    if (response.statusCode == HttpStatus.ok) {
      return List<ReturnModel>.from(
        response.data['result'].map(
          (e) => ReturnModel.fromMap(e),
        ),
      );
    }
    throw response.data['result'];
  }

  Future<void> getCustomerWrongReturn(String returnId) async {
    final response = await _apiService
        .post(endPoint: EndPoint.getCustomerWrongItemDetailsUrl, query: {
      'returnId': returnId,
    });

    if (response.statusCode == HttpStatus.ok) {
      // return response.data['result'] as bool;
    }
    throw response.data['result'];
  }

  Future<void> getCustomerMissinItem(String returnId) async {
    final response = await _apiService.post(
      endPoint: EndPoint.getCustomerMissingItemDetailsUrl,
      query: {
        'returnId': returnId,
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      // return response.data['result'] as bool;
    }
    throw response.data['result'];
  }

  Future<void> getCustomerChangeMindItemDetails(String returnId) async {
    final response = await _apiService.post(
      endPoint: EndPoint.getCustomerChangeMindItemDetailsUrl,
      query: {
        'returnId': returnId,
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      // return response.data['result'] as bool;
    }
    throw response.data['result'];
  }

  Future<void> createReturnWrongItem() async {
    final response = await _apiService.post(
      endPoint: EndPoint.getFreeShipping,
    );

    if (response.statusCode == HttpStatus.ok) {
      // return response.data['result'] as bool;
    }
    throw response.data['result'];
  }

  Future<void> createReturnMissingItem() async {
    final response = await _apiService.post(
      endPoint: EndPoint.getFreeShipping,
    );

    if (response.statusCode == HttpStatus.ok) {
      // return response.data['result'] as bool;
    }
    throw response.data['result'];
  }

  Future<void> createReturnChangeMindItem() async {
    final response = await _apiService.post(
      endPoint: EndPoint.getFreeShipping,
    );

    if (response.statusCode == HttpStatus.ok) {
      // return response.data['result'] as bool;
    }
    throw response.data['result'];
  }
}
