import 'package:dartz/dartz.dart';
import 'package:nilelon/features/closet/domain/model/create_closet.dart';
import 'package:nilelon/features/closet/domain/repo/closet_repo.dart';
import 'package:nilelon/core/service/failure_service.dart';

import '../../../../core/service/catch_func.dart';
import '../../../product/domain/models/product_model.dart';
import '../../domain/model/closet_model.dart';
import '../remote_data_source/clooset_service.dart';

class ClosetRepoImpl extends ClosetRepo {
  final ClosetService _service;

  ClosetRepoImpl(this._service);

  @override
  Future<Either<FailureService, void>> addProductToCloset(
      String productId, String closetId) {
    return exe(() => _service.addProuctToCloset(productId, closetId));
  }

  @override
  Future<Either<FailureService, void>> addProductToDefaultCloset(
      String productId) {
    return exe(() => _service.addProuctToDefaultCloset(productId));
  }

  @override
  Future<Either<FailureService, void>> createCloset(CreateCloset model) {
    return exe(() => _service.createClset(model));
  }

  @override
  Future<Either<FailureService, void>> deleteCloset(String closetListId) {
    return exe(() => _service.deleteCloset(closetListId));
  }

  @override
  Future<Either<FailureService, void>> deleteProductFromCloset(
      String closetListId, String productId) {
    return exe(() => _service.deleteroductFromCloset(closetListId, productId));
  }

  @override
  Future<Either<FailureService, void>> emptyCloset(String closetListId) {
    return exe(() => _service.emptyCoset(closetListId));
  }

  @override
  Future<Either<FailureService, List<ProductModel>>> getClosetItem(
      String closetId) {
    return exe(() => _service.getClosetItem(closetId));
  }

  @override
  Future<Either<FailureService, List<ClosetModel>>> getCustomerCloset() {
    return exe(() => _service.getCustomerCloset());
  }

  @override
  Future<Either<FailureService, void>> updateCloset(
      String closetListId, String name) {
    return exe(() => _service.updateCloset(closetListId, name));
  }

  @override
  Future<Either<FailureService, List<ProductModel>>> getAllClosetsItems() {
    return exe(() => _service.getAllClosetsItems());
  }
}
