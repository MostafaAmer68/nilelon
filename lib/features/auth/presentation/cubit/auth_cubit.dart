import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/features/auth/domain/model/customer_register_model.dart';
import 'package:nilelon/features/auth/domain/model/login_model.dart';
import 'package:nilelon/features/auth/domain/model/store_register_model.dart';
import 'package:nilelon/features/auth/domain/repos/auth_repos.dart';
import 'package:nilelon/features/categories/presentation/cubit/category_cubit.dart';

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
  String code = '';
  String? dateFormatted;
  DateTime? date;
  File image = File('');
  String base64Image = '';
  bool gender = false;
  final picker = ImagePicker();
  final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final RegExp passwordRegex = RegExp(
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$");
  final RegExp phoneRegex = RegExp(r"^01[0125]\d{8}$");

  Future<void> pickImage(ImageSource imageSource) async {
    emit(PickImageLoading());
    final pickedFile = await picker.pickImage(source: imageSource);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      base64Image = await convertImageToBase64(image);
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
    final base64 = await convertImageToBase64(image);
    var result = await authRepos.updateStore(
      base64,
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
    final base64 = await convertImageToBase64(image);
    var result = await authRepos.updateCustomer(
      base64,
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
      emit(const LoginSuccess('Login Successfully'));
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

      emit(CustomerRegisterSuccess(response));
      BlocProvider.of<CategoryCubit>(context).getCategories();
    });
  }

  Future<void> authStoreRegister(context) async {
    if (!regFormSto.currentState!.validate()) return;
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
