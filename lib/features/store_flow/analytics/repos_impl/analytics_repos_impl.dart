import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nilelon/features/store_flow/analytics/model/analytics_response_model.dart';
import 'package:nilelon/features/store_flow/analytics/remote_data_source/analytics_remote_data_source.dart';
import 'package:nilelon/features/store_flow/analytics/repos/analytics_repos.dart';
import 'package:nilelon/service/failure_service.dart';

class AnalyticsReposImpl extends AnalyticsRepos {
  final AnalyticsRemoteDataSource analyticsRemoteDataSource;

  AnalyticsReposImpl(this.analyticsRemoteDataSource);
  @override
  Future<Either<FailureService, AnalyticsResponseModel>>
      getNoOfFollowersSold() async {
    try {
      final result = await analyticsRemoteDataSource.getNoOfFollowersSold();
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
  Future<Either<FailureService, AnalyticsResponseModel>>
      getNoOfItemsSold() async {
    try {
      final result = await analyticsRemoteDataSource.getNoOfItemsSold();
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
  Future<Either<FailureService, AnalyticsResponseModel>>
      getNoOfNotificationSold() async {
    try {
      final result = await analyticsRemoteDataSource.getNoOfNotificationSold();
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
  Future<Either<FailureService, AnalyticsResponseModel>>
      getNoOfOrdersSold() async {
    try {
      final result = await analyticsRemoteDataSource.getNoOfOrdersSold();
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
  Future<Either<FailureService, AnalyticsResponseModel>>
      getTotalIncomeSold() async {
    try {
      final result = await analyticsRemoteDataSource.getTotalIncomeSold();
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
}
