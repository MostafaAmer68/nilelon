import 'package:nilelon/features/store_flow/choose_category/choose_category_model/choose_category_model.dart';
import 'package:nilelon/service/network/api_service.dart';
import 'package:nilelon/service/network/end_point.dart';

abstract class ChooseCategoryRemoteDataSource {
  Future<ChooseCategoryModel> getAllCategories();
}

class ChooseCategoryRemoteDataSourceImpl
    extends ChooseCategoryRemoteDataSource {
  final ApiService apiService;

  ChooseCategoryRemoteDataSourceImpl({required this.apiService});
  @override
  Future<ChooseCategoryModel> getAllCategories() async {
    final data = await apiService.get(
      endPoint: EndPoint.getAllCategoriesUrl,
    );
    print(data);
    if (data.statusCode == 200) {
      return ChooseCategoryModel.fromJson(data.data as Map<String, dynamic>);
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
