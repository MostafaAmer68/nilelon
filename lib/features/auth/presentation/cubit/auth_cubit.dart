import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nilelon/data/hive_stroage.dart';
import 'package:nilelon/features/auth/domain/model/customer_register_model.dart';
import 'package:nilelon/features/auth/domain/model/external_google_model.dart';
import 'package:nilelon/features/auth/domain/model/login_model.dart';
import 'package:nilelon/features/auth/domain/model/store_register_model.dart';
import 'package:nilelon/features/auth/domain/repos/auth_repos.dart';
import 'package:nilelon/features/store_flow/choose_category/cubit/choose_category_cubit.dart';
import 'package:nilelon/utils/app_logs.dart';

import '../../../../core/helper.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepos authRepos;
  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);
  AuthCubit(this.authRepos) : super(AuthInitial());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
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
  TextEditingController sloganController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String code = '';
  File image = File('');
  String base64Image = '';
  final picker = ImagePicker();

 

  Future<void> pickImage(ImageSource imageSource) async {
    emit(PickImageLoading());
    final pickedFile = await picker.pickImage(source: imageSource);

    if (pickedFile != null) {
      image = File(pickedFile.path);
    base64Image=  await convertImageToBase64(image);
    }
  }

  Future<void> updateStoreInfo(context) async {
    emit(LoginLoading());

    var result = await authRepos.updateStoreInfo(
      repNameController.text,
      phoneController.text,
      websiteLinkController.text,
      context,
    );

    result.fold((failure) {
      emit(LoginFailure(failure.errorMsg));
    }, (response) {
      emit(UpdateStoreSuccess());
    });
  }

  Future<void> updateStore(context) async {
    emit(LoginLoading());

    var result = await authRepos.updateStore(
      base64Image,
      nameController.text,
      sloganController.text,
      context,
    );

    result.fold((failure) {
      emit(LoginFailure(failure.errorMsg));
    }, (response) {
      emit(UpdateStoreSuccess());
    });
  }

  Future<void> updateCustomer(context) async {
    emit(LoginLoading());

    var result = await authRepos.updateCustomer(
      base64Image,
      nameController.text,
      context,
    );

    result.fold((failure) {
      emit(LoginFailure(failure.errorMsg));
    }, (response) {
      emit(UpdateStoreSuccess());
    });
  }

  Future<void> changePassword(context) async {
    emit(ResetPasswordLoading());

    var result = await authRepos.changePassword(
      passwordController.text,
      newPasswordController.text,
      context,
    );

    result.fold((failure) {
      emit(LoginFailure(failure.errorMsg));
    }, (response) {
      emit(ResetPasswordSuccess());
      HiveStorage.set(HiveKeys.token, '');
    });
  }

  Future<void> resetEmail(context) async {
    emit(LoginLoading());

    var result = await authRepos.resetEmailDetails(
      emailController.text,
      context,
    );

    result.fold((failure) {
      emit(LoginFailure(failure.errorMsg));
    }, (response) {
      emit(ResetEmailSuccess());
      HiveStorage.set(HiveKeys.token, '');
    });
  }

  Future<void> sendOtpEmail(context) async {
    emit(LoginLoading());

    var result = await authRepos.resetEmail(
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

  Future<void> resetPhone(context) async {
    emit(LoginLoading());

    // var result = await authRepos.resetPhone(
    //   emailController.text,
    //   context,
    // );

    // result.fold((failure) {
    //   emit(LoginFailure(failure.errorMsg));
    // }, (response) {
    //   emit(ResetEmailSuccess());
    //   HiveStorage.set(HiveKeys.token, '');
    // });
  }

  Future<void> sendOtpPhone(context) async {
    emit(LoginLoading());

    var result = await authRepos.resetEmail(
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

  Future<void> resetPasswordPhone(context) async {
    emit(LoginLoading());

    var result = await authRepos.resetPasswordPhone(
      phoneController.text,
      context,
    );
    result.fold((failure) {
      emit(LoginFailure(failure.errorMsg));
    }, (response) {
      emit(VerificationCodeSent());
      HiveStorage.set(HiveKeys.token, response);
    });
  }

  Future<void> resetPasswordEmail(context) async {
    emit(LoginLoading());

    var result = await authRepos.resetPasswordEmail(
      emailController.text,
      context,
    );
    result.fold((failure) {
      emit(LoginFailure(failure.errorMsg));
    }, (response) {
      emit(VerificationCodeSent());
      log(response);
      HiveStorage.set(HiveKeys.token, response);
    });
  }

  Future<void> forgotPassword(context) async {
    emit(ResetPasswordLoading());

    var result = await authRepos.forgotPassword(
      HiveStorage.get(HiveKeys.token),
      emailController.text,
      newPasswordController.text,
      context,
    );
    result.fold((failure) {
      emit(LoginFailure(failure.errorMsg));
    }, (response) {
      emit(ResetPasswordSuccess());
    });
  }

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

    var result = await authRepos.validateOtp(
      code,
      HiveStorage.get(HiveKeys.token),
      context,
    );
    result.fold((failure) {
      emit(LoginFailure(failure.errorMsg));
    }, (response) {
      emit(VerificationSuccess());
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
          phoneNumber: '+2${phoneController.text}',
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
}
