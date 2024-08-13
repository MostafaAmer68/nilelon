import 'package:dartz/dartz.dart';
import 'package:nilelon/features/order/data/models/order_model.dart';
import 'package:nilelon/service/failure_service.dart';

abstract class OrderRepo {
  Future<Either<ServerFailure, void>> createOrder(OrderModel order);

  Future<Either<ServerFailure, void>> getStoreOrder(String orderStatus);
  Future<Either<ServerFailure, void>> getStoreOrderByDate(String date);
  Future<Either<ServerFailure, void>> getCustomerOrder(String orderStatus);
  Future<Either<ServerFailure, void>> changeOrderStatus(
    String orderId,
    String orderStatus,
  );
}
