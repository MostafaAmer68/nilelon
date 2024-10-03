import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProgressCubit extends Cubit<int> {
  ProgressCubit() : super(0);
  static ProgressCubit get(context) => BlocProvider.of(context);
  final PageController pageController = PageController();
  void nextStep() {
    if (state < 3) {
      pageController.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
      emit(state + 1);
    }
  }

  void previousStep() {
    if (state > 0) {
      pageController.previousPage(
          duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
      emit(state - 1);
    }
  }
}
