import 'package:dartz/dartz.dart';
import 'package:nilelon/core/service/catch_func.dart';
import 'package:nilelon/features/store_flow/analytics/domain/model/analytics_response_model.dart';
import 'package:nilelon/features/store_flow/analytics/data/remote_data_source/analytics_service.dart';
import 'package:nilelon/features/store_flow/analytics/domain/repos/analytics_repos.dart';
import 'package:nilelon/core/service/failure_service.dart';

class AnalyticsReposImpl extends AnalyticsRepos {
  final AnalyticsRemoteDataSource analyticsRemoteDataSource;

  AnalyticsReposImpl(this.analyticsRemoteDataSource);
  @override
  Future<Either<FailureService, DashboardModel>> getDashboardData() async {
    return exe(() => analyticsRemoteDataSource.getDashboardData());
  }
  @override
  Future<Either<FailureService, List<num>>> getChartData(
      DateTime endDate, DateTime startDate) async {
    return exe(() => analyticsRemoteDataSource.getChartData(endDate,startDate));
  }
}
