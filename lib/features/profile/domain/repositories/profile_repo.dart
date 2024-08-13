import 'package:dartz/dartz.dart';

import '../../../../service/failure_service.dart';

abstract class ProfileRepo {
  Future<Either<FailureService, String>> updateStoreInfo(
    String repName,
    String repNumber,
    String webLink,
    context,
  );
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
}
