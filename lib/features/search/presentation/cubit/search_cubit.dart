import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/features/search/data/models/search_model.dart';
import 'package:nilelon/features/search/data/repositories/search_repo_impl.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  static SearchCubit get(context) => BlocProvider.of(context);
  final SearchRepoImpl _searchRepoImpl;
  SearchCubit(this._searchRepoImpl) : super(SearchInitial());

  List<SearchModel> searchResult = [];

  // Cache to store search results
  final Map<String, List<SearchModel>> _cache = {};

  Future<void> search(String query) async {
    emit(SearchLoading());

    // Check if query is already in cache
    if (_cache.containsKey(query)) {
      // Return cached result
      searchResult = _cache[query]!;
      log('already searched');
      emit(SearchSuccess());  
      return;
    }

    // If not in cache, make API request
    final response = await _searchRepoImpl.search(query);

    response.fold(
      (failure) {
        emit(SearchFailure(failure.errorMsg));
      },
      (result) {
        // Cache the result with query as the key
        _cache[query] = result;
        searchResult = result;
        emit(SearchSuccess());
      },
    );
  }
}
