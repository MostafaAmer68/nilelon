import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nilelon/features/store_flow/analytics/data/repos_impl/analytics_repos_impl.dart';
import 'package:nilelon/features/store_flow/analytics/domain/model/analytics_response_model.dart';

part 'analytics_state.dart';
part 'analytics_cubit.freezed.dart';

class AnalyticsCubit extends Cubit<AnalyticsState> {
  final AnalyticsReposImpl _analyticsReposImpl;
  static AnalyticsCubit get(context) => BlocProvider.of(context);
  AnalyticsCubit(this._analyticsReposImpl)
      : super(const AnalyticsState.initial());
  DashboardModel dashboardModel = DashboardModel.empty();
  Future<void> getDashboardData() async {
    emit(const AnalyticsState.loading());
    final result = await _analyticsReposImpl.getDashboardData();
    result.fold((er) {
      emit(AnalyticsState.failure(er.errorMsg));
    }, (response) {
      dashboardModel = response;
      emit(const AnalyticsState.success());
    });
  }
}