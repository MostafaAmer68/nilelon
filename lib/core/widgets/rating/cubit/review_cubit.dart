import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'review_state.dart';

class RatingCubit extends Cubit<ReviewState> {
  RatingCubit() : super(ReviewInitial());
  static RatingCubit get(context) => BlocProvider.of(context);
  TextEditingController commentController = TextEditingController();
  double ratingg = 0;
  // Future<void> sendReview(ReviewRequest request) async {
  //   emit(ReviewLoading());
  //   var result = await reviewRepos.review(request);
  //   result.fold((failure) {
  //     emit(ReviewFailure(errMSG: failure.errorMsg));
  //   }, (response) {
  //     emit(ReviewSuccess(response: response));
  //   });
  // }
}
