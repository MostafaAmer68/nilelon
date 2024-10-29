import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nilelon/features/auth/domain/model/user_model.dart';
import 'package:nilelon/features/order/data/models/create_order_model.dart';
import 'package:nilelon/features/order/data/models/order_customer_model.dart';
import 'package:nilelon/features/order/data/models/order_model.dart';
import 'package:nilelon/features/order/data/models/order_store_model.dart';
import 'package:nilelon/features/order/data/models/shipping_method.dart';
import 'package:nilelon/features/order/domain/repositories/order_repo.dart';
import 'package:nilelon/features/payments/presentation/cubit/payment_cubit.dart';
import 'package:nilelon/features/promo/presentation/cubit/promo_cubit.dart';

import '../../../../core/data/hive_stroage.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';

part 'order_state.dart';
part 'order_cubit.freezed.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepo _orderRepo;

  static OrderCubit get(context) => BlocProvider.of(context);
  OrderCubit(this._orderRepo) : super(const OrderState.initial());
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressLine1 = TextEditingController();
  TextEditingController addressLine2 = TextEditingController();
  TextEditingController streetAddress = TextEditingController();
  TextEditingController unitNumber = TextEditingController();
  TextEditingController landmark = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController promoCode = TextEditingController();
  String selectedGovernate = '';
  String selectedShippingMethodId = '';
  String selectedOption = '';
  String selectedCity = '';
  List<OrderModel> storeOrders = [];

  List<OrderModel> customerOrders = [];
  String selectedStatus = '';
  List<ShippingMethod> shippingMethods = [];

  OrderCustomerModel customerOrder = OrderCustomerModel.empty();
  OrderStoreModel storeOrder = OrderStoreModel.empty();
  Future<void> createOrder(context) async {
    emit(const OrderState.loading());
    if (selectedOption == 'Visa Card' || selectedOption == 'Credit Card') {
      // PaymentCubit.get(context)
      //     .dropInPayment(PromoCubit.get(context).totalPrice.toString());
      PaymentCubit.get(context)
          .makeTransaction(
        PromoCubit.get(context).totalPrice.toInt(),
        PromoCubit.get(context).discount,
        'EGP',
      )
          .then(
        (v) async {
          if (HiveStorage.get<String?>(HiveKeys.trans) != null) {
            final result = await _orderRepo.createOrder(
              _createOrderModel(context),
            );
            result.fold(
              (failure) {
                emit(OrderState.failure(failure.errorMsg));
              },
              (response) {
                emit(const OrderState.success());
              },
            );
          }
        },
      );
    } else {
      final result = await _orderRepo.createOrder(
        _createOrderModel(context),
      );
      result.fold(
        (failure) {
          emit(OrderState.failure(failure.errorMsg));
        },
        (response) {
          emit(const OrderState.success());
        },
      );
    }
  }

  CreateOrderModel _createOrderModel(context) {
    return CreateOrderModel(
      total: PromoCubit.get(context).totalPrice.toInt(),
      phoneNum: phoneController.text,
      discount: PromoCubit.get(context).discount,
      type: selectedOption,
      shippingMethodId: selectedShippingMethodId,
      customerId: HiveStorage.get<UserModel>(HiveKeys.userModel).id,
      governate: selectedGovernate,
      transactionId: HiveStorage.get<String?>(HiveKeys.trans) ?? '',
      customerAddressDTO: {
        "customerId": HiveStorage.get<UserModel>(HiveKeys.userModel).id,
        "addressLine1": addressLine1.text,
        "addressLine2": addressLine2.text,
        "city": city.text,
        "unitNumber": unitNumber.text,
        "streetNumber": streetAddress.text,
        "nearestLandMark": landmark.text,
      },
      orderProductVeriants: CartCubit.get(context)
          .tempCartItems
          .map((e) => {
                "size": e.size,
                "color": e.color,
                "productId": e.productId,
                "quantity": e.quantity,
                "price": e.price
              })
          .toList(),
    );
  }

  Future<void> getShippingMethod() async {
    emit(const OrderState.loading());
    final result = await _orderRepo.getShippingMethod();

    result.fold(
      (failure) {
        log(failure.errorMsg);
        emit(OrderState.failure(failure.errorMsg));
      },
      (response) {
        shippingMethods = response;
        selectedGovernate = response.first.name;
        selectedShippingMethodId = response.first.id;
        selectedCity = response.first.shippingCosts.first.governate;
        emit(const OrderState.success());
      },
    );
  }

  Future<void> getCustomerOrder(String orderStatus) async {
    emit(const OrderState.loading());
    final result = await _orderRepo.getCustomerOrder(orderStatus);
    result.fold(
      (failure) {
        emit(OrderState.failure(failure.errorMsg));
      },
      (response) {
        customerOrders = response;
        emit(const OrderState.success());
      },
    );
  }

  Future<void> getStoreOrder(String orderStatus) async {
    emit(const OrderState.loading());
    final result = await _orderRepo.getStoreOrder(orderStatus);
    result.fold(
      (failure) {
        emit(OrderState.failure(failure.errorMsg));
      },
      (response) {
        storeOrders = response;
        emit(const OrderState.success());
      },
    );
  }

  Future<void> getStoreOrderByDate(String date) async {
    emit(const OrderState.loading());
    final result = await _orderRepo.getStoreOrderByDate(date);
    result.fold(
      (failure) {
        emit(OrderState.failure(failure.errorMsg));
      },
      (response) {
        storeOrders = response;
        emit(const OrderState.success());
      },
    );
  }

  Future<void> changeOrderStatus(String orderId, String status) async {
    emit(const OrderState.loading());
    final result = await _orderRepo.changeOrderStatus(orderId, status);
    result.fold(
      (failure) {
        emit(OrderState.failure(failure.errorMsg));
      },
      (response) {
        emit(const OrderState.success());
      },
    );
  }

  Future<void> getCustomerOrderDetailsById(String orderId) async {
    emit(const OrderState.loading());
    final result = await _orderRepo.getCustomerOrderDetailsById(orderId);
    result.fold(
      (failure) {
        emit(OrderState.failure(failure.errorMsg));
      },
      (response) {
        customerOrder = response;
        emit(const OrderState.success());
      },
    );
  }

  Future<void> getStoreOrderDetailsById(String orderId) async {
    emit(const OrderState.loading());
    final result = await _orderRepo.getStoreOrderDetailsById(orderId);
    result.fold(
      (failure) {
        emit(OrderState.failure(failure.errorMsg));
      },
      (response) {
        storeOrder = response;
        emit(const OrderState.success());
      },
    );
  }

  convertOrderModel(model) {
    return HiveStorage.get(HiveKeys.isStore)
        ? model as StoreModel
        : model as CustomerModel;
  }
}
