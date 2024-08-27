import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nilelon/core/service/network/api_service.dart';
import 'package:nilelon/features/auth/domain/model/user_model.dart';
import 'package:nilelon/features/profile/data/models/store_profile.dart';

import '../../../../core/data/hive_stroage.dart';
import '../../../../core/service/network/end_point.dart';
import '../../../../core/widgets/alert/error_alert.dart';

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

  Future<StoreProfile> getStoreById(String storeId) async {
    final response = await _apiService.get(
      endPoint: EndPoint.getStoreByIdUrl,
      query: {
        "id": storeId,
      },
    );
    if (response.statusCode == 200) {
      return StoreProfile.fromMap(response.data['result']);
    } else {
      // Handle other status codes if necessary
      final errorMessage = response.data;
      // errorAlert(context, errorMessage);
      throw Exception(' $errorMessage');
    }
  }

  Future<void> followStore(storeId) async {
    final response = await _apiService.post(
      endPoint: EndPoint.follow,
      body: {
        'isNotify': false,
        "storeId": storeId,
        "customerId": JwtDecoder.decode(
            HiveStorage.get<UserModel>(HiveKeys.userModel).token)['id'],
      },
    );
    if (response.statusCode == 200) {
    } else {
      // Handle other status codes if necessary
      final errorMessage = response.data;
      // errorAlert(context, errorMessage);
      throw Exception(' $errorMessage');
    }
  }
}
