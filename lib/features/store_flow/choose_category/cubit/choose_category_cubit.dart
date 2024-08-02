import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/data/hive_stroage.dart';
import 'package:nilelon/features/store_flow/choose_category/repos/choose_category_repos.dart';

part 'choose_category_state.dart';

class ChooseCategoryCubit extends Cubit<ChooseCategoryState> {
  ChooseCategoryCubit(this.chooseCategoryRepos)
      : super(ChooseCategoryInitial());
  final ChooseCategoryRepos chooseCategoryRepos;
  Future<void> getCategories() async {
    emit(ChooseCategoryLoading());

    var result = await chooseCategoryRepos.getCategoryRepos();
    result.fold((failure) {
      emit(ChooseCategoryFailure(failure.errorMsg));
    }, (response) {
      emit(ChooseCategorySuccess());
      HiveStorage.set(
        HiveKeys.categories,
        response.result ?? [],
      );
    });
  }
}
