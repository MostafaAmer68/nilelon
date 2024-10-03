import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nilelon/core/service/failure_service.dart';
import 'package:nilelon/features/refund/data/datasources/refund_service.dart';
import 'package:nilelon/features/refund/data/models/create_ret_change_mind_model.dart';
import 'package:nilelon/features/refund/data/models/create_ret_missing_model.dart';
import 'package:nilelon/features/refund/data/models/create_ret_wrong_model.dart';
import 'package:nilelon/features/refund/data/models/refund_details_model.dart';
import 'package:nilelon/features/refund/data/models/refund_model.dart';
import 'package:nilelon/features/refund/domain/repositories/refund_repo.dart';

class RefundRepoImpl implements RefundRepo {
  final RefundSErvice _refundServcie;

  RefundRepoImpl(this._refundServcie);

  @override
  Future<Either<FailureService, void>> createRetChangeMindItem(
      CreateRetChangeMindModel userId) async {
    try {
      await _refundServcie.createRetChangeMindItem(userId);
      return const Right(null);
    } catch (e) {
      if (e is DioException) {
        // print(e.toString());
        return left(ServerFailure(e.toString()));
      }
      // print(e.toString());
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<FailureService, void>> createRetMissingItem(
      CreateRetMissingModel userId) async {
    try {
      await _refundServcie.createRetMissingItem(userId);
      return const Right(null);
    } catch (e) {
      if (e is DioException) {
        // print(e.toString());
        return left(ServerFailure(e.toString()));
      }
      // print(e.toString());
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<FailureService, void>> createRetWrongItem(
      CreateRetWrongModel userId) async {
    try {
      await _refundServcie.createRetWrongItem(userId);
      return const Right(null);
    } catch (e) {
      if (e is DioException) {
        // print(e.toString());
        return left(ServerFailure(e.toString()));
      }
      // print(e.toString());
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<FailureService, List<RefundModel>>> getRefunds() async {
    try {
      final result = await _refundServcie.getRefunds();
      return Right(result);
    } catch (e) {
      if (e is DioException) {
        // print(e.toString());
        return left(ServerFailure(e.toString()));
      }
      // print(e.toString());
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<FailureService, ReturnDetailsModel>> getReturnDetails(
      String returnId, String returnType) async {
    try {
      final result =
          await _refundServcie.getReturnDetails(returnId, returnType);
      return Right(result);
    } catch (e) {
      if (e is DioException) {
        // print(e.toString());
        return left(ServerFailure(e.toString()));
      }
      // print(e.toString());
      return left(ServerFailure(e.toString()));
    }
  }
}
