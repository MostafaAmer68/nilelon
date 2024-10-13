import 'package:dartz/dartz.dart';
import 'package:nilelon/features/auth/domain/model/customer_register_model.dart';
import 'package:nilelon/features/auth/domain/model/login_model.dart';
import 'package:nilelon/features/auth/domain/model/store_register_model.dart';
import 'package:nilelon/features/auth/data/remote_data_source/auth_remote_data_source.dart';
import 'package:nilelon/features/auth/domain/repos/auth_repos.dart';
import 'package:nilelon/core/service/failure_service.dart';

import '../../../../core/service/catch_func.dart';

class AuthReposImpl extends AuthRepos {
  final AuthRemoteDataSource _authService;

  AuthReposImpl(this._authService);
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
  Future<Either<FailureService, String>> changePassword(
      String oldPassword, String newPassword, context) async {
    return exe(
        () => _authService.changePassword(oldPassword, newPassword, context));
  }

  @override
  Future<Either<FailureService, String>> forgotPassword(
      String token, String targetValue, String newValue, context) async {
    return exe(() =>
        _authService.forgotPassword(token, targetValue, newValue, context));
  }

  @override
  Future<Either<FailureService, String>> resetEmail(
      String newValue, context) async {
    return exe(() => _authService.resetEmail(newValue, context));
  }

  @override
  Future<Either<FailureService, String>> resetEmailDetails(
      String newValue, context) async {
    return exe(() => _authService.resetEmailDetails(newValue, context));
  }

  @override
  Future<Either<FailureService, String>> resetPasswordEmail(
      String email, context) async {
    return exe(() => _authService.resetPasswordEmail(email, context));
  }

  @override
  Future<Either<FailureService, String>> resetPasswordPhone(
      String phone, context) async {
    return exe(() => _authService.resetPasswordPhone(phone, context));
  }

  @override
  Future<Either<FailureService, String>> resetPhone(
      String tergetSend, String newValue, context) async {
    return exe(() => _authService.resetPhone(tergetSend, newValue, context));
  }

  @override
  Future<Either<FailureService, String>> resetPhoneDetails(
      String token, String targetValue, String newValue, context) async {
    return exe(() =>
        _authService.resetPhoneDetails(token, targetValue, newValue, context));
  }

  @override
  Future<Either<FailureService, String>> updateStore(
      String profilePic, String name, String storeSlogan, context) async {
    return exe(
        () => _authService.updateStore(profilePic, name, storeSlogan, context));
  }

  @override
  Future<Either<FailureService, String>> updateStoreInfo(
      String repName, String repNumber, String webLink, context) async {
    return exe(() =>
        _authService.updateStoreInfo(repName, repNumber, webLink, context));
  }

  @override
  Future<Either<FailureService, String>> updateCustomer(
      String profilePic, String name, context) async {
    return exe(() => _authService.updateCustomer(profilePic, name, context));
  }
}
