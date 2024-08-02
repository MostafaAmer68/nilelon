import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nilelon/features/store_flow/analytics/model/analytics_response_model.dart';

part 'get_no_of_orders_sold_state.freezed.dart';

@freezed
class GetNoOfOrdersSoldState with _$GetNoOfOrdersSoldState {
  const factory GetNoOfOrdersSoldState.initial() = _Initial;
  const factory GetNoOfOrdersSoldState.loading() = _Loading;
  const factory GetNoOfOrdersSoldState.success(
      AnalyticsResponseModel products) = _Success;
  const factory GetNoOfOrdersSoldState.failure(String msg) = _Failure;
}
