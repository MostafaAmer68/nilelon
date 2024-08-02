import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nilelon/data/hive_stroage.dart';
import 'package:nilelon/features/auth/domain/model/customer_register_model.dart';
import 'package:nilelon/features/auth/domain/model/external_google_model.dart';
import 'package:nilelon/features/auth/domain/model/login_model.dart';
import 'package:nilelon/features/auth/domain/model/store_register_model.dart';
import 'package:nilelon/features/auth/domain/repos/auth_repos.dart';
import 'package:nilelon/features/store_flow/choose_category/cubit/choose_category_cubit.dart';
import 'package:nilelon/utils/app_logs.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepos authRepos;
  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);
  AuthCubit(this.authRepos) : super(AuthInitial());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool gender = false;
  DateTime? date;
  String? dateFormatted;
  TextEditingController nameController = TextEditingController();
  TextEditingController profileLinkController = TextEditingController();
  TextEditingController websiteLinkController = TextEditingController();
  TextEditingController repNameController = TextEditingController();
  TextEditingController repPhoneController = TextEditingController();
  TextEditingController wareHouseAddressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController codeController1 = TextEditingController();
  TextEditingController codeController2 = TextEditingController();
  TextEditingController codeController3 = TextEditingController();
  TextEditingController codeController4 = TextEditingController();
  TextEditingController codeController5 = TextEditingController();
  TextEditingController codeController6 = TextEditingController();

  Future<void> confirmRegisteration(context) async {
    emit(LoginLoading());

    var result = await authRepos.confirmRegisteration(
      emailController.text,
      context,
    );
    result.fold((failure) {
      emit(LoginFailure(failure.errorMsg));
    }, (response) {
      emit(VerificationCodeSent());
      HiveStorage.set(HiveKeys.token, response);
    });
  }

  Future<void> validateOtp(context) async {
    emit(LoginLoading());
    String code = codeController1.text +
        codeController2.text +
        codeController3.text +
        codeController4.text +
        codeController5.text +
        codeController6.text;
    var result = await authRepos.validateOtp(
      code,
      HiveStorage.get(HiveKeys.token),
      context,
    );
    result.fold((failure) {
      emit(LoginFailure(failure.errorMsg));
    }, (response) {
      emit(VerificationSuccess());
      HiveStorage.set(HiveKeys.token, response);
    });
  }

  Future<void> authLogin(context) async {
    emit(LoginLoading());

    var result = await authRepos.loginRepos(
      LoginModel(
        email: emailController.text,
        password: passwordController.text,
        connectionId: '',
      ),
      context,
    );
    result.fold((failure) {
      emit(LoginFailure(failure.errorMsg));
    }, (response) {
      emit(const LoginSuccess('Login Successfully'));
      BlocProvider.of<ChooseCategoryCubit>(context).getCategories();
      Map<String, dynamic> decodedToken = JwtDecoder.decode(response);

      HiveStorage.set(
        HiveKeys.role,
        decodedToken['Role'],
      );
      print(decodedToken['Role']);
      print(decodedToken['Id']);
      if (decodedToken['Role'] == 'Customer') {
        HiveStorage.set(
          HiveKeys.isStore,
          false,
        );
      } else {
        HiveStorage.set(
          HiveKeys.isStore,
          true,
        );
      }
      HiveStorage.set(
        HiveKeys.name,
        decodedToken['Full Name'],
      );
      HiveStorage.set(
        HiveKeys.idToken,
        decodedToken['Id'],
      );

      HiveStorage.set(
        HiveKeys.token,
        response,
      );
    });
  }

  Future<void> authCustomerRegister(context) async {
    emit(CustomerRegisterLoading());
    var result = await authRepos.customerRegisterRepos(
        CustomerRegisterModel(
          fullName: nameController.text,
          email: emailController.text,
          phoneNumber: phoneController.text,
          birthDate: date!.toIso8601String(),
          gender: gender,
          password: passwordController.text,
          confirmPassword: confirmPasswordController.text,
        ),
        context);
    result.fold((failure) {
      emit(CustomerRegisterFailure(failure.errorMsg));
    }, (response) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(response);

      HiveStorage.set(
        HiveKeys.role,
        decodedToken['Role'],
      );
      HiveStorage.set(
        HiveKeys.name,
        decodedToken['Full Name'],
      );
      HiveStorage.set(
        HiveKeys.idToken,
        decodedToken['Id'],
      );
      HiveStorage.set(
        HiveKeys.token,
        response,
      );
      print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
      emit(CustomerRegisterSuccess(response));
      BlocProvider.of<ChooseCategoryCubit>(context).getCategories();
    });
  }

  Future<void> authStoreRegister(context) async {
    emit(StoreRegisterLoading());
    var result = await authRepos.storeRegisterRepos(
        StoreRegisterModel(
          fullName: nameController.text,
          email: emailController.text,
          phoneNumber: '+${phoneController.text}',
          profileLink: profileLinkController.text,
          websiteLink: websiteLinkController.text,
          repName: repNameController.text,
          repPhone: repNameController.text,
          warehouseAddress: wareHouseAddressController.text,
          password: passwordController.text,
          confirmPassword: confirmPasswordController.text,
        ),
        context);
    result.fold((failure) {
      emit(StoreRegisterFailure(failure.errorMsg));
    }, (response) {
      HiveStorage.set(
        HiveKeys.token,
        response,
      );
      print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
      emit(StoreRegisterSuccess(response));
      BlocProvider.of<ChooseCategoryCubit>(context).getCategories();
    });
  }

  Future<void> authStoreGoogleRegister(
      context, String provider, String idToken) async {
    emit(StoreGoogleRegisterLoading());
    var result = await authRepos.customerRegisterGoogleAuth(
        ExternalGoogleModel(
            connectionId: null, provider: provider, idToken: idToken),
        context);
    result.fold((failure) {
      emit(StoreGoogleRegisterFailure(failure.errorMsg));
    }, (response) {
      HiveStorage.set(
        HiveKeys.token,
        response,
      );
      print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
      emit(StoreGoogleRegisterSuccess(response));
      BlocProvider.of<ChooseCategoryCubit>(context).getCategories();
    });
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    // serverClientId:
    //     '839582728023-t0hk32bfb8n9q8vd6mheftnqu8v03im3.apps.googleusercontent.com',
    scopes: [
      // 'profile',
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/userinfo.profile',
      'https://www.googleapis.com/auth/devstorage.full_control',
    ],
  );
  Future<void> signInWithGoogle(context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print('User canceled the sign-in');
        return;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      AppLogs.scussessLog(googleAuth.toString());

      print('Google Auth: $googleAuth');
      print('Google Auth idToken: ${googleAuth.idToken}');
      print('Google Auth accessToken: ${googleAuth.accessToken}');

      await authStoreGoogleRegister(
        context,
        'GOOGLE',
        googleAuth.accessToken.toString(),
      );
      // Send the token to the backend
      // await sendTokenToBackend(googleAuth.idToken!);
    } catch (error) {
      print(error);
    }
  }

  // Future<void> authVerifyUser() async {
  //   emit(VerifyUserLoading());
  //   var result = await authRepos.otpVerifyUserRepos(
  //     codeController1.text +
  //         codeController2.text +
  //         codeController3.text +
  //         codeController4.text +
  //         codeController5.text,
  //     HiveStorage.get(
  //       HiveKeys.username,
  //     ),
  //   );
  //   result.fold((failure) {
  //     emit(VerifyUserFailure(failure.errorMsg));
  //   }, (response) {
  //     emit(VerifyUserSuccess());
  //   });
  // }

  // Future<void> authForgetPassword() async {
  //   emit(ForgetPasswordLoading());
  //   var result = await authRepos.forgetPasswordAuth(ForgetPasswordModel(
  //       phoneNumber: '$countryCode${phoneController.text}'));
  //   HiveStorage.set(HiveKeys.phone, '$countryCode${phoneController.text}');
  //   result.fold((failure) {
  //     emit(ForgetPasswordFailure(failure.errorMsg));
  //   }, (response) {
  //     emit(ForgetPasswordSuccess());
  //   });
  // }

  // Future<void> authResetPassword() async {
  //   emit(ResetPasswordLoading());
  //   var result = await authRepos.resetPasswordAuth(ResetPasswordModel(
  //     phoneNumber: HiveStorage.get(HiveKeys.phone),
  //     password: passwordController.text,
  //     code: HiveStorage.get(HiveKeys.otp),
  //   ));
  //   result.fold((failure) {
  //     emit(ResetPasswordFailure(failure.errorMsg));
  //   }, (response) {
  //     emit(ResetPasswordSuccess());
  //   });
  // }

  // Future<void> authDeleteAccount() async {
  //   emit(DeleteAccountLoading());
  //   var result = await authRepos.deleteAccountAuth();
  //   result.fold((failure) {
  //     emit(DeleteAccountFailure(failure.errorMsg));
  //   }, (response) {
  //     emit(DeleteAccountSuccess());
  //   });
  // }

  // Future<void> changeAccountName() async {
  //   emit(ChangeAccountNameLoading());
  //   var result = await authRepos.changeAccountNameAuth(
  //     emailController.text,
  //     phoneController.text,
  //   );
  //   result.fold((failure) {
  //     emit(ChangeAccountNameFailure(failure.errorMsg));
  //   }, (response) {
  //     emit(ChangeAccountNameSuccess());
  //   });
  // }
}
