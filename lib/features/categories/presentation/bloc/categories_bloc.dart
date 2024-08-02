import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:nilelon/features/categories/data/datasources/category_services.dart';
import 'package:nilelon/features/categories/data/repositories/category_repo_impl.dart';
import 'package:nilelon/service/set_up_locator_service.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  List<String> categories = [];
  CategoriesBloc() : super(CategoriesInitial()) {
    on<FetchCateogries>((event, emit) async {
      emit(CategoriesLoading());
      try {
        final results =
            await locatorService<CategoryRepoImpl>().fetchCategories();
        categories = results;
        emit(CategoriesSuccess());
      } catch (e) {
        emit(CategoriesFailure());
      }
    });
  }
}
