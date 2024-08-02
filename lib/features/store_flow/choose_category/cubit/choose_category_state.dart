part of 'choose_category_cubit.dart';

abstract class ChooseCategoryState extends Equatable {
  const ChooseCategoryState();

  @override
  List<Object> get props => [];
}

class ChooseCategoryInitial extends ChooseCategoryState {}

class ChooseCategorySuccess extends ChooseCategoryState {}

class ChooseCategoryLoading extends ChooseCategoryState {}

class ChooseCategoryFailure extends ChooseCategoryState {
  final String message;

  const ChooseCategoryFailure(this.message);
}
