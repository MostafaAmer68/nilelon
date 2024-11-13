import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/features/cart/domain/model/add_cart_request_model.dart';
import 'package:nilelon/features/cart/domain/model/change_quantity_model.dart';
import 'package:nilelon/features/cart/domain/model/delete_request_model.dart';
import 'package:nilelon/features/cart/domain/model/cart_item.dart';
import 'package:nilelon/features/cart/domain/repos/cart_repos.dart';

import '../../../auth/domain/model/user_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this.cartRepos) : super(CartInitial());
  final CartRepos cartRepos;
  String selectedSize = '';
  String selectedColor = '';
  int counter = 1;
  static CartCubit get(context) => BlocProvider.of<CartCubit>(context);
  Future<void> emptyCart() async {
    emit(CartLoading());

    var result = await cartRepos
        .emptyCart(HiveStorage.get<UserModel>(HiveKeys.userModel).id);
    result.fold((failure) {
      emit(GetCartFailure(message: failure.errorMsg));
    }, (response) {
      getCart();
      // emit(GetCartSuccess());
    });
  }

  CartModel cart1 = CartModel(id: '', items: []);
  // List<CartItem> selectedItems = [];
  List<CartItem> tempCartItems = [];
  Future<void> addToCart(AddToCartModel model) async {
    emit(CartLoading());

    var result = await cartRepos.addToCart(model);
    result.fold((failure) {
      emit(GetCartFailure(message: failure.errorMsg));
    }, (response) {
      log(model.toMap().toString());
      emit(CartSuccess());
      emit(GetCartSuccess());
    });
  }

  void onSelectedItem(bool value, CartItem item) {
    emit(UpdateQuantityCartLoading());
    final index = cart1.items.indexWhere((e) => item.productId == e.productId);
    if (value) {
      if (tempCartItems.isEmpty || cart1.items.length == 1) {
        tempCartItems.add(item);
        log(index.toString(), name: 'onSelectedMethod true');
      } else {
        tempCartItems.insert(index, item);
        log(index.toString(), name: 'onSelectedMethod false');
      }
    } else {
      if (tempCartItems.isEmpty || cart1.items.length == 1) {
        tempCartItems.remove(item);
        log(index.toString(), name: 'onSelectedMethod length 1');
      } else {
        log(index.toString(), name: 'onSelectedMethod length > 1');
        tempCartItems.removeAt(index);
      }
    }
    emit(GetCartSuccess());
  }

  Future<void> getCart([isUpdate = false]) async {
    if (isUpdate) {
      emit(UpdateQuantityCartLoading());
    } else {
      emit(CartLoading());
    }
    var result = await cartRepos.getCart();
    result.fold((failure) {
      emit(GetCartFailure(message: failure.errorMsg));
    }, (response) {
      cart1 = response;
      tempCartItems = cart1.items.toList();
      emit(GetCartSuccess());
    });
  }

  Future<void> deleteFromCart(DeleteRequestModel model) async {
    emit(CartLoading());

    var result = await cartRepos.deleteFromCart(model);
    result.fold((failure) {
      emit(DeleteFromCartFailure(message: failure.errorMsg));
      emit(GetCartSuccess());
    }, (response) {
      emit(DeleteFromCartSuccess());
      getCart();
    });
  }

  Future<void> updateQuantityCart(CartItem cart) async {
    emit(UpdateQuantityCartLoading());

    var result = await cartRepos.updateQuantityCart(ChangeQuantityModel(
      customrId: HiveStorage.get<UserModel>(HiveKeys.userModel).id,
      size: cart.size,
      color: cart.color,
      productId: cart.productId,
      quantity: cart.quantity,
    ));
    result.fold((failure) {
      emit(UpdateQuantityCartFailure(message: failure.errorMsg));
    }, (response) {
      emit(UpdateQuantityCartSuccess());
      getCart(true);
    });
  }
}
