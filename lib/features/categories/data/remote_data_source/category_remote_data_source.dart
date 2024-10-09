import 'package:nilelon/features/categories/domain/model/category_model.dart';
import 'package:nilelon/core/service/network/api_service.dart';
import 'package:nilelon/core/service/network/end_point.dart';

class CategoryService {
  final ApiService apiService;

  CategoryService({required this.apiService});
  Future<CategoryModel> getAllCategories() async {
    final data = await apiService.get(
      endPoint: EndPoint.getAllCategoriesUrl,
    );
    if (data.statusCode == 200) {
      return CategoryModel.fromJson(data.data as Map<String, dynamic>);
    } else if (data.statusCode == 400) {
      // Handle the bad request response
      final errorMessage = data.data;
      // errorAlert(context, errorMessage);
      throw Exception('Login failed: $errorMessage');
    } else {
      // Handle other status codes if necessary
      throw Exception(
          'Failed to login: Unexpected status code ${data.statusCode}');
    }
  }
}
