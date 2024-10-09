// import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/features/auth/domain/model/user_model.dart';
import 'package:nilelon/features/store_flow/analytics/domain/model/analytics_response_model.dart';
import 'package:nilelon/core/service/network/api_service.dart';
import 'package:nilelon/core/service/network/end_point.dart';

abstract class AnalyticsRemoteDataSource {
  Future<DashboardModel> getDashboardData();
}

class AnalyticsService extends AnalyticsRemoteDataSource {
  final ApiService apiService;

  AnalyticsService({required this.apiService});

  @override
  Future<DashboardModel> getDashboardData() async {
    final data =
        await apiService.get(endPoint: EndPoint.getDashboardDataUrl, query: {
      'storeId': HiveStorage.get<UserModel>(HiveKeys.userModel).id,
    });
    if (data.statusCode == 200) {
      print(data.data['result']);
      return DashboardModel.fromJson(data.data['result']);
    } else if (data.statusCode == 400) {
      // Handle the bad request response
      final errorMessage = data.data;
      // errorAlert(context, errorMessage);
      throw Exception('getNoOfNotificationSold failed: $errorMessage');
    } else {
      // Handle other status codes if necessary
      throw Exception(
          'Failed to getNoOfNotificationSold: Unexpected status code ${data.statusCode}');
    }
  }
}
