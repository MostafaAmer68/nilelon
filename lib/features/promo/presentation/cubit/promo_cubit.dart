import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/features/promo/data/repositories/promo_repo_impl.dart';

part 'promo_state.dart';

class PromoCubit extends Cubit<PromoState> {
  final PromoRepoImpl _promoRepo;
  static PromoCubit get(context) => BlocProvider.of(context);
  PromoCubit(this._promoRepo) : super(PromoInitial());
  bool isFreeShipping = false;
  num totalPrice = 0;
  num tempTotalPrice = 0;
  num deliveryPrice = 0;
  num discount = 0;
  String selectedGov = '';

  TextEditingController promoCode = TextEditingController();

  Future getFreeShipping(context, promoCodeId) async {
    emit(PromoLoading());
    final result = await _promoRepo.getFreeShipping(promoCodeId, selectedGov);

    result.fold(
      (failrue) {
        emit(PromoFailure(failrue.errorMsg));
      },
      (response) {
        isFreeShipping = response;
        if (response) {
          totalPrice -= deliveryPrice;
          deliveryPrice = 0;
        }
        emit(PromoSuccess());
      },
    );
  }

  Future getPromoCodeType(context) async {
    emit(PromoLoading());
    if (promoCode.text.isEmpty) {
      emit(const PromoFailure('Please enter promo code'));
    }
    final result = await _promoRepo.getPromoType(promoCode.text);

    result.fold(
      (failrue) {
        emit(PromoFailure(failrue.errorMsg));
      },
      (response) {
        if (response['type'] == 'OrderDiscount') {
          getOrderDiscount(context, response['promotionId']);
        } else if (response['type'] == 'FreeShipping') {
          getFreeShipping(context, response['promotionId']);
        }
      },
    );
  }

  Future getOrderDiscount(context, promoCodeId) async {
    emit(PromoLoading());
    final result = await _promoRepo.getOrderDiscount(promoCodeId, totalPrice);

    result.fold(
      (failrue) {
        emit(PromoFailure(failrue.errorMsg));
      },
      (response) {
        totalPrice = response['newPrice'];
        discount = response['discount'];
        emit(PromoSuccess());
      },
    );
  }
}
