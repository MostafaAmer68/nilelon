import 'package:dartz/dartz.dart';
import 'package:nilelon/core/service/catch_func.dart';
import 'package:nilelon/features/categories/data/service/category_service.dart';
import 'package:nilelon/features/categories/domain/repo/category_repos.dart';
import 'package:nilelon/core/service/failure_service.dart';

import '../../domain/model/result.dart';

class CategoryReposImpl extends CategoryRepos {
  final CategoryService _categoryService;

  CategoryReposImpl(this._categoryService);
  @override
  Future<Either<FailureService, List<CategoryModel>>> getCategories() async {
    return exe(() => _categoryService.getAllCategories());
  }
}
