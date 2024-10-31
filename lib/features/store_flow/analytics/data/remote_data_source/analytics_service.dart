// import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:intl/intl.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/features/auth/domain/model/user_model.dart';
import 'package:nilelon/features/store_flow/analytics/domain/model/analytics_response_model.dart';
import 'package:nilelon/core/service/network/api_service.dart';
import 'package:nilelon/core/service/network/end_point.dart';

abstract class AnalyticsRemoteDataSource {
  Future<DashboardModel> getDashboardData();
  Future<List<num>> getChartData(DateTime endDate, DateTime startDate);
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
      if (data.data['result'] != null) {
        return DashboardModel.fromJson(data.data['result']);
      }
      throw data.data['errorMessages'].first;
    }
    throw data.data['errorMessages'].first;
  }

  @override
  Future<List<num>> getChartData(DateTime endDate, DateTime startDate) async {
    final data =
        await apiService.get(endPoint: EndPoint.getChartDataUrl, query: {
      'storeId': HiveStorage.get<UserModel>(HiveKeys.userModel).id,
      'startDate': DateFormat().format(startDate),
      'endDate': DateFormat().format(endDate),
    });
    if (data.statusCode == 200) {
      if (data.data['result'] != null) {
        return List<num>.from(data.data['result'].map((e) => e));
      }
      throw data.data['errorMessages'].first;
    }
    throw data.data['errorMessages'].first;
  }
}
