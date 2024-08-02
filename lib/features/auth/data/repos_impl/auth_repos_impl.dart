import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nilelon/features/auth/domain/model/customer_register_model.dart';
import 'package:nilelon/features/auth/domain/model/external_google_model.dart';
// import 'package:nilelon/data/hive_stroage.dart';
import 'package:nilelon/features/auth/domain/model/login_model.dart';
import 'package:nilelon/features/auth/domain/model/store_register_model.dart';
import 'package:nilelon/features/auth/data/remote_data_source/auth_remote_data_source.dart';
import 'package:nilelon/features/auth/data/remote_data_source/auth_service.dart';
import 'package:nilelon/features/auth/domain/repos/auth_repos.dart';
import 'package:nilelon/service/failure_service.dart';

class AuthReposImpl extends AuthRepos {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthReposImpl(this.authRemoteDataSource);
  @override
  Future<Either<FailureService, String>> loginRepos(
      LoginModel model, context) async {
    try {
      final result = await authRemoteDataSource.loginAuth(model, context);
      // HiveStorage.set(HiveKeys.token, result);
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
  Future<Either<FailureService, String>> customerRegisterRepos(
      CustomerRegisterModel model, context) async {
    try {
      final result =
          await authRemoteDataSource.customerRegisterAuth(model, context);
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
  Future<Either<FailureService, String>> storeRegisterRepos(
      StoreRegisterModel model, context) async {
    try {
      final result =
          await authRemoteDataSource.storeRegisterAuth(model, context);
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
  Future<Either<FailureService, String>> customerRegisterGoogleAuth(
      ExternalGoogleModel model, context) async {
    try {
      final result =
          await authRemoteDataSource.customerRegisterGoogleAuth(model, context);
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
  Future<Either<FailureService, String>> confirmRegisteration(
      String email, context) async {
    try {
      final result =
          await authRemoteDataSource.confirmRegisteration(email, context);
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
  Future<Either<FailureService, String>> validateOtp(
      String userOtp, String tokenOtp, context) async {
    try {
      final result =
          await authRemoteDataSource.validateOtp(userOtp, tokenOtp, context);
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

  // @override
  // Future<Either<FailureService, void>> otpVerifyUserRepos(
  //     String code, String username) async {
  //   try {
  //     final result =
  //         await authRemoteDataSource.otpVerifyUserAuth(code, username);
  //     // HiveStorage( HiveKeys.email, value: result.data.email);
  //     return Right(result);
  //   } catch (e) {
  //     if (e is DioException) {
  //       print(e.toString());
  //       return left(ServerFailure.fromDioException(e));
  //     }
  //     print(e.toString());
  //     return left(ServerFailure(e.toString()));
  //   }
  // }

  // @override
  // Future<Either<FailureService, void>> forgetPasswordAuth(
  //     ForgetPasswordModel entity) async {
  //   try {
  //     final result = await authRemoteDataSource.forgetPasswordAuth(entity);
  //     // HiveStorage( HiveKeys.email, value: result.data.email);
  //     return Right(result);
  //   } catch (e) {
  //     if (e is DioException) {
  //       print(e.toString());
  //       return left(ServerFailure.fromDioException(e));
  //     }
  //     print(e.toString());
  //     return left(ServerFailure(e.toString()));
  //   }
  // }

  // @override
  // Future<Either<FailureService, void>> resetPasswordAuth(
  //     ResetPasswordModel entity) async {
  //   try {
  //     final result = await authRemoteDataSource.resetPasswordAuth(entity);
  //     // HiveStorage( HiveKeys.email, value: result.data.email);
  //     return Right(result);
  //   } catch (e) {
  //     if (e is DioException) {
  //       print(e.toString());
  //       return left(ServerFailure.fromDioException(e));
  //     }
  //     print(e.toString());
  //     return left(ServerFailure(e.toString()));
  //   }
  // }

  // @override
  // Future<Either<FailureService, void>> deleteAccountAuth() async {
  //   try {
  //     final result = await authRemoteDataSource.deleteAccountAuth();
  //     // HiveStorage( HiveKeys.email, value: result.data.email);
  //     return Right(result);
  //   } catch (e) {
  //     if (e is DioException) {
  //       print(e.toString());
  //       return left(ServerFailure.fromDioException(e));
  //     }
  //     print(e.toString());
  //     return left(ServerFailure(e.toString()));
  //   }
  // }

  // @override
  // Future<Either<FailureService, Map<String, dynamic>>> changeAccountNameAuth(
  //     String username, String phoneNumber) async {
  //   try {
  //     final result = await authRemoteDataSource.changeAccountNameAuth(
  //         username, phoneNumber);
  //     // HiveStorage( HiveKeys.email, value: result.data.email);
  //     return Right(result);
  //   } catch (e) {
  //     if (e is DioException) {
  //       print(e.toString());
  //       return left(ServerFailure.fromDioException(e));
  //     }
  //     print(e.toString());
  //     return left(ServerFailure(e.toString()));
  //   }
  // }
}
