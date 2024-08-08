import 'package:nilelon/features/auth/domain/model/customer_register_model.dart';
import 'package:nilelon/features/auth/domain/model/external_google_model.dart';
import 'package:nilelon/features/auth/domain/model/login_model.dart';
import 'package:nilelon/features/auth/domain/model/store_register_model.dart';
import 'package:nilelon/service/network/api_service.dart';
import 'package:nilelon/service/network/end_point.dart';
import 'package:nilelon/widgets/alert/error_alert.dart';

abstract class AuthRemoteDataSource {
  Future<String> loginAuth(LoginModel entity, context);
  Future<String> customerRegisterAuth(CustomerRegisterModel entity, context);
  Future<String> storeRegisterAuth(StoreRegisterModel entity, context);
  Future<String> customerRegisterGoogleAuth(
      ExternalGoogleModel entity, context);
  Future<String> confirmRegisteration(String email, context);
  Future<String> validateOtp(String userOtp, String tokenOtp, context);
  // Future<void> otpVerifyUserAuth(String code, String username);
  // Future<void> forgetPasswordAuth(ForgetPasswordModel entity);
  // Future<void> resetPasswordAuth(ResetPasswordModel entity);
  // Future<void> deleteAccountAuth();
  // Future changeAccountNameAuth(String username, String phoneNumber);aa
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final ApiService apiService;

  AuthRemoteDataSourceImpl({required this.apiService});
  @override
  Future<String> loginAuth(LoginModel entity, context) async {
    final data = await apiService.postAuth(
        endPoint: EndPoint.loginUrl, body: entity.toJson());
    if (data.statusCode == 200) {
      return data.data as String;
    } else if (data.statusCode == 400) {
      // Handle the bad request response
      final errorMessage = data.data;
      errorAlert(context, errorMessage);
      throw Exception('Login failed: $errorMessage');
    } else {
      // Handle other status codes if necessary
      throw Exception(
          'Failed to login: Unexpected status code ${data.statusCode}');
    }
  }

  @override
  Future<String> customerRegisterAuth(
      CustomerRegisterModel entity, context) async {
    final data = await apiService.postAuth(
        endPoint: EndPoint.customerRegisterUrl, body: entity.toJson());
    if (data.statusCode == 200) {
      return data.data as String;
    } else if (data.statusCode == 400) {
      // Handle the bad request response
      final errorMessage = data.data;
      errorAlert(context, errorMessage);
      throw Exception('Customer Register failed: $errorMessage');
    } else {
      errorAlert(context, data.statusMessage!);
      // Handle other status codes if necessary
      throw Exception(
          'Failed to Customer Register: Unexpected status code ${data.statusCode}');
    }
  }

  @override
  Future<String> storeRegisterAuth(StoreRegisterModel entity, context) async {
    final data = await apiService.postAuth(
        endPoint: EndPoint.customerRegisterUrl, body: entity.toJson());
    if (data.statusCode == 200) {
      return data.data as String;
    } else if (data.statusCode == 400) {
      // Handle the bad request response
      final errorMessage = data.data;
      errorAlert(context, errorMessage);
      throw Exception('Store Register failed: $errorMessage');
    } else {
      // Handle other status codes if necessary
      throw Exception(
          'Failed to Store Register: Unexpected status code ${data.statusCode}');
    }
  }

  @override
  Future<String> customerRegisterGoogleAuth(
      ExternalGoogleModel entity, context) async {
    final data = await apiService.postAuth(
        endPoint: EndPoint.customerGoogleRegisterUrl, body: entity.toJson());
    if (data.statusCode == 200) {
      return data.data as String;
    } else if (data.statusCode == 400) {
      // Handle the bad request response
      final errorMessage = data.data;
      errorAlert(context, errorMessage);
      throw Exception('Google Register failed: $errorMessage');
    } else {
      // Handle other status codes if necessary
      throw Exception(
          'Failed to Google Register: Unexpected status code ${data.statusCode}');
    }
  }

  @override
  Future<String> confirmRegisteration(String email, context) async {
    final response = await apiService.postAuth(
        endPoint: EndPoint.confirmRegiseration, query: {'email': email});
    if (response.statusCode == 200) {
      return response.data as String;
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

  @override
  Future<String> validateOtp(String userOtp, String tokenOtp, context) async {
    final response = await apiService.postAuth(
        endPoint: EndPoint.validateOTP,
        body: {'userOtp': userOtp, 'tokenOtp': tokenOtp});
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

  // @override
  // Future<void> otpVerifyUserAuth(String code, String username) async {
  //   await apiService.postWithoutToken2(
  //     endPoint: '${Endpoint.verifyUserUrl}?code=$code&userName=$username',
  //   );
  // }

  // @override
  // Future<void> forgetPasswordAuth(ForgetPasswordModel entity) async {
  //   await apiService.postWithoutTokenMap(
  //       endPoint: Endpoint.forgetPasswordUrl, body: entity.toJson());
  // }

  // @override
  // Future<void> resetPasswordAuth(ResetPasswordModel entity) async {
  //   await apiService.postWithoutToken(
  //       endPoint: Endpoint.resetPasswordUrl, body: entity.toJson());
  // }

  // @override
  // Future<void> deleteAccountAuth() async {
  //   await apiService.delete(
  //       endPoint:
  //           '${Endpoint.deleteAccountUrl}${HiveStorage.get(HiveKeys.userId)}');
  // }

  // @override
  // Future changeAccountNameAuth(String username, String phoneNumber) async {
  //   final data = await apiService.postWithToken(
  //       endPoint: Endpoint.registerUrl,
  //       body: {'username': username, 'phoneNumber': phoneNumber},
  //       token: HiveStorage.get(HiveKeys.token));
  //   return data;
  // }
}
