import 'package:flutter_bloc/flutter_bloc.dart';

class ProgressCubit extends Cubit<int> {
  ProgressCubit() : super(0);
  static ProgressCubit get(context) => BlocProvider.of(context);

  void nextStep() => emit(state + 1);
  void previousStep() {
    if (state > 0) {
      emit(state - 1);
    }
  }
}
