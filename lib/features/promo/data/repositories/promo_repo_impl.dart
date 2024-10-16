import 'package:dartz/dartz.dart';
import 'package:nilelon/core/service/catch_func.dart';
import 'package:nilelon/core/service/failure_service.dart';
import 'package:nilelon/features/promo/data/datasources/promo_service.dart';
import 'package:nilelon/features/promo/data/models/create_promo_model.dart';

import '../../domain/repositories/promo_repo.dart';

class PromoRepoImpl implements PromoRepo {
  final PromoService _service;

  PromoRepoImpl(this._service);
  @override
  Future<Either<ServerFailure, void>> createPromo(CreatePromo promo) {
    return exe(() => _service.createPromo(promo));
  }

  @override
  Future<Either<ServerFailure, bool>> getFreeShipping(
      String promotionId, String governate) async {
    return exe(() => _service.getFreeShipping(promotionId, governate));
  }

  @override
  Future<Either<ServerFailure, Map<String, dynamic>>> getOrderDiscount(
      String promotionId, num oldPrice) async {
    return exe(() => _service.getOrderDiscount(promotionId, oldPrice));
  }

  @override
  Future<Either<ServerFailure, Map<String, dynamic>>> getPromoType(
      String code) async {
    return exe(() => _service.getPromoCodeType(code));
  }
}
