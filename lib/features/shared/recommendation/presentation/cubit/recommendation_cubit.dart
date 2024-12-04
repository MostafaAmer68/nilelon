import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/features/layout/customer_bottom_tab_bar.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_cubit.dart';
import 'package:nilelon/features/shared/recommendation/domain/repos/reccomendation_repos.dart';
import 'package:nilelon/my_app.dart';

import '../../../../../core/data/hive_stroage.dart';
import '../../../../auth/domain/model/user_model.dart';

part 'recommendation_state.dart';

class RecommendationCubit extends Cubit<RecommendationState> {
  static RecommendationCubit get(context) =>
      BlocProvider.of<RecommendationCubit>(context);
  RecommendationCubit(this.reccomendationRepos)
      : super(RecommendationInitial());
  ReccomendationRepos reccomendationRepos;
  void setRecommendation(String gender, context) async {
    emit(RecommendationLoading());
    final result = await reccomendationRepos.setRecommendation(gender);
    result.fold((er) {
      BotToast.showText(text: "Failed to update, Try later");

      emit(RecommendationFailure());
    }, (response) {
      BotToast.showText(text: response);
      navigateAndRemoveUntil(
        context: context,
        screen: const CustomerBottomTabBar(),
      );
      ProductsCubit.get(context).gendar = '';

      ProductsCubit.get(context).getFollowedProducts();
      // MyApp.restartApp(context);
      emit(RecommendationSuccess());
    });
    // emit(RecommendationSuccess());
  }
}
