import 'package:dartz/dartz.dart';
import 'package:nilelon/service/failure_service.dart';

import '../model/category_model.dart';

abstract class CategoryRepos {
  Future<Either<FailureService, CategoryModel>> getCategoryRepos();
}
