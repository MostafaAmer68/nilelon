import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/core/tools.dart';
import 'package:nilelon/features/categories/domain/model/result.dart';
import 'package:nilelon/features/promo/data/models/create_promo_model.dart';
import 'package:nilelon/features/promo/data/repositories/promo_repo_impl.dart';

import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../product/domain/models/product_model.dart';

part 'promo_state.dart';

class PromoCubit extends Cubit<PromoState> {
  final PromoRepoImpl _promoRepo;
  static PromoCubit get(context) => BlocProvider.of(context);
  PromoCubit(this._promoRepo) : super(PromoInitial());
  bool isFreeShipping = false;
  num totalPrice = 0;
  num orderTotal = 0;
  num tempTotalPrice = 0;
  num newPrice = 0;
  num deliveryPrice = 0;
  num discount = 0;
  String selectedGov = '';
  final GlobalKey<FormState> applyOfferForm = GlobalKey();

  List<ProductModel> selectedProducts = [];
  bool isSelectedAll = false;

  DateTime endDate = DateTime.now().add(const Duration(days: 10));
  DateTime startDate = DateTime.now();

  TextEditingController promoCode = TextEditingController();
  TextEditingController amount = TextEditingController();
  CategoryModel category = CategoryModel.empty();
  Future getFreeShipping(context, promoCodeId) async {
    try {
      emit(PromoLoading());
      if (selectedGov.isNotEmpty) {
        final result =
            await _promoRepo.getFreeShipping(promoCodeId, selectedGov);
        log('ts');
        result.fold(
          (failrue) {
            emit(PromoFailure(failrue.errorMsg));
          },
          (response) {
            isFreeShipping = response;
            if (response) {
              totalPrice -= deliveryPrice;
              deliveryPrice = 0;
              promoCode.clear();
              emit(PromoSuccess());
            } else {
              emit(const PromoFailure('Promocode not available for this city'));
            }
          },
        );
      } else {
        emit(const PromoFailure('please select governate'));
      }
    } catch (e) {
      log(e.toString());
      emit(PromoFailure(e.toString()));
    }
  }

  Future getPromoCodeType(context) async {
    try {
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
          }
          if (response['type'] == 'FreeShipping') {
            getFreeShipping(context, response['promotionId']);
          }
          if (response['type'] == 'StoreDiscount') {
            getStoreDiscount(context, response['promotionId']);
          }
        },
      );
    } catch (e) {
      emit(PromoFailure(e.toString()));
    }
  }

  Future getOrderDiscount(context, promoCodeId) async {
    emit(PromoLoading());
    final result = await _promoRepo.getOrderDiscount(
        promoCodeId, totalPrice - deliveryPrice);

    result.fold(
      (failrue) {
        emit(PromoFailure(failrue.errorMsg));
      },
      (response) {
        totalPrice = response['newPrice'] + deliveryPrice;
        newPrice = response['newPrice'] + deliveryPrice;
        discount = response['discount'];
        promoCode.clear();
        emit(PromoSuccess());
      },
    );
  }

  Future getStoreDiscount(context, promoCodeId) async {
    emit(PromoLoading());
    final result = await _promoRepo.getStoreDiscount(
      {
        "promotionId": promoCodeId,
        "variantIds": CartCubit.get(context)
            .tempCartItems
            .map(
              (e) => {
                "size": e.size,
                "color": e.color,
                "productId": e.productId,
              },
            )
            .toList()
      },
    );

    result.fold(
      (failrue) {
        emit(PromoFailure(failrue.errorMsg));
      },
      (response) {
        discount = response;
        totalPrice = totalPrice * discount;
        newPrice = totalPrice * discount;
        promoCode.clear();
        emit(PromoSuccess());
      },
    );
  }

  Future craetePromo(context) async {
    emit(PromoInitial());
    if (amount.text.isEmpty) {
      emit(PromoFailure(lang(context).plsEnterwareHouse));
      return;
    }
    if (selectedProducts.isEmpty) {
      emit(PromoFailure(lang(context).youMustSelectOneProduct));
      return;
    }
    emit(PromoLoading());
    final result = await _promoRepo.createPromo(
      CreatePromo(
        startDate: startDate,
        endDate: endDate,
        discountRate: double.parse(amount.text),
        productIds: selectedProducts.map((e) => e.id).toList(),
      ),
    );

    result.fold(
      (failrue) {
        emit(PromoFailure(failrue.errorMsg));
      },
      (response) {
        emit(PromoSuccess());
      },
    );
  }
}
