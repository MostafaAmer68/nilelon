import 'package:dartz/dartz.dart';
import 'package:nilelon/features/profile/data/models/store_profile.dart';

import '../../../../core/service/failure_service.dart';

abstract class ProfileRepo {
  Future<Either<FailureService, String>> updateStoreInfo(
    String repName,
    String repNumber,
    String webLink,
    context,
  );

  Future<Either<FailureService, Map<String, dynamic>>> getStoreForCustomer(
      String storeId);
  Future<Either<FailureService, String>> changePassword(
    String oldPassword,
    String newPassword,
    context,
  );
  Future<Either<FailureService, String>> updateStore(
    String profilePic,
    String name,
    String storeSlogan,
    context,
  );
  Future<Either<FailureService, StoreProfile>> getStoreById(
    String storeId,
  );
  Future<Either<FailureService, String>> followStore(
    String storeId,
  );
  Future<Either<FailureService, String>> notifyStore(String storeId);
  Future<Either<FailureService, List<StoreProfile>>> getStores(
    int page,
    int pageSize,
  );
}
