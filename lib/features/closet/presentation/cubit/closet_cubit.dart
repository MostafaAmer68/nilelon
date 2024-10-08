// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/features/closet/domain/model/create_closet.dart';

import 'package:nilelon/features/closet/domain/repo/closet_repo.dart';

import '../../../auth/domain/model/user_model.dart';
import '../../../product/domain/models/product_model.dart';
import '../../domain/model/closet_model.dart';

part 'closet_cubit.freezed.dart';
part 'closet_state.dart';

class ClosetCubit extends Cubit<ClosetState> {
  static ClosetCubit get(context) => BlocProvider.of<ClosetCubit>(context);
  final TextEditingController closetName = TextEditingController();
  final ClosetRepo repo;
  ClosetCubit(
    this.repo,
  ) : super(const ClosetState.initial());
  List<ClosetModel> closets = [];
  ClosetModel closet = const ClosetModel(id: '', name: '');
  List<ProductModel> closetsItem = [];
  Future<void> getclosets() async {
    emit(const ClosetState.loading());
    final data = await repo.getCustomerCloset();
    data.fold((error) {
      emit(const ClosetState.failure());
    }, (response) {
      closets = response;
      emit(const ClosetState.success());
    });
  }

  Future<void> createCloset() async {
    emit(const ClosetState.loading());
    final data = await repo.createCloset(CreateCloset(
        name: closetName.text,
        CustomerId: HiveStorage.get<UserModel>(HiveKeys.userModel).id));
    data.fold((error) {
      emit(const ClosetState.failure());
    }, (response) {
      getclosets();
      emit(const ClosetState.success());
    });
  }

  Future<void> deletCloset(String closetId) async {
    emit(const ClosetState.loading());
    final data = await repo.deleteCloset(closetId);
    data.fold((error) {
      emit(const ClosetState.failure());
    }, (response) {
      emit(const ClosetState.success());
    });
  }

  Future<void> deletFromCloset(String closetId, String productId) async {
    emit(const ClosetState.loading());
    final data = await repo.deleteProductFromCloset(closetId, productId);
    data.fold((error) {
      emit(const ClosetState.failure());
    }, (response) {
      emit(const ClosetState.successDelete());
    });
  }

  Future<void> emptyCloset(String closetId) async {
    emit(const ClosetState.loading());
    final data = await repo.emptyCloset(closetId);
    data.fold((error) {
      emit(const ClosetState.failure());
    }, (response) {
      emit(const ClosetState.success());
    });
  }

  Future<void> addProductToClosets(String productId, String closetId) async {
    emit(const ClosetState.loading());
    final data = await repo.addProductToCloset(productId, closetId);
    data.fold((error) {
      emit(const ClosetState.failure());
    }, (response) {
      emit(const ClosetState.successAdded());
      closet = closets.firstWhere((e) => e.id == closetId);
      emit(const ClosetState.success());
    });
  }

  Future<void> getClosetsItems(String closetId) async {
    emit(const ClosetState.loading());
    final data = await repo.getClosetItem(closetId);
    data.fold((error) {
      emit(const ClosetState.failure());
    }, (response) {
      closetsItem = response;
      emit(const ClosetState.success());
    });
  }
}
