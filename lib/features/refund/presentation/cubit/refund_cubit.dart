import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nilelon/features/product/domain/models/product_model.dart';
import 'package:nilelon/features/refund/data/models/create_ret_missing_model.dart';
import 'package:nilelon/features/refund/data/models/refund_model.dart';
import 'package:nilelon/features/refund/data/repositories/refund_repo_impl.dart';

part 'refund_state.dart';

class RefundCubit extends Cubit<RefundState> {
  final RefundRepoImpl _refund;
  RefundCubit(this._refund) : super(RefundInitial());
  List<RefundModel> refunds = [];
  String orderId = '';
  List<ProductModel> selectedProducts = [];

  Future<void> createRetMissingItem() async {
    emit(RefundLoading());
    if (selectedProducts.length == 1) {
      final selectedProduct = selectedProducts.first;
      final result = await _refund.createRetMissingItem(CreateRetMissingModel(
        orderId,
        selectedProduct.id,
        selectedProduct.productVariants.first.size,
        selectedProduct.productVariants.first.color,
        '',
      ));

      result.fold(
        (err) {
          emit(RefundFailure(err.errorMsg));
        },
        (result) {
          // refunds = result;
          emit(RefundSuccess());
        },
      );
    } else {
      for (var item in selectedProducts) {
        final result = await _refund.createRetMissingItem(CreateRetMissingModel(
          orderId,
          item.id,
          item.productVariants.first.size,
          item.productVariants.first.color,
          '',
        ));

        result.fold(
          (err) {
            emit(RefundFailure(err.errorMsg));
          },
          (result) {
            // refunds = result;
            emit(RefundSuccess());
          },
        );
      }
    }
  }

  Future<void> getRefunds() async {
    emit(RefundLoading());
    final result = await _refund.getRefunds();

    result.fold(
      (err) {
        emit(RefundFailure(err.errorMsg));
      },
      (result) {
        refunds = result;
        emit(RefundSuccess());
      },
    );
  }
}
