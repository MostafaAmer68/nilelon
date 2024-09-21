import 'dart:io';

import 'package:nilelon/core/service/network/api_service.dart';
import 'package:nilelon/features/search/data/models/search_model.dart';

import '../../../../core/service/network/end_point.dart';

class SearchService {
  final ApiService _apiService;

  SearchService(this._apiService);

  Future<List<SearchModel>> search(String query) async {
    final response = await _apiService.post(
      endPoint: EndPoint.searchUrl,
      query: {
        'searchTxt': query,
      },
    );
    if (response.statusCode == HttpStatus.ok) {
      return List<SearchModel>.from(
          response.data['result'].map((e) => SearchModel.fromMap(e)));
    }
    throw response.data['result'];
  }
}
