// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:nilelon/core/service/failure_service.dart';
import 'package:nilelon/features/shared/recommendation/data/remote_data_source/recommendation_remot_data_source.dart';
import 'package:nilelon/features/shared/recommendation/domain/repos/reccomendation_repos.dart';

class RecommendationReposImpl extends ReccomendationRepos {
  RecommendationRemoteDataSource recommendationRemoteDataSource;
  RecommendationReposImpl(
    this.recommendationRemoteDataSource,
  );
  @override
  Future<Either<FailureService, String>> setRecommendation(
      String gender) async {
    try {
      final result =
          await recommendationRemoteDataSource.setRecommendation(gender);
      // print(result);
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
