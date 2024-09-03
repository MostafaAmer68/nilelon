part of 'analytics_cubit.dart';

@freezed
class AnalyticsState with _$AnalyticsState {
  const factory AnalyticsState.initial() = _Initial;
  const factory AnalyticsState.loading() = _Loading;
  const factory AnalyticsState.success() = _Success;
  const factory AnalyticsState.failure(String errorMessage) = _Failure;
}
