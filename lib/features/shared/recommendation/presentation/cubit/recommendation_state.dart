part of 'recommendation_cubit.dart';

abstract class RecommendationState {}

class RecommendationInitial extends RecommendationState {}

class RecommendationLoading extends RecommendationState {}

class RecommendationSuccess extends RecommendationState {}

class RecommendationFailure extends RecommendationState {}
