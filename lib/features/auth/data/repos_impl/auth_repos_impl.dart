import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nilelon/features/auth/domain/model/customer_register_model.dart';
import 'package:nilelon/features/auth/domain/model/login_model.dart';
import 'package:nilelon/features/auth/domain/model/store_register_model.dart';
import 'package:nilelon/features/auth/data/datasource/auth_service.dart';
import 'package:nilelon/features/auth/domain/repos/auth_repos.dart';
import 'package:nilelon/core/service/failure_service.dart';

import '../../../../core/service/catch_func.dart';

class AuthReposImpl extends AuthRepos {
  final AuthService _authService;

  AuthReposImpl(this._authService);

  @override
  Future<Either<FailureService, String>> changePassword(
      String oldPassword, String newPassword, context) async {
    try {
      final result =
          await _authService.changePassword(oldPassword, newPassword, context);
      // HiveStorage( HiveKeys.email, value: result.data.email);
      return Right(result);
    } catch (e) {
      if (e is DioException) {
        print(e.toString());
        return left(ServerFailure.fromDioException(e));
      }
      print(e.toString());
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<FailureService, void>> loginRepos(
      LoginModel model, context) async {
    return await exe<void>(() => _authService.loginAuth(model, context));
  }

  @override
  Future<Either<FailureService, String>> customerRegisterRepos(
      CustomerRegisterModel model, context) async {
    return exe(() => _authService.customerRegisterAuth(model, context));
  }

  @override
  Future<Either<FailureService, String>> storeRegisterRepos(
      StoreRegisterModel model, context) async {
    return exe(
      () => _authService.storeRegisterAuth(model, context),
    );
  }

  @override
  Future<Either<FailureService, String>> googleRegisterAuth() async {
    return exe(() => _authService.signUpWithGoogle());
  }

  @override
  Future<Either<FailureService, String>> signInGoogleAuth() async {
    return exe(() => _authService.signInWithGoogle());
  }

  @override
  Future<Either<FailureService, String>> confirmRegisteration(
      String email, context) async {
    return exe(() => _authService.confirmRegisteration(email, context));
  }

  @override
  Future<Either<FailureService, String>> validateOtp(
      String userOtp, String tokenOtp, context) async {
    return exe(() => _authService.validateOtp(userOtp, tokenOtp, context));
  }

  @override
  Future<Either<FailureService, String>> forgotPassword(
      String token, String targetValue, String newValue, context) async {
    return exe(() =>
        _authService.forgotPassword(token, targetValue, newValue, context));
  }
}
