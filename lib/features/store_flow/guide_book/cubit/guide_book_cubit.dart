import 'package:flutter_bloc/flutter_bloc.dart';

import 'guide_book_states.dart';

class GuideBookCubit extends Cubit<GuideBookStates> {
  static GuideBookCubit get(context) =>
      BlocProvider.of<GuideBookCubit>(context);
  GuideBookCubit() : super(GuideBookInitial());
  bool isLast = false;
  int index = 0;

  void changeisLast(bool value) {
    isLast = value;
  }
}
