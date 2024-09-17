import 'package:dartz/dartz.dart';
import 'package:nilelon/core/service/failure_service.dart';

abstract class ReccomendationRepos {
  Future<Either<FailureService, String>> setRecommendation(String gender);
}
