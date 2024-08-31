import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nilelon/features/auth/domain/model/user_model.dart';
import 'package:nilelon/features/order/data/models/create_order_model.dart';
import 'package:nilelon/features/order/data/models/order_model.dart';
import 'package:nilelon/features/order/domain/repositories/order_repo.dart';

import '../../../../core/data/hive_stroage.dart';

part 'order_state.dart';
part 'order_cubit.freezed.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepo _orderRepo;
  static OrderCubit get(context) => BlocProvider.of(context);
  OrderCubit(this._orderRepo) : super(const OrderState.initial());
  List<StoreOrder> storeOrders = [];
  List<CustomerOrder> customerOrders = [];
  String selectedStatus = '';
  Future<void> createOrder(OrderModel order) async {
    emit(const OrderState.loading());
    final result = await _orderRepo.createOrder(order);
    result.fold(
      (failure) {
        emit(const OrderState.failure());
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
        emit(const OrderState.failure());
      },
      (response) {
        emit(const OrderState.success());
      },
    );
  }

  Future<void> getCustomerOrder(String orderStatus) async {
    emit(const OrderState.loading());
    final result = await _orderRepo.getCustomerOrder(orderStatus);
    result.fold(
      (failure) {
        emit(const OrderState.failure());
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
        emit(const OrderState.failure());
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
        emit(const OrderState.failure());
      },
      (response) {
        storeOrders = response;
        emit(const OrderState.success());
      },
    );
  }

  Future<void> changeOrderStatus(String orderId) async {
    emit(const OrderState.loading());
    final result = await _orderRepo.changeOrderStatus(orderId, selectedStatus);
    result.fold(
      (failure) {
        emit(const OrderState.failure());
      },
      (response) {
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
