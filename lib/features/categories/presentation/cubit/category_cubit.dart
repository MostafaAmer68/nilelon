import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/data/hive_stroage.dart';

import '../../domain/repos/category_repos.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  static CategoryCubit get(context) => BlocProvider.of(context);
  CategoryCubit(this.categoryRepos) : super(CategoryInitial());
  final CategoryRepos categoryRepos;
  Future<void> getCategories() async {
    emit(CategoryLoading());

    var result = await categoryRepos.getCategoryRepos();
    result.fold((failure) {
      emit(CategoryFailure(failure.errorMsg));
    }, (response) {
      emit(CategorySuccess());
      HiveStorage.set(
        HiveKeys.categories,
        response.result ?? [],
      );
    });
  }
}
