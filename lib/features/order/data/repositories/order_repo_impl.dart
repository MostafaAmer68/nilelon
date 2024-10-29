import 'package:dartz/dartz.dart';
import 'package:nilelon/features/order/data/datasources/order_service.dart';
import 'package:nilelon/features/order/data/models/create_order_model.dart';
import 'package:nilelon/features/order/data/models/order_customer_model.dart';
import 'package:nilelon/features/order/data/models/order_model.dart';
import 'package:nilelon/features/order/data/models/order_store_model.dart';
import 'package:nilelon/features/order/data/models/shipping_method.dart';
import 'package:nilelon/features/order/domain/repositories/order_repo.dart';
import 'package:nilelon/core/service/failure_service.dart';

import '../../../../core/service/catch_func.dart';

class OrderRepoImpl extends OrderRepo {
  final OrderService _orderService;

  OrderRepoImpl(this._orderService);

  @override
  Future<Either<ServerFailure, void>> changeOrderStatus(
    String orderId,
    String orderStatus,
  ) async {
    return exe(() => _orderService.changeOrderState(orderId, orderStatus));
  }

  @override
  Future<Either<ServerFailure, String>> createOrder(
      CreateOrderModel order) async {
    return exe<String>(() => _orderService.createOrder(order));
  }

  @override
  Future<Either<ServerFailure, List<OrderModel>>> getCustomerOrder(
      String orderStatus) async {
    return exe(() => _orderService.getCustomerOrder(orderStatus));
  }

  @override
  Future<Either<ServerFailure, List<OrderModel>>> getStoreOrder(
      String orderStatus) async {
    return exe(() => _orderService.getStoreOrder(orderStatus));
  }

  @override
  Future<Either<ServerFailure, List<OrderModel>>> getStoreOrderByDate(
      String date) async {
    return exe(() => _orderService.getStoreOrderByDate(date));
  }

  @override
  Future<Either<ServerFailure, List<ShippingMethod>>>
      getShippingMethod() async {
    return exe(() => _orderService.getShippingMethod());
  }

  @override
  Future<Either<ServerFailure, OrderCustomerModel>> getCustomerOrderDetailsById(
      String orderId) async {
    return exe(() => _orderService.getOrderById(orderId));
  }

  @override
  Future<Either<ServerFailure, OrderStoreModel>> getStoreOrderDetailsById(
      String orderId) async {
    return exe(() => _orderService.getStoreOrderById(orderId));
  }
}
