part of 'category_cubit.dart';


abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategorySuccess extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryFailure extends CategoryState {
  final String message;

  const CategoryFailure(this.message);
}
