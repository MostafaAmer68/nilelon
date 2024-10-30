import 'package:dartz/dartz.dart';
import 'package:nilelon/features/profile/data/models/store_profile_model.dart';

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
  Future<Either<FailureService, StoreProfileModel>> getStoreById(
    String storeId,
  );
  Future<Either<FailureService, String>> followStore(
    String storeId,
  );
  Future<Either<FailureService, String>> notifyStore(String storeId);
  Future<Either<FailureService, List<StoreProfileModel>>> getStores(
    int page,
    int pageSize,
  );

  Future<Either<FailureService, String>> sendOtpToEmail(
      String newValue, context);

  Future<Either<FailureService, String>> validateEmail(
      String newValue, context);

  Future<Either<FailureService, String>> resetPasswordEmail(
      String email, context);

  Future<Either<FailureService, String>> resetPasswordPhone(
      String phone, context);

  Future<Either<FailureService, String>> resetPhone(String newValue, context);

  Future<Either<FailureService, String>> resetPhoneDetails(
      String token, String targetValue, String newValue, context);

  Future<Either<FailureService, String>> updateCustomer(
      String profilePic, String name, context);
}
