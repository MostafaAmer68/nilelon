import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nilelon/features/store_flow/analytics/model/analytics_response_model.dart';

part 'get_no_of_notification.freezed.dart';

@freezed
class GetNoOfNotificationState with _$GetNoOfNotificationState {
  const factory GetNoOfNotificationState.initial() = _Initial;
  const factory GetNoOfNotificationState.loading() = _Loading;
  const factory GetNoOfNotificationState.success(
      AnalyticsResponseModel products) = _Success;
  const factory GetNoOfNotificationState.failure(String msg) = _Failure;
}
