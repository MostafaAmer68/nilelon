import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/features/customer_flow/cart/model/change_quantity_model.dart';
import 'package:nilelon/features/customer_flow/cart/model/delete_request_model.dart';
import 'package:nilelon/features/customer_flow/cart/model/get_cart_model/cart_item.dart';
import 'package:nilelon/features/customer_flow/cart/repos/cart_repos.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this.cartRepos) : super(CartInitial());
  final CartRepos cartRepos;
  Future<void> getCart() async {
    emit(CartLoading());

    var result = await cartRepos.getCart();
    result.fold((failure) {
      emit(GetCartFailure(message: failure.errorMsg));
    }, (response) {
      emit(GetCartSuccess(items: response.result?.items ?? []));
    });
  }

  Future<void> deleteFromCart(DeleteRequestModel model) async {
    emit(CartLoading());

    var result = await cartRepos.deleteFromCart(model);
    result.fold((failure) {
      emit(DeleteFromCartFailure(message: failure.errorMsg));
    }, (response) {
      emit(DeleteFromCartSuccess());
      getCart();
    });
  }

  Future<void> updateQuantityCart(ChangeQuantityModel model) async {
    emit(CartLoading());

    var result = await cartRepos.updateQuantityCart(model);
    result.fold((failure) {
      emit(UpdateQuantityCartFailure(message: failure.errorMsg));
    }, (response) {
      emit(UpdateQuantityCartSuccess());
      getCart();
    });
  }
}
