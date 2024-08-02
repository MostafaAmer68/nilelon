import 'dart:io';

import 'package:nilelon/features/categories/data/datasources/category_services.dart';
import 'package:nilelon/features/categories/domain/repositories/category_repo.dart';

class CategoryRepoImpl implements CategoryRepo {
  final CategoryServices _services;

  CategoryRepoImpl(this._services);

  @override
  Future<List<String>> fetchCategories() async {
    try {
      final response = await _services.fetchCategories();
      if (response.response.statusCode == HttpStatus.ok) {
        return response.response.data['result'];
      }
      return [];
    } catch (e) {
      throw e;
    }
  }
}
