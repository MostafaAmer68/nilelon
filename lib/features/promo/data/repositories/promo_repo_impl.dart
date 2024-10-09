import 'package:dartz/dartz.dart';
import 'package:nilelon/core/service/failure_service.dart';
import 'package:nilelon/features/promo/data/datasources/promo_service.dart';
import 'package:nilelon/features/promo/data/models/create_promo_model.dart';

import '../../domain/repositories/promo_repo.dart';

class PromoRepoImpl implements PromoRepo {
  final PromoService _service;

  PromoRepoImpl(this._service);
  @override
  Future<void> createPromo(CreatePromo promo) {
    // TODO: implement createPromo
    throw UnimplementedError();
  }

  @override
  Future<Either<ServerFailure, bool>> getFreeShipping(
      String promotionId, String governate) async {
    try {
      final result = await _service.getFreeShipping(promotionId, governate);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, Map<String, dynamic>>> getOrderDiscount(
      String promotionId, num oldPrice) async {
    try {
      final result = await _service.getOrderDiscount(promotionId, oldPrice);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, Map<String, dynamic>>> getPromoType(
      String code) async {
    try {
      final result = await _service.getPromoCodeType(code);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
