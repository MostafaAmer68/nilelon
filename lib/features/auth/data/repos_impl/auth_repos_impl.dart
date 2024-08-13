import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nilelon/features/auth/domain/model/customer_register_model.dart';
import 'package:nilelon/features/auth/domain/model/external_google_model.dart';
import 'package:nilelon/features/auth/domain/model/login_model.dart';
import 'package:nilelon/features/auth/domain/model/store_register_model.dart';
import 'package:nilelon/features/auth/data/remote_data_source/auth_remote_data_source.dart';
import 'package:nilelon/features/auth/domain/repos/auth_repos.dart';
import 'package:nilelon/service/failure_service.dart';

class AuthReposImpl extends AuthRepos {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthReposImpl(this.authRemoteDataSource);
  @override
  Future<Either<FailureService, void>> loginRepos(
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

  @override
  Future<Either<FailureService, String>> changePassword(
      String oldPassword, String newPassword, context) async {
    try {
      final result = await authRemoteDataSource.changePassword(
          oldPassword, newPassword, context);
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
  Future<Either<FailureService, String>> forgotPassword(
      String token, String targetValue, String newValue, context) async {
    try {
      final result = await authRemoteDataSource.forgotPassword(
          token, targetValue, newValue, context);
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
  Future<Either<FailureService, String>> resetEmail(
      String newValue, context) async {
    try {
      final result = await authRemoteDataSource.resetEmail(newValue, context);
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
  Future<Either<FailureService, String>> resetEmailDetails(
      String newValue, context) async {
    try {
      final result =
          await authRemoteDataSource.resetEmailDetails(newValue, context);
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
  Future<Either<FailureService, String>> resetPasswordEmail(
      String email, context) async {
    try {
      final result =
          await authRemoteDataSource.resetPasswordEmail(email, context);
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
  Future<Either<FailureService, String>> resetPasswordPhone(
      String phone, context) async {
    try {
      final result =
          await authRemoteDataSource.resetPasswordPhone(phone, context);
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
  Future<Either<FailureService, String>> resetPhone(
      String tergetSend, String newValue, context) async {
    try {
      final result =
          await authRemoteDataSource.resetPhone(tergetSend, newValue, context);
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
  Future<Either<FailureService, String>> resetPhoneDetails(
      String token, String targetValue, String newValue, context) async {
    try {
      final result = await authRemoteDataSource.resetPhoneDetails(
          token, targetValue, newValue, context);
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
  Future<Either<FailureService, String>> updateStore(
      String profilePic, String name, String storeSlogan, context) async {
    try {
      final result = await authRemoteDataSource.updateStore(
          profilePic, name, storeSlogan, context);
      return Right(result);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<FailureService, String>> updateStoreInfo(
      String repName, String repNumber, String webLink, context) async {
    try {
      final result = await authRemoteDataSource.updateStoreInfo(
          repName, repNumber, webLink, context);
      return Right(result);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<FailureService, String>> updateCustomer(
      String profilePic, String name, context) async {
    try {
      final result =
          await authRemoteDataSource.updateCustomer(profilePic, name, context);
      return Right(result);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
