import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nilelon/features/store_flow/analytics/cubit/get_no_of_followers_sold_state/get_no_of_followers_sold_state.dart';
import 'package:nilelon/features/store_flow/analytics/cubit/get_no_of_items_sold_state/get_no_of_items_sold_state.dart';
import 'package:nilelon/features/store_flow/analytics/cubit/get_no_of_notification/get_no_of_notification.dart';
import 'package:nilelon/features/store_flow/analytics/cubit/get_no_of_orders_sold_state/get_no_of_orders_sold_state.dart';
import 'package:nilelon/features/store_flow/analytics/cubit/get_total_income_sold/get_total_income_sold.dart';

part 'analytics_state.freezed.dart';

@freezed
class AnalyticsState with _$AnalyticsState {
  const factory AnalyticsState({
    required GetNoOfFollowersSoldState getNoOfFollowersSold,
    required GetNoOfItemsSoldState getNoOfItemsSold,
    required GetNoOfNotificationState getNoOfNotification,
    required GetNoOfOrdersSoldState getNoOfOrdersSold,
    required GetTotalIncomeSoldState getTotalIncome,
  }) = _AnalyticsState;

  factory AnalyticsState.initial() => const AnalyticsState(
        getNoOfFollowersSold: GetNoOfFollowersSoldState.initial(),
        getNoOfItemsSold: GetNoOfItemsSoldState.initial(),
        getNoOfNotification: GetNoOfNotificationState.initial(),
        getNoOfOrdersSold: GetNoOfOrdersSoldState.initial(),
        getTotalIncome: GetTotalIncomeSoldState.initial(),
      );
}
