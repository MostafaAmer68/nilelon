import 'package:nilelon/core/service/network/api_service.dart';
import 'package:nilelon/core/service/network/end_point.dart';

import '../../domain/model/result.dart';

class CategoryService {
  final ApiService apiService;

  CategoryService({required this.apiService});
  Future<List<CategoryModel>> getAllCategories() async {
    final data = await apiService.get(
      endPoint: EndPoint.getAllCategoriesUrl,
    );
    if (data.statusCode == 200) {
      return List<CategoryModel>.from(
          data.data['result'].map((e) => CategoryModel.fromMap(e)));
    } else {
      // Handle other status codes if necessary
      throw Exception('Unexpected  ${data.data["result"]}');
    }
  }
}
