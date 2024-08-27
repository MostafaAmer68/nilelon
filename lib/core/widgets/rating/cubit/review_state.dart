part of 'review_cubit.dart';

abstract class ReviewState extends Equatable {
  const ReviewState();

  @override
  List<Object> get props => [];
}

class ReviewInitial extends ReviewState {}

class ReviewSuccess extends ReviewState {
  // final ReviewResponse response;

  const ReviewSuccess();
}

class ReviewFailure extends ReviewState {
  final String errMSG;

  const ReviewFailure({required this.errMSG});
}

class ReviewLoading extends ReviewState {}
