import 'package:dartz/dartz.dart';
import 'package:nilelon/features/order/data/models/create_order_model.dart';
import 'package:nilelon/core/service/failure_service.dart';
import 'package:nilelon/features/order/data/models/order_model.dart';

abstract class OrderRepo {
  Future<Either<ServerFailure, void>> createOrder(OrderModel order);

  Future<Either<ServerFailure, List<StoreOrder>>> getStoreOrder(
      String orderStatus);
  Future<Either<ServerFailure, List<StoreOrder>>> getStoreOrderByDate(
      String date);
  Future<Either<ServerFailure, List<CustomerOrder>>> getCustomerOrder(
      String orderStatus);
  Future<Either<ServerFailure, void>> changeOrderStatus(
    String orderId,
    String orderStatus,
  );
}
