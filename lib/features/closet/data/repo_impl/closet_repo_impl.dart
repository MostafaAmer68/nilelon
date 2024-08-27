import 'package:dartz/dartz.dart';
import 'package:nilelon/features/closet/domain/model/create_closet.dart';
import 'package:nilelon/features/closet/domain/repo/closet_repo.dart';
import 'package:nilelon/core/service/failure_service.dart';

import '../../../product/domain/models/product_model.dart';
import '../../domain/model/closet_model.dart';
import '../remote_data_source/closet_remote_data_source.dart';

class ClosetRepoImpl extends ClosetRepo {
  final ClosetRemoteDataSourceImpl _service;

  ClosetRepoImpl(this._service);

  @override
  Future<Either<FailureService, void>> addProductToCloset(
      String productId, String closetId) {
    return _service.addProductToCloset(productId, closetId);
  }

  @override
  Future<Either<FailureService, void>> addProductToDefaultCloset(
      String productId) {
    return _service.addProductToDefaultCloset(productId);
  }

  @override
  Future<Either<FailureService, void>> createCloset(CreateCloset model) {
    return _service.createCloset(model);
  }

  @override
  Future<Either<FailureService, void>> deleteCloset(String closetListId) {
    return _service.deleteCloset(closetListId);
  }

  @override
  Future<Either<FailureService, void>> deleteProductFromCloset(
      String closetListId, String productId) {
    return _service.deleteProductFromCloset(closetListId, productId);
  }

  @override
  Future<Either<FailureService, void>> emptyCloset(String closetListId) {
    return _service.emptyCloset(closetListId);
  }

  @override
  Future<Either<FailureService, List<ProductModel>>> getClosetItem(
      String closetId) {
    return _service.getClosetItem(closetId);
  }

  @override
  Future<Either<FailureService, List<ClosetModel>>> getCustomerCloset() {
    return _service.getCustomerCloset();
  }
}
