import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nilelon/features/auth/domain/model/user_model.dart';
import 'package:nilelon/features/profile/data/models/store_profile.dart';
import 'package:nilelon/features/profile/data/repositories/profile_repo_impl.dart';

part 'profile_state.dart';
part 'profile_cubit.freezed.dart';

class ProfileCubit extends Cubit<ProfileState> {
  static ProfileCubit get(context) => BlocProvider.of(context);
  final ProfileRepoIMpl _profileRepoIMpl;
  ProfileCubit(this._profileRepoIMpl) : super(const ProfileState.initial());
  StoreProfile? storeProfile;
  Future<void> getStoreById(String storeId) async {
    emit(const ProfileState.loading());
    final result = await _profileRepoIMpl.getStoreById(storeId);
    result.fold((er) {
      emit(const ProfileState.failure());
    }, (response) {
      storeProfile = response;
      emit(const ProfileState.success());
    });
  }

  Future<void> followStore(String storeId) async {
    emit(const ProfileState.loading());
    final result = await _profileRepoIMpl.followStore(storeId);
    result.fold((er) {
      emit(const ProfileState.failure());
    }, (response) {
      emit(const ProfileState.success());
    });
  }
}