import 'package:dartz/dartz.dart';
import 'package:nilelon/core/service/failure_service.dart';

import '../model/result.dart';

abstract class CategoryRepos {
  Future<Either<FailureService, List<CategoryModel>>> getCategories();
}
