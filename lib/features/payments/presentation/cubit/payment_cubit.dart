import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/features/auth/domain/model/user_model.dart';
import 'package:nilelon/features/payments/data/repositories/payment_repo_impl.dart';
import 'package:nilelon/features/payments/domain/models/add_payment_model.dart';
import 'package:nilelon/features/payments/domain/models/make_transaction_model.dart';
import 'package:nilelon/features/payments/domain/models/make_transaction_payment_model.dart';

part 'payment_state.dart';
part 'payment_cubit.freezed.dart';

class PaymentCubit extends Cubit<PaymentState> {
  static PaymentCubit get(context) => BlocProvider.of(context);
  final PaymentRepoImpl _paymentRepoImpl;
  PaymentCubit(this._paymentRepoImpl) : super(const PaymentState.initial());

  Future<void> getClientToken() async {
    emit(const PaymentState.loading());
    final result = await _paymentRepoImpl.getClientToken();
    result.fold((err) {
      emit(const PaymentState.failure());
    }, (r) {
      emit(const PaymentState.success());
    });
  }

  Future<void> makeTransaction(
      num amount, num discount, String currency) async {
    emit(const PaymentState.loading());
    await dropInPayment(amount.toString()).then((v) async {
      final result = await _paymentRepoImpl.makeTransaction(
        MakeTransactionModel(
            customerId: HiveStorage.get<UserModel>(HiveKeys.userModel).id,
            amount: amount.toInt(),
            discount: discount.toInt(),
            nonce: v,
            currencyIsoCode: currency),
      );
      result.fold(
        (err) {
          emit(const PaymentState.failure());
        },
        (r) {
          emit(const PaymentState.success());
        },
      );
    });
  }

  Future<void> makeTransactionWithPayment() async {
    emit(const PaymentState.loading());
    final result = await _paymentRepoImpl.makeTransactionWithPayment(
      MakeTransactionWithPaymentModel(
        paymentToken: '',
        amount: 0,
        discount: 0,
        currencyIsoCode: '',
      ),
    );
    result.fold((err) {
      emit(const PaymentState.failure());
    }, (r) {
      emit(const PaymentState.success());
    });
  }

  Future<void> refundTransaction() async {
    emit(const PaymentState.loading());
    final result = await _paymentRepoImpl
        .refundTransaction(HiveStorage.get(HiveKeys.clientToken));
    result.fold((err) {
      emit(const PaymentState.failure());
    }, (r) {
      emit(const PaymentState.success());
    });
  }

  Future<void> addPayment() async {
    emit(const PaymentState.loading());
    final result = await _paymentRepoImpl.addPayment(AddPaymentModel(
        customerId: HiveStorage.get<UserModel>(HiveKeys.userModel).id,
        name: '',
        nonce: ''));
    result.fold((err) {
      emit(const PaymentState.failure());
    }, (r) {
      emit(const PaymentState.success());
    });
  }

  Future<void> getPaymentMethods() async {
    emit(const PaymentState.loading());
    final result = await _paymentRepoImpl
        .getPaymentMethods(HiveStorage.get(HiveKeys.clientToken));
    result.fold((err) {
      emit(const PaymentState.failure());
    }, (r) {
      emit(const PaymentState.success());
    });
  }

  Future<String> dropInPayment(String amount) async {
    emit(const PaymentState.loading());
    try {
      Completer nonce = Completer<String>();
      await getClientToken().then((v) async {
        final request = BraintreeDropInRequest(
          clientToken: HiveStorage.get<String>(HiveKeys.clientToken),
          collectDeviceData: true,
          amount: amount,
        );
        BraintreeDropInResult? result = await BraintreeDropIn.start(request);
        nonce.complete(result!.paymentMethodNonce.nonce);
        log(result.paymentMethodNonce.nonce.toString());
      });
      return await nonce.future;
    } catch (e) {
      emit(const PaymentState.failure());
      return '';
    }
  }
}
