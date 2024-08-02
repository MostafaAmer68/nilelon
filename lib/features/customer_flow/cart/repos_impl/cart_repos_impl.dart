import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nilelon/features/customer_flow/cart/model/change_quantity_model.dart';
import 'package:nilelon/features/customer_flow/cart/model/delete_request_model.dart';
import 'package:nilelon/features/customer_flow/cart/model/get_cart_model/get_cart_model.dart';
import 'package:nilelon/features/customer_flow/cart/remote_data_source/cart_remote_data_source.dart';
import 'package:nilelon/features/customer_flow/cart/repos/cart_repos.dart';
import 'package:nilelon/service/failure_service.dart';

class CartReposImpl extends CartRepos {
  final CartRemoteDataSource cartRemoteDataSource;
  CartReposImpl(this.cartRemoteDataSource);
  @override
  Future<Either<FailureService, GetCartModel>> getCart() async {
    try {
      final result = await cartRemoteDataSource.getCart();
      return Right(result);
    } catch (e) {
      if (e is DioException) {
        // print(e.toString());
        return left(ServerFailure.fromDioException(e));
      }
      // print(e.toString());
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<FailureService, void>> deleteFromCart(
      DeleteRequestModel model) async {
    try {
      final result = await cartRemoteDataSource.deleteFromCart(model);
      return Right(result);
    } catch (e) {
      if (e is DioException) {
        // print(e.toString());
        return left(ServerFailure.fromDioException(e));
      }
      // print(e.toString());
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<FailureService, void>> updateQuantityCart(
      ChangeQuantityModel model) async {
    try {
      final result = await cartRemoteDataSource.updateQuantityCart(model);
      return Right(result);
    } catch (e) {
      if (e is DioException) {
        // print(e.toString());
        return left(ServerFailure.fromDioException(e));
      }
      // print(e.toString());
      return left(ServerFailure(e.toString()));
    }
  }
}
