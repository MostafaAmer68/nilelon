import 'package:dartz/dartz.dart';
import 'package:nilelon/features/store_flow/analytics/domain/model/analytics_response_model.dart';
import 'package:nilelon/core/service/failure_service.dart';

abstract class AnalyticsRepos {
  Future<Either<FailureService, DashboardModel>> getDashboardData();
  Future<Either<FailureService, List<num>>> getChartData(
      DateTime endDate, DateTime startDate);
}
