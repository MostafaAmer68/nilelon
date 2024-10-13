import 'package:dartz/dartz.dart';
import 'package:nilelon/core/service/catch_func.dart';
import 'package:nilelon/features/cart/domain/model/add_cart_request_model.dart';
import 'package:nilelon/features/cart/domain/model/change_quantity_model.dart';
import 'package:nilelon/features/cart/domain/model/delete_request_model.dart';
import 'package:nilelon/features/cart/domain/model/get_cart_model/get_cart_model.dart';
import 'package:nilelon/features/cart/data/remote_data_source/cart_remote_data_source.dart';
import 'package:nilelon/features/cart/domain/repos/cart_repos.dart';
import 'package:nilelon/core/service/failure_service.dart';

class CartReposImpl extends CartRepos {
  final CartRemoteDataSource _cartRemoteDataSource;
  CartReposImpl(this._cartRemoteDataSource);
  @override
  Future<Either<FailureService, GetCartModel>> getCart() async {
    return exe(() => _cartRemoteDataSource.getCart());
  }

  @override
  Future<Either<FailureService, void>> deleteFromCart(
      DeleteRequestModel model) async {
    return exe(() => _cartRemoteDataSource.deleteFromCart(model));
  }

  @override
  Future<Either<FailureService, void>> updateQuantityCart(
      ChangeQuantityModel model) async {
    return exe(() => _cartRemoteDataSource.updateQuantityCart(model));
  }

  @override
  Future<Either<FailureService, void>> addToCart(AddToCartModel model) async {
    return exe(() => _cartRemoteDataSource.addToCart(model));
  }

  @override
  Future<Either<FailureService, void>> emptyCart(String customerId) async {
    return exe(() => _cartRemoteDataSource.emptyCart(customerId));
  }
}
