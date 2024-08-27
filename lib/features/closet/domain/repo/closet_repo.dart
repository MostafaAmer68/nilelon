import 'package:dartz/dartz.dart';
import 'package:nilelon/features/closet/domain/model/create_closet.dart';
import 'package:nilelon/features/product/domain/models/product_model.dart';
import 'package:nilelon/core/service/failure_service.dart';

import '../model/closet_model.dart';

abstract class ClosetRepo {
  Future<Either<FailureService, void>> createCloset(CreateCloset model);
  Future<Either<FailureService, void>> addProductToCloset(
      String productId, String closetId);
  Future<Either<FailureService, void>> deleteProductFromCloset(
      String closetListId, String productId);
  Future<Either<FailureService, void>> deleteCloset(String closetListId);
  Future<Either<FailureService, void>> emptyCloset(String closetListId);
  Future<Either<FailureService, void>> addProductToDefaultCloset(
      String productId);
  Future<Either<FailureService, List<ClosetModel>>> getCustomerCloset();
  Future<Either<FailureService, List<ProductModel>>> getClosetItem(
      String closetId);
}
