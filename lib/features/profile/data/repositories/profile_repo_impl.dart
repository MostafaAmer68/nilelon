import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nilelon/features/profile/data/models/store_profile_model.dart';

import '../../../../core/service/catch_func.dart';
import '../../../../core/service/failure_service.dart';
import '../../domain/repositories/profile_repo.dart';
import '../datasources/profile_service.dart';

class ProfileRepoIMpl implements ProfileRepo {
  final ProfileService _profile;

  ProfileRepoIMpl(this._profile);
  @override
  Future<Either<FailureService, String>> updateStore(
      String profilePic, String name, String storeSlogan, context) async {
    try {
      final result =
          await _profile.updateStore(profilePic, name, storeSlogan, context);
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
      final result =
          await _profile.updateStoreInfo(repName, repNumber, webLink, context);
      return Right(result);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<FailureService, String>> changePassword(
      String oldPassword, String newPassword, context) async {
    try {
      final result =
          await _profile.changePassword(oldPassword, newPassword, context);
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
  Future<Either<FailureService, StoreProfileModel>> getStoreById(
      String storeId) async {
    try {
      final result = await _profile.getStoreById(storeId);
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
  Future<Either<FailureService, Map<String, dynamic>>> getStoreForCustomer(
      String storeId) async {
    try {
      final result = await _profile.getStoreForCustomer(storeId);
      // HiveStorage( HiveKeys.email, value: result.data.email);
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
  Future<Either<FailureService, String>> followStore(String storeId) async {
    try {
      final result = await _profile.followStore(storeId);
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
  Future<Either<FailureService, String>> notifyStore(String storeId) async {
    try {
      final result = await _profile.notifyStore(storeId);
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
  Future<Either<FailureService, List<StoreProfileModel>>> getStores(
      int page, int pageSize) async {
    try {
      final result = await _profile.getStores(page, pageSize);

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
  Future<Either<FailureService, String>> sendOtpToEmail(
      String email, context) async {
    return exe(() => _profile.sendOtpToEmail(email, context));
  }

  @override
  Future<Either<FailureService, String>> validateEmail(
      String newValue, context) async {
    return exe(() => _profile.validateEmail(newValue, context));
  }

  @override
  Future<Either<FailureService, String>> resetPasswordEmail(
      String email, context) async {
    return exe(() => _profile.resetPasswordEmail(email, context));
  }

  @override
  Future<Either<FailureService, String>> resetPasswordPhone(
      String phone, context) async {
    return exe(() => _profile.resetPasswordPhone(phone, context));
  }

  @override
  Future<Either<FailureService, String>> resetPhone(
      String newValue, context) async {
    return exe(() => _profile.resetPhone(newValue, context));
  }

  @override
  Future<Either<FailureService, String>> resetPhoneDetails(
      String token, String targetValue, String newValue, context) async {
    return exe(
        () => _profile.validatePhone(token, targetValue, newValue, context));
  }

  @override
  Future<Either<FailureService, String>> updateCustomer(
      String profilePic, String name, context) async {
    return exe(() => _profile.updateCustomer(profilePic, name, context));
  }
}
