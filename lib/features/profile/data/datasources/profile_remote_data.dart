import 'package:nilelon/service/network/api_service.dart';

import '../../../../data/hive_stroage.dart';
import '../../../../service/network/end_point.dart';
import '../../../../widgets/alert/error_alert.dart';

class ProfileRemoteData {
  final ApiService _apiService;

  ProfileRemoteData(this._apiService);

  Future<String> changePassword(
      String oldPassword, String newPassword, context) async {
    final response =
        await _apiService.post(endPoint: EndPoint.changePasswordUrl, body: {
      'id': HiveStorage.get(HiveKeys.userId),
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    });
    if (response.statusCode == 200) {
      return response.data;
    } else {
      // Handle other status codes if necessary
      final errorMessage = response.data;
      errorAlert(context, errorMessage);
      throw Exception(' $errorMessage');
    }
  }

  Future<String> updateStoreInfo(
      String repName, String repNumber, String webLink, context) async {
    final response = await _apiService.put(
      endPoint: EndPoint.updateStoreInfoUrl,
      data: {
        "storeId": HiveStorage.get(HiveKeys.userId),
        "repName": repName,
        "repNumber": repNumber,
        "websiteLink": webLink
      },
    );
    if (response.statusCode == 200) {
      return '';
    } else {
      // Handle other status codes if necessary
      final errorMessage = response.data;
      errorAlert(context, errorMessage);
      throw Exception(' $errorMessage');
    }
  }

  Future<String> updateStore(
      String profilePic, String name, String storeSlogan, context) async {
    final response = await _apiService.put(
      endPoint: EndPoint.updateStoreUrl,
      data: {
        "storeId": HiveStorage.get(HiveKeys.userId),
        "profilePic": profilePic,
        "name": name,
        "storeSlogan": storeSlogan
      },
    );
    if (response.statusCode == 200) {
      return '';
    } else {
      // Handle other status codes if necessary
      final errorMessage = response.data;
      errorAlert(context, errorMessage);
      throw Exception(' $errorMessage');
    }
  }
}
