// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/core/service/network/api_service.dart';
import 'package:nilelon/core/service/network/end_point.dart';
import 'package:nilelon/features/auth/domain/model/user_model.dart';

abstract class RecommendationRemoteDataSource {
  Future<String> setRecommendation(String gender);
}

class RecommendationService extends RecommendationRemoteDataSource {
  ApiService apiService;
  RecommendationService({
    required this.apiService,
  });
  @override
  Future<String> setRecommendation(String gender) async {
    final data = await apiService.put(
      endPoint:
          '${EndPoint.setRecommendationUrl}${HiveStorage.get<UserModel>(HiveKeys.userModel).id}',
      query: {'gender': gender},
    );
    if (data.statusCode == 200) {
      print(data.data['result']);
      return 'Updated successfully';
    } else if (data.statusCode == 400) {
      // Handle the bad request response
      // final errorMessage = data.data;
      return "Failed to update, Try later";
      // errorAlert(context, errorMessage);
      // throw Exception('getNoOfNotificationSold failed: $errorMessage');
    } else {
      // Handle other status codes if necessary
      return "Failed to update, Try later";

      // throw Exception(
      //     'Failed to getNoOfNotificationSold: Unexpected status code ${data.statusCode}');
    }
  }
}
