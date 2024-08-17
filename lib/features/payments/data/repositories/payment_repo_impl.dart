import 'package:dartz/dartz.dart';
import 'package:nilelon/features/payments/data/datasources/payment_service.dart';
import 'package:nilelon/features/payments/domain/models/add_payment_model.dart';
import 'package:nilelon/features/payments/domain/models/make_transaction_model.dart';
import 'package:nilelon/features/payments/domain/models/make_transaction_payment_model.dart';
import 'package:nilelon/service/failure_service.dart';

import '../../domain/repositories/payment_repo.dart';

class PaymentRepoImpl implements PaymentRepo {
  final PaymentService _paymentService;

  PaymentRepoImpl(this._paymentService);

  @override
  Future<Either<ServerFailure, void>> addPayment(
      AddPaymentModel addPayment) async {
    try {
      await _paymentService.addPayment(addPayment);
      return const Right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, void>> getClientToken() async {
    try {
      await _paymentService.getClientToken();
      return const Right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, void>> getPaymentMethods(
      String clientToken) async {
    try {
      await _paymentService.getPaymentMethods(clientToken);
      return const Right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, void>> makeTransaction(
      MakeTransactionModel makeTransaction) async {
    try {
      await _paymentService.makeTransaction(makeTransaction);
      return const Right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, void>> makeTransactionWithPayment(
      MakeTransactionWithPaymentModel makeTransactionWithModel) async {
    try {
      await _paymentService
          .makeTransactionwithPayment(makeTransactionWithModel);
      return const Right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, void>> refundTransaction(
      String clientToken) async {
    try {
      await _paymentService.refundTransaction(clientToken);
      return const Right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
