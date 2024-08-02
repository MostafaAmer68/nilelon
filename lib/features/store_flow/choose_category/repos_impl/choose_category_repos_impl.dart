import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nilelon/features/store_flow/choose_category/choose_category_model/choose_category_model.dart';
import 'package:nilelon/features/store_flow/choose_category/remote_data_source/choose_category_remote_data_source.dart';
import 'package:nilelon/features/store_flow/choose_category/repos/choose_category_repos.dart';
import 'package:nilelon/service/failure_service.dart';

class ChooseCategoryReposImpl extends ChooseCategoryRepos {
  final ChooseCategoryRemoteDataSource chooseCategoryRemoteDataSource;

  ChooseCategoryReposImpl(this.chooseCategoryRemoteDataSource);
  @override
  Future<Either<FailureService, ChooseCategoryModel>> getCategoryRepos() async {
    try {
      final result = await chooseCategoryRemoteDataSource.getAllCategories();
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
