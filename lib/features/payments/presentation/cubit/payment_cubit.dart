import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nilelon/data/hive_stroage.dart';
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

  Future<void> makeTransaction() async {
    emit(const PaymentState.loading());
    final result = await _paymentRepoImpl.makeTransaction(MakeTransactionModel(
        customerId: JwtDecoder.decode(
            HiveStorage.get<UserModel>(HiveKeys.userModel).token)['id'],
        amount: 0,
        discount: 0,
        nonce: '',
        currencyIsoCode: ''));
    result.fold((err) {
      emit(const PaymentState.failure());
    }, (r) {
      emit(const PaymentState.success());
    });
  }

  Future<void> makeTransactionWithPayment() async {
    emit(const PaymentState.loading());
    final result = await _paymentRepoImpl.makeTransactionWithPayment(
        MakeTransactionWithPaymentModel(
            paymentToken: '', amount: 0, discount: 0, currencyIsoCode: ''));
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
        customerId: JwtDecoder.decode(
            HiveStorage.get<UserModel>(HiveKeys.userModel).token)['id'],
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
}
