import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/features/search/data/models/search_model.dart';
import 'package:nilelon/features/search/data/repositories/search_repo_impl.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  static SearchCubit get(context) => BlocProvider.of(context);
  final SearchRepoImpl _searchRepoImpl;
  SearchCubit(this._searchRepoImpl) : super(SearchInitial());

  List<SearchModel> searchResult = [];

  TextEditingController searchC = TextEditingController();

  // Cache to store search results
  final Map<String, List<SearchModel>> _cache = {};

  Future<void> search() async {
    if (searchC.text.isEmpty) {
      emit(SearchInitial());
      return;
    }
    emit(SearchLoading());

    // Check if query is already in cache
    if (_cache.containsKey(searchC.text)) {
      // Return cached result
      searchResult = _cache[searchC.text]!;
      emit(SearchSuccess());
      return;
    }

    // If not in cache, make API request
    final response = await _searchRepoImpl.search(searchC.text);

    response.fold(
      (failure) {
        emit(SearchFailure(failure.errorMsg));
      },
      (result) {
        // Cache the result with query as the key
        _cache[searchC.text] = result;
        searchResult = result;
        emit(SearchSuccess());
      },
    );
  }
}
