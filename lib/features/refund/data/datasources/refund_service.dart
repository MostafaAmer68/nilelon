import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/core/service/network/api_service.dart';
import 'package:nilelon/features/auth/domain/model/user_model.dart';
import 'package:nilelon/features/refund/data/models/create_ret_change_mind_model.dart';
import 'package:nilelon/features/refund/data/models/create_ret_missing_model.dart';
import 'package:nilelon/features/refund/data/models/create_ret_wrong_model.dart';
import 'package:nilelon/features/refund/data/models/refund_model.dart';

import '../../../../core/service/network/end_point.dart';
import '../models/refund_details_model.dart';

class RefundSErvice {
  final ApiService _apiService;

  RefundSErvice(this._apiService);

  Future<List<RefundModel>> getRefunds() async {
    final isStore = HiveStorage.get(HiveKeys.isStore);
    final Response data = await _apiService.get(
        endPoint: !isStore
            ? EndPoint.getCustomerReturensUrl
            : EndPoint.getStoreReturensUrl,
        query: {
          isStore ? 'storeId' : 'customerId':
              HiveStorage.get<UserModel>(HiveKeys.userModel).id
        });
    if (data.statusCode == HttpStatus.ok) {
      return List<RefundModel>.from(
          data.data['result'].map((e) => RefundModel.fromJson(e)));
    } else {
      // Handle other status codes if necessary
      throw Exception(
          'Failed to Refund: Unexpected status code ${data.data['result']}');
    }
  }

  Future<ReturnDetailsModel> getReturnDetails(
      String returnId, String returnType) async {
    final Response data =
        await _apiService.get(endPoint: EndPoint.getCReturnDetailsUrl, query: {
      'returnId': returnId,
      'returnType': returnType,
    });
    if (data.statusCode == HttpStatus.ok) {
      return ReturnDetailsModel.fromJson(data.data['result']);
    } else {
      // Handle other status codes if necessary
      throw Exception(
          'Failed to Refund: Unexpected status code ${data.data['result']}');
    }
  }

  Future<void> createRetMissingItem(CreateRetMissingModel model) async {
    final Response data = await _apiService.post(
      endPoint: EndPoint.createReturnedMissingItem,
      body: model.toJson(),
    );
    if (data.statusCode == HttpStatus.ok) {
    } else {
      // Handle other status codes if necessary
      throw Exception(
          'Failed to Refund: Unexpected status code ${data.data['result']}');
    }
  }

  Future<void> createRetWrongItem(CreateRetWrongModel model) async {
    final Response data = await _apiService.post(
      endPoint: EndPoint.createReturnedWrongItem,
      body: model.toJson(),
    );
    if (data.statusCode == HttpStatus.ok) {
    } else {
      // Handle other status codes if necessary
      throw Exception(
          'Failed to Refund: Unexpected status code ${data.data['result']}');
    }
  }

  Future<void> createRetChangeMindItem(CreateRetChangeMindModel model) async {
    final Response data = await _apiService.post(
        endPoint: EndPoint.createReturnedChangeMindItem, body: model.toJson());
    if (data.statusCode == HttpStatus.ok) {
    } else {
      // Handle other status codes if necessary
      throw Exception(
          'Failed to Refund: Unexpected status code ${data.data['result']}');
    }
  }
}
