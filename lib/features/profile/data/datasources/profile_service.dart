import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:nilelon/core/service/network/api_service.dart';
import 'package:nilelon/features/auth/domain/model/user_model.dart';
import 'package:nilelon/features/profile/data/models/store_profile_model.dart';

import '../../../../core/data/hive_stroage.dart';
import '../../../../core/service/network/end_point.dart';
import '../../../../core/tools.dart';
import '../../../../core/widgets/alert/error_alert.dart';
import '../models/address_model.dart';

class ProfileService {
  final ApiService _apiService;

  ProfileService(this._apiService);

  Future<String> resetPasswordEmail(String email, context) async {
    final Response response = await _apiService
        .post(endPoint: EndPoint.resetPasswordEmailUrl, query: {
      'email': email,
    });
    if (response.statusCode == 200) {
      return response.data as String;
    }
    //  errorAlert(context, errorMessage);
    throw Exception('Unexpected: ${response.data}');
  }

  Future<String> resetPasswordPhone(String phone, context) async {
    final Response response = await _apiService
        .post(endPoint: EndPoint.resetPasswordPhoneUrl, query: {
      'phone': '+2${phone.startsWith('0') ? '' : '0'}$phone',
    });
    if (response.statusCode == 200) {
      return response.data as String;
    }
    throw Exception('Unexpected: ${response.data}');
  }

  Future<String> sendOtpToEmail(String email, context) async {
    final model = HiveStorage.get(HiveKeys.isStore)
        ? currentUsr<StoreModel>()
        : currentUsr<CustomerModel>();
    final response =
        await _apiService.post(endPoint: EndPoint.resetEmailUrl, body: {
      "tergetSend": model.email,
      "userId": HiveStorage.get<UserModel>(HiveKeys.userModel).id,
      "newValue": email,
    });
    if (response.statusCode == 200) {
      return response.data;
    } else if (response.statusCode == 400) {
      // Handle the bad request response
      final errorMessage = response.data;
      errorAlert(context, errorMessage);
      throw Exception('Google Register failed: $errorMessage');
    } else {
      // Handle other status codes if necessary
      throw Exception(
          'Failed to Google Register: Unexpected status code ${response.statusCode}');
    }
  }

  Future<String> resetPhone(String newValue, context) async {
    final model = HiveStorage.get(HiveKeys.isStore)
        ? currentUsr<StoreModel>()
        : currentUsr<CustomerModel>();
    final response =
        await _apiService.post(endPoint: EndPoint.resetPhoneUrl, body: {
      "tergetSend": model.email,
      "userId": HiveStorage.get<UserModel>(HiveKeys.userModel).id,
      "newValue": newValue,
    });
    if (response.statusCode == 200) {
      return 'Thank you for verifcation';
    } else if (response.statusCode == 400) {
      // Handle the bad request response
      final errorMessage = response.data;
      errorAlert(context, errorMessage);
      throw Exception('Google Register failed: $errorMessage');
    } else {
      // Handle other status codes if necessary
      throw Exception(
          'Failed to Google Register: Unexpected status code ${response.statusCode}');
    }
  }

  Future<String> validateEmail(String newValue, context) async {
    final response =
        await _apiService.post(endPoint: EndPoint.validateEmailUrl, body: {
      'token': HiveStorage.get(HiveKeys.token),
      'targetValue': HiveStorage.get<UserModel>(HiveKeys.userModel).id,
      'newValue': newValue,
    });
    if (response.statusCode == 200) {
      return 'Thank you for verifcation';
    } else if (response.statusCode == 400) {
      // Handle the bad request response
      final errorMessage = response.data;
      errorAlert(context, errorMessage);
      throw Exception('Google Register failed: $errorMessage');
    } else {
      // Handle other status codes if necessary
      throw Exception(
          'Failed to Google Register: Unexpected status code ${response.statusCode}');
    }
  }

  Future<String> validatePhone(
      String token, String targetValue, String newValue, context) async {
    final response =
        await _apiService.post(endPoint: EndPoint.validatePhoneUrl, body: {
      'token': token,
      'targetValue': targetValue,
      'newValue': newValue,
    });
    if (response.statusCode == 200) {
      return 'Thank you for verifcation';
    } else if (response.statusCode == 400) {
      // Handle the bad request response
      final errorMessage = response.data;
      errorAlert(context, errorMessage);
      throw Exception('Google Register failed: $errorMessage');
    } else {
      // Handle other status codes if necessary
      throw Exception(
          'Failed to Google Register: Unexpected status code ${response.statusCode}');
    }
  }

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
      body: {
        "storeId": HiveStorage.get<UserModel>(HiveKeys.userModel).id,
        "repName": repName,
        "repNumber": repNumber,
        "websiteLink": webLink
      },
    );
    if (response.statusCode == 200) {
      final newUsr = response.data['result'];
      final usr = HiveStorage.get<UserModel>(HiveKeys.userModel);
      HiveStorage.set(
          HiveKeys.userModel,
          usr.copyWith(
            userData: StoreModel.fromMap(newUsr),
          ));
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
      body: {
        "storeId": HiveStorage.get<UserModel>(HiveKeys.userModel).id,
        "profilePic": profilePic,
        "name": name,
        "storeSlogan": storeSlogan
      },
    );
    if (response.statusCode == 200) {
      final newUsr = response.data['result'];
      final usr = HiveStorage.get<UserModel>(HiveKeys.userModel);
      HiveStorage.set(
          HiveKeys.userModel,
          usr.copyWith(
            userData: StoreModel.fromMap(newUsr),
          ));
      return '';
    } else {
      // Handle other status codes if necessary
      final errorMessage = response.data;
      errorAlert(context, errorMessage);
      throw Exception(' $errorMessage');
    }
  }

  Future<String> updateCustomer(String profilePic, String name, context) async {
    final response = await _apiService.put(
      endPoint: EndPoint.updateCustomerUrl,
      body: {
        "id": HiveStorage.get<UserModel>(HiveKeys.userModel).id,
        "profilePicture": profilePic,
        "name": name,
      },
    );
    if (response.statusCode == 200) {
      final s = HiveStorage.get<UserModel>(HiveKeys.userModel);
      if (response.data['result'] is Map<String, dynamic>) {
        final userModel = UserModel(
          id: s.id,
          token: s.token,
          role: s.role,
          userData: CustomerModel.fromMap(
            response.data['result'],
          ),
        );
        HiveStorage.set(
          HiveKeys.userModel,
          userModel,
        );
      } else {
        throw response.data['errorMessages'];
      }
      return '';
    } else {
      // Handle other status codes if necessary
      final errorMessage = response.data;
      errorAlert(context, errorMessage);
      throw Exception(' $errorMessage');
    }
  }

  Future<StoreProfileModel> getStoreById(String storeId) async {
    final response = await _apiService.get(
      endPoint: EndPoint.getStoreByIdUrl,
      query: {
        "storeId": storeId,
      },
    );
    if (response.statusCode == 200) {
      return StoreProfileModel.fromMap(response.data['result']);
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

  Future<void> setCustomerAddress(Map<String, dynamic> data) async {
    final response = await _apiService.post(
        endPoint: EndPoint.setCustomerAddressUrl, body: data);
    if (response.statusCode == 200) {
      // return response.data['result'];
    } else {
      // Handle other status codes if necessary
      final errorMessage = response.data;
      // errorAlert(context, errorMessage);
      throw Exception(' $errorMessage');
    }
  }

  Future<AddressModel> getCustomerAddress() async {
    final response = await _apiService.post(
        endPoint: EndPoint.getCustomerAddressUrl,
        query: {'id': HiveStorage.get<UserModel>(HiveKeys.userModel).id});
    if (response.statusCode == 200) {
      return AddressModel.fromMap(response.data['result']);
    } else {
      // Handle other status codes if necessary
      final errorMessage = response.data;
      // errorAlert(context, errorMessage);
      throw Exception(' $errorMessage');
    }
  }

  Future<String> notifyStore(storeId) async {
    final response = await _apiService.post(
      endPoint: EndPoint.isNotify,
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

  Future<List<StoreProfileModel>> getStores(int page, int pageSize) async {
    final response = await _apiService.get(
      endPoint: EndPoint.getStoresUrls,
      query: {
        "page": page,
        "pageSize": pageSize,
      },
    );
    if (response.statusCode == 200) {
      log(response.data['result'].toString());
      return List<StoreProfileModel>.from(response.data['result']['data']
          .map((e) => StoreProfileModel.fromMap(e)));
    } else {
      // Handle other status codes if necessary
      final errorMessage = response.data;
      // errorAlert(context, errorMessage);
      throw Exception(' $errorMessage');
    }
  }
}
