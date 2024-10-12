import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nilelon/features/profile/data/models/store_profile_model.dart';

import '../../../../core/service/failure_service.dart';
import '../../domain/repositories/profile_repo.dart';
import '../datasources/profile_remote_data.dart';

class ProfileRepoIMpl implements ProfileRepo {
  final ProfileRemoteData _profile;

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
}
