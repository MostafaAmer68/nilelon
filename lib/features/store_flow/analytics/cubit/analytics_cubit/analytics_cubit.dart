import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/features/store_flow/analytics/cubit/get_no_of_followers_sold_state/get_no_of_followers_sold_state.dart';
import 'package:nilelon/features/store_flow/analytics/cubit/get_no_of_items_sold_state/get_no_of_items_sold_state.dart';
import 'package:nilelon/features/store_flow/analytics/cubit/get_no_of_notification/get_no_of_notification.dart';
import 'package:nilelon/features/store_flow/analytics/cubit/get_no_of_orders_sold_state/get_no_of_orders_sold_state.dart';
import 'package:nilelon/features/store_flow/analytics/cubit/get_total_income_sold/get_total_income_sold.dart';
import 'package:nilelon/features/store_flow/analytics/repos/analytics_repos.dart';

import 'analytics_state.dart';

class AnalyticsCubit extends Cubit<AnalyticsState> {
  final AnalyticsRepos analyticsRepos;
  AnalyticsCubit(this.analyticsRepos) : super(AnalyticsState.initial());

  //?*********************************************************************************
  //todo Get No Of Followers Sold
  //?*********************************************************************************

  Future<void> getNoOfFollowersSold() async {
    emit(state.copyWith(
        getNoOfFollowersSold: const GetNoOfFollowersSoldState.loading()));
    var result = await analyticsRepos.getNoOfFollowersSold();
    result.fold((failure) {
      emit(state.copyWith(
          getNoOfFollowersSold:
              GetNoOfFollowersSoldState.failure(failure.errorMsg)));
    }, (response) {
      emit(state.copyWith(
          getNoOfFollowersSold: GetNoOfFollowersSoldState.success(response)));
    });
    getNoOfItemsSold();
  }

  //?*********************************************************************************

  //?*********************************************************************************
  //todo Get No Of Items Sold
  //?*********************************************************************************

  Future<void> getNoOfItemsSold() async {
    emit(state.copyWith(
        getNoOfItemsSold: const GetNoOfItemsSoldState.loading()));
    var result = await analyticsRepos.getNoOfItemsSold();
    result.fold((failure) {
      emit(state.copyWith(
          getNoOfItemsSold: GetNoOfItemsSoldState.failure(failure.errorMsg)));
    }, (response) {
      emit(state.copyWith(
          getNoOfItemsSold: GetNoOfItemsSoldState.success(response)));
    });
    getNoOfNotification();
  }

  //?*********************************************************************************

  //?*********************************************************************************
  //todo Get No Of Notifications
  //?*********************************************************************************

  Future<void> getNoOfNotification() async {
    emit(state.copyWith(
        getNoOfNotification: const GetNoOfNotificationState.loading()));
    var result = await analyticsRepos.getNoOfNotificationSold();
    result.fold((failure) {
      emit(state.copyWith(
          getNoOfNotification:
              GetNoOfNotificationState.failure(failure.errorMsg)));
    }, (response) {
      emit(state.copyWith(
          getNoOfNotification: GetNoOfNotificationState.success(response)));
    });
    getNoOfOrdersSold();
  }

  //?*********************************************************************************

  //?*********************************************************************************
  //todo Get No Of Orders Sold
  //?*********************************************************************************

  Future<void> getNoOfOrdersSold() async {
    emit(state.copyWith(
        getNoOfOrdersSold: const GetNoOfOrdersSoldState.loading()));
    var result = await analyticsRepos.getNoOfOrdersSold();
    result.fold((failure) {
      emit(state.copyWith(
          getNoOfOrdersSold: GetNoOfOrdersSoldState.failure(failure.errorMsg)));
    }, (response) {
      emit(state.copyWith(
          getNoOfOrdersSold: GetNoOfOrdersSoldState.success(response)));
    });
    getTotalIncomeSold();
  }

  //?*********************************************************************************

  //?*********************************************************************************
  //todo Get No Of Total Income Sold
  //?*********************************************************************************

  Future<void> getTotalIncomeSold() async {
    emit(state.copyWith(
        getTotalIncome: const GetTotalIncomeSoldState.loading()));
    var result = await analyticsRepos.getTotalIncomeSold();
    result.fold((failure) {
      emit(state.copyWith(
          getTotalIncome: GetTotalIncomeSoldState.failure(failure.errorMsg)));
    }, (response) {
      emit(state.copyWith(
          getTotalIncome: GetTotalIncomeSoldState.success(response)));
    });
  }

  //?*********************************************************************************
}
