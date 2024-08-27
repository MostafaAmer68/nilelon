import 'dart:io';

import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/features/payments/domain/models/add_payment_model.dart';
import 'package:nilelon/features/payments/domain/models/make_transaction_model.dart';
import 'package:nilelon/core/service/network/api_service.dart';
import 'package:nilelon/core/service/network/end_point.dart';

import '../../domain/models/make_transaction_payment_model.dart';

class PaymentService {
  final ApiService _apiService;

  PaymentService(this._apiService);

  Future<void> getClientToken() async {
    final response =
        await _apiService.post(endPoint: EndPoint.getClientTokenUrl);

    if (response.statusCode == HttpStatus.ok) {
      HiveStorage.set(HiveKeys.clientToken, response.data as String);
    } else {
      throw response.data['result'];
    }
  }

  Future<void> makeTransaction(MakeTransactionModel makeTransaction) async {
    final response = await _apiService.post(
      endPoint: EndPoint.makeTransactionUrl,
      body: makeTransaction.toJson(),
    );

    if (response.statusCode == HttpStatus.ok) {
      // HiveStorage.set(HiveKeys.clientToken, response.data as String);
    } else {
      throw response.data['result'];
    }
  }

  Future<void> makeTransactionwithPayment(
      MakeTransactionWithPaymentModel makeTransaction) async {
    final response = await _apiService.post(
      endPoint: EndPoint.makeTransactionWithPaymentUrl,
      body: makeTransaction.toJson(),
    );

    if (response.statusCode == HttpStatus.ok) {
    } else {
      throw response.data['result'];
    }
  }

  Future<void> refundTransaction(String clientToken) async {
    final response = await _apiService.post(
      endPoint: EndPoint.refundTransactionUrl,
      body: clientToken,
    );

    if (response.statusCode == HttpStatus.ok) {
    } else {
      throw response.data['result'];
    }
  }

  Future<void> addPayment(AddPaymentModel addPayment) async {
    final response = await _apiService.post(
      endPoint: EndPoint.addPayment,
      body: addPayment.toJson(),
    );

    if (response.statusCode == HttpStatus.ok) {
    } else {
      throw response.data['result'];
    }
  }

  Future<void> getPaymentMethods(String clientToken) async {
    final response = await _apiService.post(
      endPoint: EndPoint.getPaymentMethods,
      body: clientToken,
    );

    if (response.statusCode == HttpStatus.ok) {
    } else {
      throw response.data['result'];
    }
  }
}
