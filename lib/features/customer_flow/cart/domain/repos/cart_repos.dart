import 'package:dartz/dartz.dart';
import 'package:nilelon/features/customer_flow/cart/domain/model/change_quantity_model.dart';
import 'package:nilelon/features/customer_flow/cart/domain/model/delete_request_model.dart';
import 'package:nilelon/features/customer_flow/cart/domain/model/get_cart_model/get_cart_model.dart';
import 'package:nilelon/service/failure_service.dart';

import '../model/add_cart_request_model.dart';

abstract class CartRepos {
  Future<Either<FailureService, GetCartModel>> getCart();
  Future<Either<FailureService, void>> deleteFromCart(DeleteRequestModel model);
  Future<Either<FailureService, void>> updateQuantityCart(
      ChangeQuantityModel model);
  Future<Either<FailureService, void>> addToCart(AddToCartModel model);
  Future<Either<FailureService, void>> emptyCart(String customerId);
}
