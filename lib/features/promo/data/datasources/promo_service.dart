import 'dart:developer';
import 'dart:io';

import 'package:nilelon/core/service/network/api_service.dart';
import 'package:nilelon/features/promo/data/models/create_promo_model.dart';

import '../../../../core/service/network/end_point.dart';

class PromoService {
  final ApiService _api;

  PromoService(this._api);

  Future<void> createPromo(CreatePromo model) async {
    final response =
        await _api.post(endPoint: EndPoint.createPromo, body: model.toMap());

    if (response.statusCode == HttpStatus.ok) {
      return;
    }
    throw response.data['errorMessages'];
  }

  Future<Map<String, dynamic>> getPromoCodeType(
    String code,
  ) async {
    final response = await _api.get(
      endPoint: EndPoint.getPromoCodeType,
      query: {
        'code': code,
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      if (response.data['result'] == null) {
        throw response.data['errorMessages'][0];
      }
      if ((response.data['result'] as Map).containsKey('promotionId') ||
          response.data['isSuccess']) {
        log('message');
        return response.data['result'];
      } else {
        log('message1');
        throw response.data['errorMessages'];
      }
    }
    throw response.data['errorMessages'];
  }

  Future<Map<String, dynamic>> getOrderDiscount(
    String promotionId,
    num totalOrderPrice,
  ) async {
    final response = await _api.post(
      endPoint: EndPoint.getOrderDiscount,
      body: {
        'promotionId': promotionId,
        'oldPrice': totalOrderPrice,
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      return {
        'discount': response.data['result']['discount'],
        'newPrice': response.data['result']['newPrice'],
      };
    }
    throw response.data['errorMessages'];
  }

  Future<bool> getFreeShipping(String code, String governate) async {
    final response = await _api.post(
        endPoint: EndPoint.getFreeShipping,
        body: {'promotionId': code, 'governate': governate});

    if (response.statusCode == HttpStatus.ok) {
      if (response.data['result'] is String) {
        throw response.data['result'];
      } else {
        return (response.data['result']);
      }
    }
    throw response.data['errorMessages'];
  }
}
