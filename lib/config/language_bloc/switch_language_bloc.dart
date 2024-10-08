import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/core/data/hive_stroage.dart';

part 'switch_language_event.dart';
part 'switch_language_state.dart';

class SwitchLanguageCubit
    extends Bloc<SwitchLanguageEvent, SwitchLanguageState> {
  static SwitchLanguageCubit get(context) => BlocProvider.of(context);
  SwitchLanguageCubit() : super(const SwitchLanguageInitial(false)) {
    on<ArabicLanguageEvent>((event, emit) {
      HiveStorage.set(HiveKeys.isArabic, true);
      emit(const SwitchLanguageInitial(true));
    });
    on<EnglishLanguageEvent>((event, emit) {
      HiveStorage.set(HiveKeys.isArabic, false);
      emit(const SwitchLanguageInitial(false));
    });
  }
}
