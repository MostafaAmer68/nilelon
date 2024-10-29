import 'package:dartz/dartz.dart';
import 'package:nilelon/core/service/catch_func.dart';
import 'package:nilelon/features/cart/domain/model/add_cart_request_model.dart';
import 'package:nilelon/features/cart/domain/model/change_quantity_model.dart';
import 'package:nilelon/features/cart/domain/model/delete_request_model.dart';
import 'package:nilelon/features/cart/data/datasource/cart_service.dart';
import 'package:nilelon/features/cart/domain/repos/cart_repos.dart';
import 'package:nilelon/core/service/failure_service.dart';

import '../../domain/model/cart_item.dart';

class CartReposImpl extends CartRepos {
  final CartService _cartService;
  CartReposImpl(this._cartService);
  @override
  Future<Either<FailureService, CartModel>> getCart() async {
    return exe(() => _cartService.getCart());
  }

  @override
  Future<Either<FailureService, void>> deleteFromCart(
      DeleteRequestModel model) async {
    return exe(() => _cartService.deleteFromCart(model));
  }

  @override
  Future<Either<FailureService, void>> updateQuantityCart(
      ChangeQuantityModel model) async {
    return exe(() => _cartService.updateQuantityCart(model));
  }

  @override
  Future<Either<FailureService, void>> addToCart(AddToCartModel model) async {
    return exe(() => _cartService.addToCart(model));
  }

  @override
  Future<Either<FailureService, void>> emptyCart(String customerId) async {
    return exe(() => _cartService.emptyCart(customerId));
  }
}
