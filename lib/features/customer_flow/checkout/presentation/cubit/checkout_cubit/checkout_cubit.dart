import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/features/auth/domain/model/user_model.dart';
import 'package:nilelon/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:nilelon/features/order/data/repositories/order_repo_impl.dart';
import 'package:nilelon/features/order/presentation/cubit/order_cubit.dart';

import '../../../../../order/data/models/create_order_model.dart';

part 'checkout_state.dart';

class CheckOutCubit extends Cubit<CheckOutState> {
  final OrderRepoImpl _orderRepo;
  CheckOutCubit(this._orderRepo) : super(CheckOutInitial());
  static CheckOutCubit get(context) => BlocProvider.of(context);
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressLine1 = TextEditingController();
  TextEditingController addressLine2 = TextEditingController();
  TextEditingController streetAddress = TextEditingController();
  TextEditingController unitNumber = TextEditingController();
  TextEditingController landmark = TextEditingController();
  TextEditingController city = TextEditingController();
  String selectedGovernate = '';
  String selectedShippingMethodId = '';
  String selectedOption = '';
  num totalPrice = 0;
  num deliveryPrice = 0;

  Future<void> createOrder(context) async {
    emit(CheckOutLoading());
    final result = await _orderRepo.createOrder(
      CreateOrderModel(
        total: totalPrice.toInt(),
        phoneNum: phoneController.text,
        discount: 0,
        type: selectedOption,
        shippingMethodId: selectedShippingMethodId,
        customerId: HiveStorage.get<UserModel>(HiveKeys.userModel).id,
        governate: selectedGovernate,
        transactionId: '',
        customerAddressDTO: {
          "addressLine1": addressLine1.text,
          "addressLine2": addressLine2.text,
          "city": city.text,
          "unitNumber": unitNumber.text,
          "streetNumber": streetAddress.text,
          "nearestLandMark": landmark.text,
        },
        orderProductVeriants: CartCubit.get(context)
            .cartItems
            .result!
            .items!
            .map((e) => {
                  "size": e.size!,
                  "color": e.color!,
                  "productId": e.productId!,
                  "quantity": e.quantity!,
                  "price": e.price!
                })
            .toList(),
      ),
    );

    result.fold((failure) {
      emit(CheckOutFailure(failure.errorMsg));
    }, (response) {
      emit(CheckOutSuccess());
    });
  }

  Future getShippingMethod(context) async {
    try {
      emit(CheckOutLoading());
      OrderCubit.get(context).getShippingMethod();
      emit(CheckOutSuccess());
    } catch (e) {
      emit(CheckOutFailure(e.toString()));
    }
  }
}
