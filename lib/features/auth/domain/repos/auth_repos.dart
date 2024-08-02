import 'package:dartz/dartz.dart';
import 'package:nilelon/features/auth/domain/model/customer_register_model.dart';
import 'package:nilelon/features/auth/domain/model/external_google_model.dart';
import 'package:nilelon/features/auth/domain/model/login_model.dart';
import 'package:nilelon/features/auth/domain/model/store_register_model.dart';
import 'package:nilelon/service/failure_service.dart';

abstract class AuthRepos {
  Future<Either<FailureService, String>> loginRepos(LoginModel model, context);

  Future<Either<FailureService, String>> customerRegisterRepos(
      CustomerRegisterModel model, context);
  Future<Either<FailureService, String>> storeRegisterRepos(
      StoreRegisterModel model, context);
  Future<Either<FailureService, String>> confirmRegisteration(
      String email, context);
  Future<Either<FailureService, String>> validateOtp(
      String userOtp, String tokenOtp, context);
  Future<Either<FailureService, String>> customerRegisterGoogleAuth(
      ExternalGoogleModel model, context);
  // Future<Either<FailureService, void>> otpVerifyUserRepos(
  //     String code, String username);
  // Future<Either<FailureService, void>> forgetPasswordAuth(
  //     ForgetPasswordModel entity);
  // Future<Either<FailureService, void>> resetPasswordAuth(
  //     ResetPasswordModel entity);
  // Future<Either<FailureService, void>> deleteAccountAuth();
  // Future<Either<FailureService, Map<String, dynamic>>> changeAccountNameAuth(
  //     String username, String phoneNumber);
}
