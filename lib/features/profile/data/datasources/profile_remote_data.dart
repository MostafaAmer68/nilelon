import 'dart:developer';

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
      'id': HiveStorage.get<UserModel>(HiveKeys.userModel).id,
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
        "storeId": HiveStorage.get<UserModel>(HiveKeys.userModel).id,
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
        "storeId": HiveStorage.get<UserModel>(HiveKeys.userModel).id,
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
        "storeId": storeId,
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

  Future<Map<String, dynamic>> getStoreForCustomer(String storeId) async {
    final response = await _apiService.get(
      endPoint: EndPoint.getStoreForCustomer,
      query: {
        "storeId": storeId,
        "customerId": HiveStorage.get<UserModel>(HiveKeys.userModel).id,
      },
    );
    if (response.statusCode == 200) {
      return {
        'isFollow': response.data['result']['isFollowing'],
        'isNotify': response.data['result']['isNotified'],
      };
    } else {
      // Handle other status codes if necessary
      final errorMessage = response.data;
      // errorAlert(context, errorMessage);
      throw Exception(' $errorMessage');
    }
  }

  Future<String> followStore(storeId) async {
    final response = await _apiService.post(
      endPoint: EndPoint.follow,
      query: {
        "storeId": storeId,
        "customerId": HiveStorage.get<UserModel>(HiveKeys.userModel).id,
      },
    );
    if (response.statusCode == 200) {
      return response.data['result'];
    } else {
      // Handle other status codes if necessary
      final errorMessage = response.data;
      // errorAlert(context, errorMessage);
      throw Exception(' $errorMessage');
    }
  }

  Future<List<StoreProfile>> getStores(int page, int pageSize) async {
    final response = await _apiService.get(
      endPoint: EndPoint.getStoresUrls,
      query: {
        "page": page,
        "pageSize": pageSize,
      },
    );
    if (response.statusCode == 200) {
      log(response.data['result'].toString());
      return List<StoreProfile>.from(
          response.data['result'].map((e) => StoreProfile.fromMap(e)));
    } else {
      // Handle other status codes if necessary
      final errorMessage = response.data;
      // errorAlert(context, errorMessage);
      throw Exception(' $errorMessage');
    }
  }
}
