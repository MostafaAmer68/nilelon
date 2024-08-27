import 'package:dartz/dartz.dart';
import 'package:nilelon/features/order/data/datasources/order_service.dart';
import 'package:nilelon/features/order/data/models/create_order_model.dart';
import 'package:nilelon/features/order/data/models/order_model.dart';
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
  Future<Either<ServerFailure, void>> createOrder(OrderModel order) async {
    try {
      final result = await _orderService.createOrder(order);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, List<CustomerOrder>>> getCustomerOrder(
      String orderStatus) async {
    try {
      final result = await _orderService.getCustomerOrder(orderStatus);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, List<StoreOrder>>> getStoreOrder(
      String orderStatus) async {
    try {
      final result = await _orderService.getStoreOrder(orderStatus);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, List<StoreOrder>>> getStoreOrderByDate(
      String date) async {
    try {
      final result = await _orderService.getStoreOrderByDate(date);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
