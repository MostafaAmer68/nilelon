import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nilelon/features/store_flow/analytics/model/analytics_response_model.dart';

part 'get_total_income_sold.freezed.dart';

@freezed
class GetTotalIncomeSoldState with _$GetTotalIncomeSoldState {
  const factory GetTotalIncomeSoldState.initial() = _Initial;
  const factory GetTotalIncomeSoldState.loading() = _Loading;
  const factory GetTotalIncomeSoldState.success(
      AnalyticsResponseModel products) = _Success;
  const factory GetTotalIncomeSoldState.failure(String msg) = _Failure;
}
