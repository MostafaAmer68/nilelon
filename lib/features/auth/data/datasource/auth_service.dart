import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/features/auth/domain/model/customer_register_model.dart';
import 'package:nilelon/features/auth/domain/model/login_model.dart';
import 'package:nilelon/features/auth/domain/model/store_register_model.dart';
import 'package:nilelon/features/auth/domain/model/user_model.dart';
import 'package:nilelon/core/service/network/api_service.dart';
import 'package:nilelon/core/service/network/end_point.dart';
import 'package:nilelon/core/widgets/alert/error_alert.dart';

class AuthService {
  final ApiService apiService;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/userinfo.profile',
    ],
  );

  AuthService({required this.apiService});

  Future<void> loginAuth(LoginModel entity, context) async {
    final data = await apiService.post(
        endPoint: EndPoint.loginUrl, body: entity.toJson());
    if (data.statusCode == 200) {
      UserModel userData;
      // HiveStorage.set(HiveKeys.isStore, data.data['role'] == 'Store');
      // HiveStorage.set(HiveKeys.token, data.data['token']);
      if (data.data['role'] != 'Store') {
        userData = UserModel<CustomerModel>.fromMap(data.data);
        HiveStorage.set(
            HiveKeys.shopFor, data.data['data']['productsChoice'] == 'Male');
      } else {
        userData = UserModel<StoreModel>.fromMap(data.data);
      }
      HiveStorage.set(HiveKeys.userModel, userData);
      final token = const FlutterSecureStorage();
      token.write(key: 'token', value: userData.token);
    } else {
      // Handle other status codes if necessary
      throw Exception(
          'Failed to login: Unexpected status code ${data.statusCode}');
    }
  }

  Future<String> customerRegisterAuth(
      CustomerRegisterModel entity, context) async {
    final data = await apiService.post(
        endPoint: EndPoint.customerRegisterUrl, body: entity.toJson());
    if (data.statusCode == 200) {
      UserModel userData;
      // HiveStorage.set(HiveKeys.isStore, data.data['role'] == 'Store');
      HiveStorage.set(HiveKeys.token, data.data as String);
      userData = UserModel<CustomerModel>(
        id: JwtDecoder.decode(data.data as String)['id'],
        token: data.data as String,
        role: 'Customer',
        userData: CustomerModel(
          name: entity.fullName!,
          email: entity.email!,
          phoneNumber: entity.phoneNumber!,
          dateOfBirth: entity.birthDate!,
          gender: entity.gender! ? 'Male' : 'Female',
          productsChoice: entity.gender! ? 'Male' : 'Female',
          profilePic: '',
        ),
      );
      HiveStorage.set(HiveKeys.shopFor, false);

      HiveStorage.set(HiveKeys.userModel, userData);
      final token = const FlutterSecureStorage();
      token.write(key: 'token', value: data.data);
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

  Future<String> storeRegisterAuth(StoreRegisterModel entity, context) async {
    final data = await apiService.post(
        endPoint: EndPoint.storeRegisterUrl, body: entity.toJson());
    if (data.statusCode == 200) {
      UserModel userData;
      // HiveStorage.set(HiveKeys.isStore, data.data['role'] == 'Store');
      HiveStorage.set(HiveKeys.token, data.data as String);
      userData = UserModel<StoreModel>(
        id: JwtDecoder.decode(data.data as String)['id'],
        token: data.data as String,
        role: 'Customer',
        userData: StoreModel(
          name: entity.fullName!,
          email: entity.email!,
          phoneNumber: entity.phoneNumber!,
          profilePic: '',
          repName: entity.repName!,
          storeSlogan: '',
          repPhone: entity.repPhone!,
          warehouseAddress: entity.warehouseAddress!,
        ),
      );
      HiveStorage.set(HiveKeys.shopFor, false);

      HiveStorage.set(HiveKeys.userModel, userData);
      final token = const FlutterSecureStorage();
      token.write(key: 'token', value: data.data);
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

  Future<String> signUpWithGoogle() async {
    GoogleSignInAccount? account = await _googleSignIn.signIn();
    if (account != null) {
      final data = await apiService
          .post(endPoint: EndPoint.customerGoogleRegisterUrl, body:
                  // account.photoUrl != null
                  //     ?
                  {
        "provider": "Google",
        "name": account.displayName,
        "email": account.email,
        "photo": account.photoUrl,
      }
              // : {
              //     "provider": "Google",
              //     "name": account.displayName,
              //     "email": account.email,
              //   },
              );
      if (data.statusCode == 200) {
        UserModel userData;
        // HiveStorage.set(HiveKeys.isStore, data.data['role'] == 'Store');
        HiveStorage.set(HiveKeys.token, data.data as String);
        userData = UserModel<CustomerModel>(
          id: JwtDecoder.decode(data.data as String)['id'],
          token: data.data as String,
          role: 'Customer',
          userData: CustomerModel(
            name: account.displayName ?? '',
            email: account.email,
            phoneNumber: '',
            dateOfBirth: '',
            gender: 'Male',
            productsChoice: 'Male',
            profilePic: account.photoUrl ?? '',
          ),
        );
        HiveStorage.set(HiveKeys.shopFor, false);

        HiveStorage.set(HiveKeys.userModel, userData);
        return data.data as String;
      } else if (data.statusCode == 400) {
        // Handle the bad request response
        final errorMessage = data.data;
        // errorAlert(context, errorMessage);
        throw Exception('Customer Register failed: $errorMessage');
      } else {
        // errorAlert(context, data.statusMessage!);
        // Handle other status codes if necessary
        throw Exception(
            'Failed to Customer Register: Unexpected status code ${data.statusCode}');
      }
    }
    return 'Something went wrong';
  }

  Future<String> signInWithGoogle() async {
    GoogleSignInAccount? account = await _googleSignIn.signIn();
    if (account != null) {
      final data = await apiService.post(
        endPoint: EndPoint.loginUrl,
        body: {
          'email': account.email,
          'connectionId': '',
          'password': '',
        },
      );
      if (data.statusCode == 200) {
        UserModel userData;
        // HiveStorage.set(HiveKeys.isStore, data.data['role'] == 'Store');
        HiveStorage.set(HiveKeys.token, data.data['token']);
        if (data.data['role'] != 'Store') {
          userData = UserModel<CustomerModel>.fromMap(data.data);
          HiveStorage.set(
              HiveKeys.shopFor, data.data['data']['productsChoice'] == 'Male');
        } else {
          userData = UserModel<StoreModel>.fromMap(data.data);
        }
        HiveStorage.set(HiveKeys.userModel, userData);
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
    return 'Something went wrong';
  }

  Future<String> confirmRegisteration(String email, context) async {
    final response = await apiService
        .post(endPoint: EndPoint.confirmRegiseration, query: {'email': email});
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

  Future<String> validateOtp(String userOtp, String tokenOtp, context) async {
    final response = await apiService.post(
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

  Future<String> forgotPassword(
      String token, String targetValue, String newValue, context) async {
    final response =
        await apiService.post(endPoint: EndPoint.forgotPasswordUrl, body: {
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
        await apiService.post(endPoint: EndPoint.changePasswordUrl, body: {
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
}
