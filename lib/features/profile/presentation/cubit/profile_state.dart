part of 'profile_cubit.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = _Initial;
  const factory ProfileState.loading() = _Loading;
  const factory ProfileState.success() = _Success;
  // const factory ProfileState.successFollow() = _SuccessFollow;
  const factory ProfileState.failure() = _Failure;
}
