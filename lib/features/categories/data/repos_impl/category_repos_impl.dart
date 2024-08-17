import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nilelon/features/categories/data/remote_data_source/category_remote_data_source.dart';
import 'package:nilelon/features/categories/domain/model/category_model.dart';
import 'package:nilelon/features/categories/domain/repos/category_repos.dart';
import 'package:nilelon/service/failure_service.dart';

class CategoryReposImpl extends CategoryRepos {
  final CategoryRemoteDataSourceImpl chooseCategoryRemoteDataSource;

  CategoryReposImpl(this.chooseCategoryRemoteDataSource);
  @override
  Future<Either<FailureService, CategoryModel>> getCategoryRepos() async {
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
