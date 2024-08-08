import 'package:dartz/dartz.dart';
import 'package:nilelon/features/customer_flow/closet/domain/model/create_closet.dart';
import 'package:nilelon/features/product/domain/models/product_model.dart';
import 'package:nilelon/service/failure_service.dart';

import '../model/closet_model.dart';

abstract class ClosetRepo {
  Future<Either<FailureService, void>> createCloset(CreateCloset model);
  Future<Either<FailureService, void>> addProductToCloset(
      String productId, String closetId);
  Future<Either<FailureService, void>> deleteProductFromCloset();
  Future<Either<FailureService, void>> deleteCloset();
  Future<Either<FailureService, void>> emptyCloset();
  Future<Either<FailureService, void>> addProductToDefaultCloset(
      String productId);
  Future<Either<FailureService, List<ClosetModel>>> getCustomerCloset();
  Future<Either<FailureService, List<ProductModel>>> getClosetItem(
      String closetId);
}
