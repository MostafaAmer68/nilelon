// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/features/closet/domain/model/closet_model.dart';
import 'package:nilelon/features/closet/domain/model/create_closet.dart';
import 'package:nilelon/features/product/domain/models/product_model.dart';

import 'package:nilelon/core/service/failure_service.dart';
import 'package:nilelon/core/service/network/api_service.dart';

import '../../../../core/service/network/end_point.dart';
import '../../domain/repo/closet_repo.dart';

class ClosetRemoteDataSourceImpl extends ClosetRepo {
  final ApiService _apiService;

  ClosetRemoteDataSourceImpl(this._apiService);

  @override
  Future<Either<FailureService, Response>> addProductToCloset(
      String productId, String closetId) async {
    final Response data = await _apiService
        .post(endPoint: EndPoint.addProductToClosetUrl, query: {
      'customerId': HiveStorage.get(HiveKeys.userId),
      'producId': productId,
      'closetListId': closetId,
    });
    if (data.statusCode == HttpStatus.ok) {
      return Right(data);
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

  @override
  Future<Either<FailureService, Response>> addProductToDefaultCloset(
      String productId) async {
    final Response data = await _apiService
        .post(endPoint: EndPoint.updateQuantityCartUrl, query: {
      'customerId': HiveStorage.get(HiveKeys.userId),
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

  @override
  Future<Either<FailureService, String>> createCloset(
      CreateCloset model) async {
    final Response data = await _apiService.post(
      endPoint: EndPoint.createClosetUrl,
      body: model.toJson(),
    );
    if (data.statusCode == HttpStatus.ok) {
      return Right(data.data['result']);
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

  @override
  Future<Either<FailureService, Response>> deleteCloset(
      String closetListId) async {
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

  @override
  Future<Either<FailureService, Response>> deleteProductFromCloset(
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

  @override
  Future<Either<FailureService, Response>> emptyCloset(
      String closetListId) async {
    final Response data =
        await _apiService.post(endPoint: EndPoint.emptyCartUrl, query: {
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

  @override
  Future<Either<FailureService, List<ProductModel>>> getClosetItem(
      String closetId) async {
    final Response data = await _apiService.get(
        endPoint: EndPoint.getClosetItemsUrl, query: {'closetId': closetId});
    if (data.statusCode == HttpStatus.ok) {
      return Right((data.data['result'] as List)
          .map((item) => ProductModel.fromJson(item['product']))
          .toList());
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

  @override
  Future<Either<FailureService, List<ClosetModel>>> getCustomerCloset() async {
    final Response data = await _apiService.get(
      endPoint: EndPoint.getCustomerClosetUrl,
      query: {
        'customerId': HiveStorage.get(HiveKeys.userId),
      },
    );
    if (data.statusCode == HttpStatus.ok) {
      final result = data.data['result'] as List;
      final List<ClosetModel> closets = [];
      for (var item in result) {
        closets.add(ClosetModel(id: item['id'], name: item['name']));
      }
      return Right(closets);
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
