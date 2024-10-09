import 'package:dartz/dartz.dart';
import 'package:nilelon/features/promo/data/models/create_promo_model.dart';

import '../../../../core/service/failure_service.dart';

abstract class PromoRepo {
  Future<void> createPromo(CreatePromo promo);

  Future<Either<ServerFailure, Map<String, dynamic>>> getPromoType(
    String code,
  );
  Future<Either<ServerFailure, Map<String, dynamic>>> getOrderDiscount(
    String promotionId,
    num oldPrice,
  );
  Future<Either<ServerFailure, bool>> getFreeShipping(
    String promotionId,
    String governate,
  );
}
