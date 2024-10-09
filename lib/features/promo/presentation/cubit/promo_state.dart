part of 'promo_cubit.dart';

abstract class PromoState extends Equatable {
  const PromoState();

  @override
  List<Object> get props => [];
}

class PromoInitial extends PromoState {}

class PromoLoading extends PromoState {}

class PromoSuccess extends PromoState {}

class PromoFailure extends PromoState {
  final String errMsg;

  const PromoFailure(this.errMsg);
}
