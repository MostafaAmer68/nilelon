import 'package:dartz/dartz.dart';
import 'package:nilelon/features/auth/domain/model/customer_register_model.dart';
import 'package:nilelon/features/auth/domain/model/login_model.dart';
import 'package:nilelon/features/auth/domain/model/store_register_model.dart';
import 'package:nilelon/core/service/failure_service.dart';

abstract class AuthRepos {
  Future<Either<FailureService, void>> loginRepos(LoginModel model, context);

  Future<Either<FailureService, String>> customerRegisterRepos(
    CustomerRegisterModel model,
    context,
  );
  Future<Either<FailureService, String>> storeRegisterRepos(
    StoreRegisterModel model,
    context,
  );
  Future<Either<FailureService, String>> confirmRegisteration(
    String email,
    context,
  );

  Future<Either<FailureService, String>> validateOtp(
    String userOtp,
    String tokenOtp,
    context,
  );

  Future<Either<FailureService, String>> changePassword(
    String oldPassword,
    String newPassword,
    context,
  );
  Future<Either<FailureService, String>> googleRegisterAuth();
  Future<Either<FailureService, String>> signInGoogleAuth();

  Future<Either<FailureService, String>> forgotPassword(
    String token,
    String targetValue,
    String newValue,
    context,
  );
}
