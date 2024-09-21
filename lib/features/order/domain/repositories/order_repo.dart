import 'package:dartz/dartz.dart';
import 'package:nilelon/features/order/data/models/create_order_model.dart';
import 'package:nilelon/core/service/failure_service.dart';
import 'package:nilelon/features/order/data/models/order_customer_model.dart';
import 'package:nilelon/features/order/data/models/order_model.dart';
import 'package:nilelon/features/order/data/models/order_store_model.dart';

import '../../data/models/shipping_method.dart';

abstract class OrderRepo {
  Future<Either<ServerFailure, void>> createOrder(CreateOrderModel order);

  Future<Either<ServerFailure, List<OrderModel>>> getStoreOrder(
      String orderStatus);
  Future<Either<ServerFailure, List<OrderModel>>> getStoreOrderByDate(
      String date);
  Future<Either<ServerFailure, OrderStoreModel>> getStoreOrderDetailsById(
      String orderId);
  Future<Either<ServerFailure, OrderCustomerModel>> getCustomerOrderDetailsById(
      String orderId);
  Future<Either<ServerFailure, List<OrderModel>>> getCustomerOrder(
      String orderStatus);
  Future<Either<ServerFailure, List<ShippingMethod>>> getShippingMethod();
  Future<Either<ServerFailure, void>> changeOrderStatus(
    String orderId,
    String orderStatus,
  );
  Future<Either<ServerFailure, Map<String, dynamic>>> getPromoType(
    String code,
  );
  Future<Either<ServerFailure, Map<String, dynamic>>> getOrderDiscount(
    String promotionId,
    num oldPrice,
  );
  Future<Either<ServerFailure, bool>> getFreeShipping(
    String promotionId,
    String governate,
  );
}
