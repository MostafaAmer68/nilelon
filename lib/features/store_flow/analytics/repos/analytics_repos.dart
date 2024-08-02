import 'package:dartz/dartz.dart';
import 'package:nilelon/features/store_flow/analytics/model/analytics_response_model.dart';
import 'package:nilelon/service/failure_service.dart';

abstract class AnalyticsRepos {
  Future<Either<FailureService, AnalyticsResponseModel>> getNoOfItemsSold();
  Future<Either<FailureService, AnalyticsResponseModel>> getNoOfOrdersSold();
  Future<Either<FailureService, AnalyticsResponseModel>> getTotalIncomeSold();
  Future<Either<FailureService, AnalyticsResponseModel>> getNoOfFollowersSold();
  Future<Either<FailureService, AnalyticsResponseModel>>
      getNoOfNotificationSold();
}
