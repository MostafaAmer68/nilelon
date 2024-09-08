import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/features/cart/domain/model/add_cart_request_model.dart';
import 'package:nilelon/features/cart/domain/model/change_quantity_model.dart';
import 'package:nilelon/features/cart/domain/model/delete_request_model.dart';
import 'package:nilelon/features/cart/domain/model/get_cart_model/cart_item.dart';
import 'package:nilelon/features/cart/domain/repos/cart_repos.dart';

import '../../../auth/domain/model/user_model.dart';
import '../../domain/model/get_cart_model/get_cart_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this.cartRepos) : super(CartInitial());
  final CartRepos cartRepos;
  String selectedSize = '';
  String selectedColor = '';
  List<CartItem> tempCartItems = [];
  int counter = 1;
  static CartCubit get(context) => BlocProvider.of<CartCubit>(context);
  Future<void> emptyCart() async {
    emit(CartLoading());

    var result = await cartRepos
        .emptyCart(HiveStorage.get<UserModel>(HiveKeys.userModel).id);
    result.fold((failure) {
      emit(GetCartFailure(message: failure.errorMsg));
    }, (response) {
      emit(const GetCartSuccess(items: []));
    });
  }

  late GetCartModel cartItems;
  Future<void> addToCart(AddToCartModel model) async {
    emit(CartLoading());

    var result = await cartRepos.addToCart(model);
    result.fold((failure) {
      emit(GetCartFailure(message: failure.errorMsg));
      print('proudct added');
    }, (response) {
      emit(CartSuccess());
    });
  }

  Future<void> getCart() async {
    emit(CartLoading());

    var result = await cartRepos.getCart();
    result.fold((failure) {
      emit(GetCartFailure(message: failure.errorMsg));
    }, (response) {
      cartItems = response;

      emit(GetCartSuccess(items: response.result?.items ?? []));
    });
  }

  Future<void> deleteFromCart(DeleteRequestModel model) async {
    emit(CartLoading());

    var result = await cartRepos.deleteFromCart(model);
    result.fold((failure) {
      emit(DeleteFromCartFailure(message: failure.errorMsg));
      emit(GetCartSuccess(items: cartItems.result!.items!));
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
