import 'package:dartz/dartz.dart';
import 'package:nilelon/features/store_flow/choose_category/choose_category_model/choose_category_model.dart';
import 'package:nilelon/service/failure_service.dart';

abstract class ChooseCategoryRepos {
  Future<Either<FailureService, ChooseCategoryModel>> getCategoryRepos();
}
