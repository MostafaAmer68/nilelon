import 'package:nilelon/data/hive_stroage.dart';
import 'package:nilelon/features/store_flow/analytics/model/analytics_response_model.dart';
import 'package:nilelon/service/network/api_service.dart';
import 'package:nilelon/service/network/end_point.dart';

abstract class AnalyticsRemoteDataSource {
  Future<AnalyticsResponseModel> getNoOfItemsSold();
  Future<AnalyticsResponseModel> getNoOfOrdersSold();
  Future<AnalyticsResponseModel> getTotalIncomeSold();
  Future<AnalyticsResponseModel> getNoOfFollowersSold();
  Future<AnalyticsResponseModel> getNoOfNotificationSold();
}

class AnalyticsRemoteDataSourceImpl extends AnalyticsRemoteDataSource {
  final ApiService apiService;

  AnalyticsRemoteDataSourceImpl({required this.apiService});

  @override
  Future<AnalyticsResponseModel> getNoOfItemsSold() async {
    final data = await apiService.get(
      endPoint: '${EndPoint.noOfItemsSold}${HiveStorage.get(HiveKeys.idToken)}',
    );
    print(data);
    if (data.statusCode == 200) {
      return AnalyticsResponseModel.fromJson(data.data as Map<String, dynamic>);
    } else if (data.statusCode == 400) {
      // Handle the bad request response
      final errorMessage = data.data;
      // errorAlert(context, errorMessage);
      throw Exception('getNoOfItemsSold failed: $errorMessage');
    } else {
      // Handle other status codes if necessary
      throw Exception(
          'Failed to getNoOfItemsSold: Unexpected status code ${data.statusCode}');
    }
  }

  @override
  Future<AnalyticsResponseModel> getNoOfOrdersSold() async {
    final data = await apiService.get(
      endPoint:
          '${EndPoint.noOfOrdersSold}${HiveStorage.get(HiveKeys.idToken)}',
    );
    print(data);
    if (data.statusCode == 200) {
      return AnalyticsResponseModel.fromJson(data.data as Map<String, dynamic>);
    } else if (data.statusCode == 400) {
      // Handle the bad request response
      final errorMessage = data.data;
      // errorAlert(context, errorMessage);
      throw Exception('getNoOfOrdersSold failed: $errorMessage');
    } else {
      // Handle other status codes if necessary
      throw Exception(
          'Failed to getNoOfOrdersSold: Unexpected status code ${data.statusCode}');
    }
  }

  @override
  Future<AnalyticsResponseModel> getTotalIncomeSold() async {
    final data = await apiService.get(
      endPoint:
          '${EndPoint.totalIncomeSold}${HiveStorage.get(HiveKeys.idToken)}',
    );
    print(data);
    if (data.statusCode == 200) {
      return AnalyticsResponseModel.fromJson(data.data as Map<String, dynamic>);
    } else if (data.statusCode == 400) {
      // Handle the bad request response
      final errorMessage = data.data;
      // errorAlert(context, errorMessage);
      throw Exception('getTotalIncomeSold failed: $errorMessage');
    } else {
      // Handle other status codes if necessary
      throw Exception(
          'Failed to getTotalIncomeSold: Unexpected status code ${data.statusCode}');
    }
  }

  @override
  Future<AnalyticsResponseModel> getNoOfFollowersSold() async {
    final data = await apiService.get(
      endPoint:
          '${EndPoint.noOfFollowersSold}${HiveStorage.get(HiveKeys.idToken)}',
    );
    print(data);
    if (data.statusCode == 200) {
      return AnalyticsResponseModel.fromJson(data.data as Map<String, dynamic>);
    } else if (data.statusCode == 400) {
      // Handle the bad request response
      final errorMessage = data.data;
      // errorAlert(context, errorMessage);
      throw Exception('getNoOfFollowersSold failed: $errorMessage');
    } else {
      // Handle other status codes if necessary
      throw Exception(
          'Failed to getNoOfFollowersSold: Unexpected status code ${data.statusCode}');
    }
  }

  @override
  Future<AnalyticsResponseModel> getNoOfNotificationSold() async {
    final data = await apiService.get(
      endPoint:
          '${EndPoint.noOfNotificationSold}${HiveStorage.get(HiveKeys.idToken)}',
    );
    print(data);
    if (data.statusCode == 200) {
      return AnalyticsResponseModel.fromJson(data.data as Map<String, dynamic>);
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
