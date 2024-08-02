import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nilelon/features/store_flow/analytics/model/analytics_response_model.dart';

part 'get_no_of_items_sold_state.freezed.dart';

@freezed
class GetNoOfItemsSoldState with _$GetNoOfItemsSoldState {
  const factory GetNoOfItemsSoldState.initial() = _Initial;
  const factory GetNoOfItemsSoldState.loading() = _Loading;
  const factory GetNoOfItemsSoldState.success(AnalyticsResponseModel products) =
      _Success;
  const factory GetNoOfItemsSoldState.failure(String msg) = _Failure;
}
