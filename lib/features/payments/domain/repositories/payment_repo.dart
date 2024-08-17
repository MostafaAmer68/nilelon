import 'package:dartz/dartz.dart';
import 'package:nilelon/features/payments/domain/models/add_payment_model.dart';
import 'package:nilelon/features/payments/domain/models/make_transaction_model.dart';
import 'package:nilelon/features/payments/domain/models/make_transaction_payment_model.dart';
import 'package:nilelon/service/failure_service.dart';

abstract class PaymentRepo {
  Future<Either<ServerFailure, void>> getClientToken();
  Future<Either<ServerFailure, void>> makeTransaction(
      MakeTransactionModel makeTransaction);
  Future<Either<ServerFailure, void>> makeTransactionWithPayment(
      MakeTransactionWithPaymentModel makeTransactionWithModel);
  Future<Either<ServerFailure, void>> refundTransaction(String clientToken);
  Future<Either<ServerFailure, void>> addPayment(AddPaymentModel addPayment);
  Future<Either<ServerFailure, void>> getPaymentMethods(String clientToken);
}
