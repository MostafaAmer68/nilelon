import 'package:dartz/dartz.dart';
import 'package:nilelon/core/service/catch_func.dart';
import 'package:nilelon/features/categories/data/remote_data_source/category_remote_data_source.dart';
import 'package:nilelon/features/categories/domain/model/category_model.dart';
import 'package:nilelon/features/categories/domain/repos/category_repos.dart';
import 'package:nilelon/core/service/failure_service.dart';

class CategoryReposImpl extends CategoryRepos {
  final CategoryService _categoryService;

  CategoryReposImpl(this._categoryService);
  @override
  Future<Either<FailureService, CategoryModel>> getCategoryRepos() async {
    return exe(() => _categoryService.getAllCategories());
  }
}
