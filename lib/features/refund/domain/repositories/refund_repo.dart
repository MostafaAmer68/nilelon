import 'package:dartz/dartz.dart';
import 'package:nilelon/core/service/failure_service.dart';
import 'package:nilelon/features/refund/data/models/create_ret_change_mind_model.dart';
import 'package:nilelon/features/refund/data/models/create_ret_missing_model.dart';
import 'package:nilelon/features/refund/data/models/create_ret_wrong_model.dart';

import '../../data/models/refund_model.dart';

abstract class RefundRepo {
  Future<Either<FailureService, List<RefundModel>>> getRefunds();
  Future<Either<FailureService, void>> createRetMissingItem(
      CreateRetMissingModel userId);
  Future<Either<FailureService, void>> createRetWrongItem(
      CreateRetWrongModel userId);
  Future<Either<FailureService, void>> createRetChangeMindItem(
      CreateRetChangeMindModel userId);
}
