part of 'store_register_cubit.dart';

sealed class StoreRegisterState extends Equatable {
  const StoreRegisterState();

  @override
  List<Object> get props => [];
}

final class StoreRegisterInitial extends StoreRegisterState {}
