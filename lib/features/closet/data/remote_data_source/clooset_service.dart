// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/features/closet/domain/model/closet_model.dart';
import 'package:nilelon/features/closet/domain/model/create_closet.dart';
import 'package:nilelon/features/product/domain/models/product_model.dart';

import 'package:nilelon/core/service/network/api_service.dart';

import '../../../../core/service/network/end_point.dart';
import '../../../auth/domain/model/user_model.dart';

class ClosetService {
  final ApiService _apiService;

  ClosetService(this._apiService);

  Future<void> addProuctToCloset(String productId, String closetId) async {
    final Response data = await _apiService
        .post(endPoint: EndPoint.addProductToClosetUrl, query: {
      'customerId': HiveStorage.get<UserModel>(HiveKeys.userModel).id,
      'producId': productId,
      'closetListId': closetId,
    });
    if (data.statusCode == HttpStatus.ok) {
      // return data;
    } else if (data.statusCode == HttpStatus.badRequest) {
      // Handle the bad request response
      final errorMessage = data.data;
      // errorAlert(context, errorMessage);
      throw Left('Update Quantity Cart failed: $errorMessage');
    } else {
      // Handle other status codes if necessary
      throw Left(
          'Failed to Update Quantity Cart: Unexpected status code ${data.statusCode}');
    }
  }

  Future<void> addProuctToDefaultCloset(String productId) async {
    final Response data = await _apiService
        .post(endPoint: EndPoint.updateQuantityCartUrl, query: {
      'customerId': HiveStorage.get<UserModel>(HiveKeys.userModel).id,
      'productId': productId,
    });
    if (data.statusCode == HttpStatus.ok) {
      return data.data;
    } else if (data.statusCode == HttpStatus.badRequest) {
      // Handle the bad request response
      final errorMessage = data.data;
      // errorAlert(context, errorMessage);
      throw Left('Update Quantity Cart failed: $errorMessage');
    } else {
      // Handle other status codes if necessary
      throw Left(
          'Failed to Update Quantity Cart: Unexpected status code ${data.statusCode}');
    }
  }

  Future<String> createClset(CreateCloset model) async {
    final Response data = await _apiService.post(
      endPoint: EndPoint.createClosetUrl,
      body: model.toJson(),
    );
    if (data.statusCode == HttpStatus.ok) {
      return data.data['result'];
    } else if (data.statusCode == HttpStatus.badRequest) {
      // Handle the bad request response
      final errorMessage = data.data;
      // errorAlert(context, errorMessage);
      throw Left('Create Closet failed: $errorMessage');
    } else {
      // Handle other status codes if necessary
      throw Left(
          'Failed to Create Closet: Unexpected status code ${data.statusCode}');
    }
  }

  Future<void> deleteCloset(String closetListId) async {
    final Response data =
        await _apiService.delete(endPoint: EndPoint.deleteClosetUrl, query: {
      'closetListId': closetListId,
    });
    if (data.statusCode == HttpStatus.ok) {
      return data.data;
    } else if (data.statusCode == HttpStatus.badRequest) {
      // Handle the bad request response
      final errorMessage = data.data;
      // errorAlert(context, errorMessage);
      throw Left('Delet Closet failed: $errorMessage');
    } else {
      // Handle other status codes if necessary
      throw Left(
          'Failed to Delet Closet: Unexpected status code ${data.statusCode}');
    }
  }

  Future<void> updateCloset(String closetListId, String name) async {
    final Response data = await _apiService.put(
        endPoint: EndPoint.updateCloset,
        body: {'id': closetListId, 'name': name});
    if (data.statusCode == HttpStatus.ok) {
      return data.data;
    } else if (data.statusCode == HttpStatus.badRequest) {
      // Handle the bad request response
      final errorMessage = data.data;
      // errorAlert(context, errorMessage);
      throw Left('Delet Closet failed: $errorMessage');
    } else {
      // Handle other status codes if necessary
      throw Left(
          'Failed to Delet Closet: Unexpected status code ${data.statusCode}');
    }
  }

  Future<void> deleteroductFromCloset(
      String closetListId, String productId) async {
    final Response data = await _apiService
        .delete(endPoint: EndPoint.deleteProductFromCloset, query: {
      'producId': productId,
      'closetListId': closetListId,
    });
    if (data.statusCode == HttpStatus.ok) {
      return data.data;
    } else if (data.statusCode == HttpStatus.badRequest) {
      // Handle the bad request response
      final errorMessage = data.data;
      // errorAlert(context, errorMessage);
      throw Left('Delete product from closet failed: $errorMessage');
    } else {
      // Handle other status codes if necessary
      throw Left(
          'Failed to Delete product from closet: Unexpected status code ${data.statusCode}');
    }
  }

  Future<void> emptyCoset(String closetListId) async {
    final Response data =
        await _apiService.delete(endPoint: EndPoint.emptyClosetUrl, query: {
      'closetListId': closetListId,
    });
    if (data.statusCode == HttpStatus.ok) {
      return data.data;
    } else if (data.statusCode == HttpStatus.badRequest) {
      // Handle the bad request response
      final errorMessage = data.data;
      // errorAlert(context, errorMessage);
      throw Left('Update Quantity Cart failed: $errorMessage');
    } else {
      // Handle other status codes if necessary
      throw Left(
          'Failed to Update Quantity Cart: Unexpected status code ${data.statusCode}');
    }
  }

  Future<List<ProductModel>> getClosetItem(String closetId) async {
    final Response data = await _apiService.get(
        endPoint: EndPoint.getClosetItemsUrl, query: {'closetId': closetId});
    if (data.statusCode == HttpStatus.ok) {
      return (data.data['result'] as List)
          .map((item) => ProductModel.fromJson(item['product']))
          .toList();
    } else if (data.statusCode == HttpStatus.badRequest) {
      // Handle the bad request response
      final errorMessage = data.data;
      // errorAlert(context, errorMessage);
      throw Left('Update Quantity Cart failed: $errorMessage');
    } else {
      // Handle other status codes if necessary
      throw Left(
          'Failed to Update Quantity Cart: Unexpected status code ${data.statusCode}');
    }
  }

  Future<List<ProductModel>> getAllClosetsItems() async {
    final Response data = await _apiService.get(
        endPoint: EndPoint.getAllClosetsItems,
        query: {
          'customerId': HiveStorage.get<UserModel>(HiveKeys.userModel).id
        });
    if (data.statusCode == HttpStatus.ok) {
      return (data.data['result'] as List)
          .map((item) => ProductModel.fromJson(item))
          .toList();
    } else if (data.statusCode == HttpStatus.badRequest) {
      // Handle the bad request response
      final errorMessage = data.data;
      // errorAlert(context, errorMessage);
      throw Left('Update Quantity Cart failed: $errorMessage');
    } else {
      // Handle other status codes if necessary
      throw Left(
          'Failed to Update Quantity Cart: Unexpected status code ${data.statusCode}');
    }
  }

  Future<List<ClosetModel>> getCustomerCloset() async {
    final Response data = await _apiService.get(
      endPoint: EndPoint.getCustomerClosetUrl,
      query: {
        'customerId': HiveStorage.get<UserModel>(HiveKeys.userModel).id,
      },
    );
    if (data.statusCode == HttpStatus.ok) {
      final result = data.data['result'] as List;
      final List<ClosetModel> closets = [];
      for (var item in result) {
        closets.add(ClosetModel(id: item['id'], name: item['name']));
      }
      return closets;
    } else if (data.statusCode == HttpStatus.badRequest) {
      // Handle the bad request response
      final errorMessage = data.data;
      // errorAlert(context, errorMessage);
      throw Left('Get Customer closet failed: $errorMessage');
    } else {
      // Handle other status codes if necessary
      throw Left(
          'Failed to Get Customer closet: Unexpected status code ${data.statusCode}');
    }
  }
}
