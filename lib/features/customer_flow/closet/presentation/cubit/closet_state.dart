part of 'closet_cubit.dart';

@freezed
class ClosetState with _$ClosetState {
  const factory ClosetState.initial() = _Initial;
  const factory ClosetState.loading() = _Loading;
  const factory ClosetState.success() = _Success;
  const factory ClosetState.failure() = _failure;
}
