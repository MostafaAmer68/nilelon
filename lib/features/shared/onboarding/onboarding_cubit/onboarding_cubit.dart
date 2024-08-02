import 'package:flutter_bloc/flutter_bloc.dart';
part 'onboarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  static OnBoardingCubit get(context) =>
      BlocProvider.of<OnBoardingCubit>(context);
  OnBoardingCubit() : super(OnBoardingInitial());
  bool isLast = false;
  int index = 0;

  void changeisLast(bool value) {
    isLast = value;
  }
}
