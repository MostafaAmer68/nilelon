import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/core/service/background_service.dart';
import 'package:nilelon/features/auth/domain/model/customer_register_model.dart';
import 'package:nilelon/features/auth/domain/model/login_model.dart';
import 'package:nilelon/features/auth/domain/model/store_register_model.dart';
import 'package:nilelon/features/auth/domain/repos/auth_repos.dart';
import 'package:nilelon/features/categories/presentation/cubit/category_cubit.dart';

import '../../domain/model/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepos authRepos;
  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);
  AuthCubit(this.authRepos) : super(AuthInitial());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController whatsappNum = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController profileLinkController = TextEditingController();
  TextEditingController websiteLinkController = TextEditingController();
  TextEditingController repNameController = TextEditingController();
  TextEditingController repPhoneController = TextEditingController();
  TextEditingController wareHouseAddressController = TextEditingController();
  TextEditingController sloganController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> regFormCuts = GlobalKey<FormState>();
  final GlobalKey<FormState> regFormSto = GlobalKey<FormState>();
  final GlobalKey<FormState> loginForm = GlobalKey<FormState>();
  final GlobalKey<FormState> resetPasswordForm = GlobalKey<FormState>();
  String code = '';
  String? dateFormatted;
  DateTime? date;

  bool gender = false;

  final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final RegExp passwordRegex = RegExp(
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$");
  final RegExp phoneRegex = RegExp(r"^01[0125]\d{8}$");

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
      passwordController.clear();
      newPasswordController.clear();
      emit(ResetPasswordSuccess());
      HiveStorage.set(HiveKeys.token, '');
    });
  }

  Future<void> forgotPassword(context, email) async {
    emit(ResetPasswordLoading());

    var result = await authRepos.forgotPassword(
      HiveStorage.get(HiveKeys.token),
      email,
      newPasswordController.text,
      context,
    );
    result.fold((failure) {
      emit(LoginFailure(failure.errorMsg));
    }, (response) {
      newPasswordController.clear();
      emit(ResetPasswordSuccess());
    });
  }

  Future<void> confirmRegisteration(context) async {
    if (regFormCuts.currentState != null &&
            !regFormCuts.currentState!.validate() ||
        regFormSto.currentState != null &&
            !regFormSto.currentState!.validate()) {
      return;
    }

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
    if (!loginForm.currentState!.validate()) return;
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
      emailController.clear();
      passwordController.clear();
      final bool isStore =
          HiveStorage.get<UserModel>(HiveKeys.userModel).role == 'Store';
      final bool isCustomer =
          HiveStorage.get<UserModel>(HiveKeys.userModel).role == 'Customer';
      if (HiveStorage.get(HiveKeys.isStore)) {
        log('store');
        if (isStore) {
          emit(const LoginSuccess('Login Successfully'));
        } else if (!isStore) {
          emit(const LoginFailure('this account not found'));
        }
      } else if (!HiveStorage.get(HiveKeys.isStore)) {
        log('customer');
        if (isCustomer) {
          emit(const LoginSuccess('Login Successfully'));
        } else {
          emit(const LoginFailure('this account not found'));
        }
      }
      // if () {
      //   emit(const LoginSuccess('Login Successfully'));
      // } else {
      //   HiveStorage.set(HiveKeys.userModel, null);
      //   emit(const LoginFailure('this account not found'));
      //   return;
      // }
      BlocProvider.of<CategoryCubit>(context).getCategories();
    });
  }

  Future<void> authCustomerRegister(context) async {
    if (!regFormCuts.currentState!.validate()) return;
    emit(CustomerRegisterLoading());
    var result = await authRepos.customerRegisterRepos(
        CustomerRegisterModel(
          fullName: nameController.text,
          email: emailController.text,
          phoneNumber: phoneController.text,
          whatsappNumber: whatsappNum.text,
          birthDate: date!.toIso8601String(),
          gender: gender,
          password: passwordController.text,
          confirmPassword: confirmPasswordController.text,
        ),
        context);
    result.fold((failure) {
      emit(CustomerRegisterFailure(failure.errorMsg));
    }, (response) {
      // Map<String, dynamic> decodedToken = JwtDecoder.decode(response);
      nameController.clear();
      emailController.clear();
      phoneController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
      emit(CustomerRegisterSuccess(response));
      BlocProvider.of<CategoryCubit>(context).getCategories();
    });
  }

  Future<void> authStoreRegister(context) async {
    // if (!regFormSto.currentState!.validate()) return;
    emit(StoreRegisterLoading());
    var result = await authRepos.storeRegisterRepos(
      StoreRegisterModel(
        fullName: nameController.text,
        email: emailController.text,
        phoneNumber: '+2${phoneController.text}',
        profileLink: profileLinkController.text,
        whatsappNumber: '+2${whatsappNum.text}',
        websiteLink: websiteLinkController.text,
        repName: repNameController.text,
        repPhone: repPhoneController.text,
        warehouseAddress: wareHouseAddressController.text,
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
      ),
      context,
    );
    result.fold((failure) {
      emit(StoreRegisterFailure(failure.errorMsg));
    }, (response) {
      HiveStorage.set(
        HiveKeys.token,
        response,
      );
      emit(StoreRegisterSuccess(response));
      nameController.clear();
      emailController.clear();
      phoneController.clear();
      profileLinkController.clear();
      websiteLinkController.clear();
      repNameController.clear();
      repPhoneController.clear();
      wareHouseAddressController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
      BlocProvider.of<CategoryCubit>(context).getCategories();
    });
  }

  Future<void> signUpWithGoogle(context) async {
    emit(GoogleRegisterLoading());
    var result = await authRepos.googleRegisterAuth();
    result.fold((failure) {
      emit(GoogleRegisterFailure(failure.errorMsg));
    }, (response) {
      // HiveStorage.set(
      //   HiveKeys.token,
      //   response,
      // );
      emit(GoogleRegisterSuccess(response));
      BlocProvider.of<CategoryCubit>(context).getCategories();
    });
  }

  Future<void> signInWithGoogle(context) async {
    emit(GoogleInLoading());
    var result = await authRepos.signInGoogleAuth();
    result.fold((failure) {
      emit(GoogleInFailure(failure.errorMsg));
    }, (response) {
      // HiveStorage.set(
      //   HiveKeys.token,
      //   response,
      // );
      emit(GoogleInSuccess(response));
      BlocProvider.of<CategoryCubit>(context).getCategories();
    });
  }
}
