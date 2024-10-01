import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nilelon/features/auth/domain/model/user_model.dart';
import 'package:nilelon/features/order/data/models/create_order_model.dart';
import 'package:nilelon/features/order/data/models/order_customer_model.dart';
import 'package:nilelon/features/order/data/models/order_model.dart';
import 'package:nilelon/features/order/data/models/order_store_model.dart';
import 'package:nilelon/features/order/data/models/shipping_method.dart';
import 'package:nilelon/features/order/domain/repositories/order_repo.dart';

import '../../../../core/data/hive_stroage.dart';

part 'order_state.dart';
part 'order_cubit.freezed.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepo _orderRepo;
  static OrderCubit get(context) => BlocProvider.of(context);
  OrderCubit(this._orderRepo) : super(const OrderState.initial());
  List<OrderModel> storeOrders = [];

  List<OrderModel> customerOrders = [];
  String selectedStatus = '';
  List<ShippingMethod> shippingMethods = [];

  OrderCustomerModel customerOrder = OrderCustomerModel.empty();
  OrderStoreModel storeOrder = OrderStoreModel.empty();
  Future<void> createOrder(CreateOrderModel order) async {
    emit(const OrderState.loading());
    final result = await _orderRepo.createOrder(order);
    result.fold(
      (failure) {
        emit(OrderState.failure(failure.errorMsg));
      },
      (response) {
        emit(const OrderState.success());
      },
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
