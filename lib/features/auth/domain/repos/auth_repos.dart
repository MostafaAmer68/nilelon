import 'package:dartz/dartz.dart';
import 'package:nilelon/features/auth/domain/model/customer_register_model.dart';
import 'package:nilelon/features/auth/domain/model/external_google_model.dart';
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
  Future<Either<FailureService, String>> updateStoreInfo(
    String repName,
    String repNumber,
    String webLink,
    context,
  );
  Future<Either<FailureService, String>> changePassword(
    String oldPassword,
    String newPassword,
    context,
  );
  Future<Either<FailureService, String>> updateStore(
    String profilePic,
    String name,
    String storeSlogan,
    context,
  );
  Future<Either<FailureService, String>> updateCustomer(
    String profilePic,
    String name,
    context,
  );
  Future<Either<FailureService, String>> validateOtp(
    String userOtp,
    String tokenOtp,
    context,
  );
  Future<Either<FailureService, String>> customerRegisterGoogleAuth();
  Future<Either<FailureService, String>> resetPasswordEmail(
    String email,
    context,
  );
  Future<Either<FailureService, String>> resetPasswordPhone(
    String phone,
    context,
  );
  Future<Either<FailureService, String>> resetPhone(
    String tergetSend,
    String newValue,
    context,
  );
  Future<Either<FailureService, String>> resetEmail(
    String newValue,
    context,
  );
  Future<Either<FailureService, String>> resetEmailDetails(
    String newValue,
    context,
  );
  Future<Either<FailureService, String>> resetPhoneDetails(
    String token,
    String targetValue,
    String newValue,
    context,
  );
  Future<Either<FailureService, String>> forgotPassword(
    String token,
    String targetValue,
    String newValue,
    context,
  );
}
