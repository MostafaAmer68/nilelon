part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartSuccess extends CartState {}

class GetCartSuccess extends CartState {
}

class GetCartFailure extends CartState {
  final String message;

  const GetCartFailure({required this.message});
}

class DeleteFromCartSuccess extends CartState {}

class DeleteFromCartFailure extends CartState {
  final String message;

  const DeleteFromCartFailure({required this.message});
}

class UpdateQuantityCartSuccess extends CartState {}

class UpdateQuantityCartLoading extends CartState {}

class UpdateQuantityCartFailure extends CartState {
  final String message;

  const UpdateQuantityCartFailure({required this.message});
}
