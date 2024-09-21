import 'package:dartz/dartz.dart';
import 'package:nilelon/features/search/data/models/search_model.dart';

import '../../../../core/service/failure_service.dart';

abstract class SearchRepo {
  Future<Either<ServerFailure, List<SearchModel>>> search(String query);
}
