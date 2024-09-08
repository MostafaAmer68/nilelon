import 'package:dartz/dartz.dart';
import 'package:nilelon/features/order/data/datasources/order_service.dart';
import 'package:nilelon/features/order/data/models/create_order_model.dart';
import 'package:nilelon/features/order/data/models/order_customer_model.dart';
import 'package:nilelon/features/order/data/models/order_model.dart';
import 'package:nilelon/features/order/data/models/order_store_model.dart';
import 'package:nilelon/features/order/data/models/shipping_method.dart';
import 'package:nilelon/features/order/domain/repositories/order_repo.dart';
import 'package:nilelon/core/service/failure_service.dart';

class OrderRepoImpl extends OrderRepo {
  final OrderService _orderService;

  OrderRepoImpl(this._orderService);

  @override
  Future<Either<ServerFailure, void>> changeOrderStatus(
    String orderId,
    String orderStatus,
  ) async {
    try {
      final result = await _orderService.changeOrderState(orderId, orderStatus);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, void>> createOrder(
      CreateOrderModel order) async {
    try {
      final result = await _orderService.createOrder(order);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, List<OrderModel>>> getCustomerOrder(
      String orderStatus) async {
    try {
      final result = await _orderService.getCustomerOrder(orderStatus);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, List<OrderModel>>> getStoreOrder(
      String orderStatus) async {
    try {
      final result = await _orderService.getStoreOrder(orderStatus);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, List<OrderModel>>> getStoreOrderByDate(
      String date) async {
    try {
      final result = await _orderService.getStoreOrderByDate(date);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, List<ShippingMethod>>>
      getShippingMethod() async {
    try {
      final result = await _orderService.getShippingMethod();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, OrderCustomerModel>> getCustomerOrderById(
      String orderId) async {
    try {
      final result = await _orderService.getOrderById(orderId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, OrderStoreModel>> getStoreOrderById(
      String orderId) async {
    try {
      final result = await _orderService.getStoreOrderById(orderId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
