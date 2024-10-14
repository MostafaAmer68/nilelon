import 'package:dartz/dartz.dart';
import 'package:nilelon/core/service/catch_func.dart';
import 'package:nilelon/features/search/data/datasources/search_service.dart';
import 'package:nilelon/features/search/data/models/search_model.dart';
import 'package:nilelon/features/search/domain/repositories/search_repo.dart';

import '../../../../core/service/failure_service.dart';

class SearchRepoImpl implements SearchRepo {
  final SearchService _searchService;

  SearchRepoImpl(this._searchService);

  @override
  @override
  Future<Either<ServerFailure, List<SearchModel>>> search(String query) async {
    return exe(() => _searchService.search(query));
  }
}
