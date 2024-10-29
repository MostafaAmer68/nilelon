import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nilelon/features/categories/domain/model/result.dart';
import 'package:nilelon/features/profile/data/models/store_profile_model.dart';
import 'package:nilelon/features/profile/data/repositories/profile_repo_impl.dart';

import '../../../../core/data/hive_stroage.dart';
import '../../../../core/helper.dart';

part 'profile_state.dart';
part 'profile_cubit.freezed.dart';

class ProfileCubit extends Cubit<ProfileState> {
  static ProfileCubit get(context) => BlocProvider.of(context);
  final ProfileRepoIMpl _profileRepoIMpl;
  ProfileCubit(this._profileRepoIMpl) : super(const ProfileState.initial());
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
  String followStatus = '';
  StoreProfileModel? storeProfile;
  List<StoreProfileModel> stores = [];
  Map<String, dynamic> validationOption = {
    'isFollow': false,
    'isNotify': false,
  };
  CategoryModel selectedCategory = CategoryModel.empty();
  File image = File('');
  String base64Image = '';
  GlobalKey<FormState> forgotPasswordForm = GlobalKey();
  final picker = ImagePicker();
  Future<void> getStoreById(String storeId) async {
    emit(const ProfileState.loading());
    final result = await _profileRepoIMpl.getStoreById(storeId);
    result.fold((er) {
      emit(ProfileState.failure(er.errorMsg));
    }, (response) {
      storeProfile = response;
      emit(const ProfileState.success());
    });
  }

  Future<void> getStoreForCustomer(String storeId) async {
    emit(const ProfileState.loading());
    final result = await _profileRepoIMpl.getStoreForCustomer(storeId);
    result.fold((er) {
      log(er.errorMsg);
      emit(ProfileState.failure(er.errorMsg));
    }, (response) {
      validationOption = response;
      emit(const ProfileState.initial());
    });
  }

  Future<void> getStores(int page, int pageSize) async {
    emit(const ProfileState.loading());
    final result = await _profileRepoIMpl.getStores(page, pageSize);
    result.fold((er) {
      emit(ProfileState.failure(er.errorMsg));
    }, (response) {
      stores = response;
      emit(const ProfileState.success());
    });
  }

  Future<void> followStore(String storeId) async {
    emit(const ProfileState.loading());
    final result = await _profileRepoIMpl.followStore(storeId);
    result.fold((er) {
      emit(ProfileState.failure(er.errorMsg));
    }, (response) {
      followStatus = response;
      getStoreForCustomer(storeId);
    });
  }

  Future<void> notifyStore(String storeId) async {
    emit(const ProfileState.loading());
    final result = await _profileRepoIMpl.notifyStore(storeId);
    result.fold((er) {
      emit(ProfileState.failure(er.errorMsg));
    }, (response) {
      getStoreForCustomer(storeId);
      // emit(const ProfileState.successFollow());
    });
  }

  Future<void> pickImage(ImageSource imageSource) async {
    emit(const ProfileState.loading());
    final pickedFile = await picker.pickImage(source: imageSource);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      base64Image = await convertImageToBase64(image);
    }
  }

  Future<void> updateStoreInfo(context) async {
    emit(const ProfileState.loading());

    var result = await _profileRepoIMpl.updateStoreInfo(
      repNameController.text,
      phoneController.text,
      websiteLinkController.text,
      context,
    );

    result.fold((failure) {
      emit(ProfileState.failure(failure.errorMsg));
    }, (response) {
      emit(const ProfileState.success());
    });
  }

  Future<void> updateStore(context) async {
    emit(const ProfileState.loading());
    final base64 = await convertImageToBase64(image);
    var result = await _profileRepoIMpl.updateStore(
      base64,
      nameController.text,
      sloganController.text,
      context,
    );

    result.fold((failure) {
      emit(ProfileState.failure(failure.errorMsg));
    }, (response) {
      emit(const ProfileState.success());
    });
  }

  Future<void> updateCustomer(context) async {
    emit(const ProfileState.loading());
    final base64 = await convertImageToBase64(image);
    var result = await _profileRepoIMpl.updateCustomer(
      base64,
      nameController.text,
      context,
    );

    result.fold((failure) {
      emit(ProfileState.failure(failure.errorMsg));
    }, (response) {
      emit(const ProfileState.success());
    });
  }

  Future<void> changePassword(context) async {
    emit(const ProfileState.loading());

    var result = await _profileRepoIMpl.changePassword(
      passwordController.text,
      newPasswordController.text,
      context,
    );

    result.fold((failure) {
      emit(ProfileState.failure(failure.errorMsg));
    }, (response) {
      emit(const ProfileState.loading());
      HiveStorage.set(HiveKeys.token, '');
    });
  }

  Future<void> resetEmail(context) async {
    emit(const ProfileState.initial());
    emit(const ProfileState.loading());

    var result = await _profileRepoIMpl.validateEmail(
      emailController.text,
      context,
    );

    result.fold((failure) {
      emit(ProfileState.failure(failure.errorMsg));
    }, (response) {
      emit(const ProfileState.success());
      HiveStorage.set(HiveKeys.token, '');
    });
  }

  Future<void> sendOtpEmail(context) async {
    emit(const ProfileState.initial());
    emit(const ProfileState.loading());

    var result = await _profileRepoIMpl.sendOtpToEmail(
      emailController.text,
      context,
    );
    result.fold((failure) {
      emit(ProfileState.failure(failure.errorMsg));
    }, (response) {
      emit(const ProfileState.codeSentSuccess());
      HiveStorage.set(HiveKeys.token, response);
    });
  }

  Future<void> resetPhone(context) async {
    emit(const ProfileState.loading());

    // var result = await _profileRepoIMpl.resetPhone(
    //   emailController.text,
    //   context,
    // );

    // result.fold((failure) {
    //   emit(ProfileState.failure(failure.errorMsg));
    // }, (response) {
    //   emit(ResetEmailSuccess());
    //   HiveStorage.set(HiveKeys.token, '');
    // });
  }

  Future<void> sendOtpPhone(context) async {
    emit(const ProfileState.loading());

    var result = await _profileRepoIMpl.sendOtpToEmail(
      emailController.text,
      context,
    );
    result.fold((failure) {
      emit(ProfileState.failure(failure.errorMsg));
    }, (response) {
      emit(const ProfileState.codeSentSuccess());
      HiveStorage.set(HiveKeys.token, response);
    });
  }

  Future<void> resetPasswordPhone(context) async {
    emit(const ProfileState.loading());

    var result = await _profileRepoIMpl.resetPasswordPhone(
      phoneController.text,
      context,
    );
    result.fold((failure) {
      emit(ProfileState.failure(failure.errorMsg));
    }, (response) {
      emit(const ProfileState.success());
      HiveStorage.set(HiveKeys.token, response);
    });
  }

  Future<void> resetPasswordEmail(context) async {
    emit(const ProfileState.loading());

    var result = await _profileRepoIMpl.resetPasswordEmail(
      emailController.text,
      context,
    );
    result.fold((failure) {
      emit(ProfileState.failure(failure.errorMsg));
    }, (response) {
      emit(const ProfileState.success());
      HiveStorage.set(HiveKeys.token, response);
    });
  }
}
