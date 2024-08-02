import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nilelon/features/store_flow/analytics/model/analytics_response_model.dart';

part 'get_no_of_followers_sold_state.freezed.dart';

@freezed
class GetNoOfFollowersSoldState with _$GetNoOfFollowersSoldState {
  const factory GetNoOfFollowersSoldState.initial() = _Initial;
  const factory GetNoOfFollowersSoldState.loading() = _Loading;
  const factory GetNoOfFollowersSoldState.success(
      AnalyticsResponseModel products) = _Success;
  const factory GetNoOfFollowersSoldState.failure(String msg) = _Failure;
}
