import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/features/categories/domain/model/result.dart';

import '../../domain/repo/category_repos.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  static CategoryCubit get(context) => BlocProvider.of(context);
  CategoryCubit(this.categoryRepos) : super(CategoryInitial());
  final CategoryRepos categoryRepos;
  Future<void> getCategories() async {
    emit(CategoryLoading());

    final result = await categoryRepos.getCategories();
    result.fold(
      (failure) {
        log(failure.errorMsg);
        emit(CategoryFailure(failure.errorMsg));
      },
      (response) {
        emit(CategorySuccess());
        response.add(CategoryModel.empty());
        response = response.reversed.toList();
        HiveStorage.set<List<CategoryModel>>(
          HiveKeys.categories,
          response,
        );
      },
    );
  }
}
