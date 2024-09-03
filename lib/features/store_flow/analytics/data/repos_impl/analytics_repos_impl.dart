import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nilelon/features/store_flow/analytics/domain/model/analytics_response_model.dart';
import 'package:nilelon/features/store_flow/analytics/data/remote_data_source/analytics_remote_data_source.dart';
import 'package:nilelon/features/store_flow/analytics/domain/repos/analytics_repos.dart';
import 'package:nilelon/core/service/failure_service.dart';

class AnalyticsReposImpl extends AnalyticsRepos {
  final AnalyticsRemoteDataSource analyticsRemoteDataSource;

  AnalyticsReposImpl(this.analyticsRemoteDataSource);
  @override
  Future<Either<FailureService, DashboardModel>> getDashboardData() async {
    try {
      final result = await analyticsRemoteDataSource.getDashboardData();
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
