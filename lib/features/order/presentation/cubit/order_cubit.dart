import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nilelon/features/order/data/models/order_model.dart';
import 'package:nilelon/features/order/domain/repositories/order_repo.dart';

part 'order_state.dart';
part 'order_cubit.freezed.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepo _orderRepo;
  OrderCubit(this._orderRepo) : super(const OrderState.initial());

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

  Future<void> getCustomerOrder(String orderStatus) async {
    emit(const OrderState.loading());
    final result = await _orderRepo.getCustomerOrder(orderStatus);
    result.fold(
      (failure) {
        emit(const OrderState.failure());
      },
      (response) {
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
        emit(const OrderState.success());
      },
    );
  }

  Future<void> changeOrderStatus(String orderId, String orderStatus) async {
    emit(const OrderState.loading());
    final result = await _orderRepo.changeOrderStatus(orderId, orderStatus);
    result.fold(
      (failure) {
        emit(const OrderState.failure());
      },
      (response) {
        emit(const OrderState.success());
      },
    );
  }
}
