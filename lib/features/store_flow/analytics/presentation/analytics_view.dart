import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/features/store_flow/analytics/presentation/cubit/reservation_cubit/reservation_date_cubit.dart';
import 'package:nilelon/features/store_flow/analytics/presentation/widget/analytics_rating_row.dart';
import 'package:nilelon/features/store_flow/analytics/presentation/widget/date_row.dart';
import 'package:nilelon/features/store_flow/analytics/presentation/widget/line_chart_sample.dart';
import 'package:nilelon/features/store_flow/guide_book/cubit/guide_book_cubit.dart';
import 'package:nilelon/features/store_flow/guide_book/guide_book_view.dart';
import 'package:nilelon/core/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/button/outlined_button_builder.dart';
import 'package:nilelon/core/widgets/cards/analytics/analytics_big_card.dart';
import 'package:nilelon/core/widgets/cards/analytics/analytics_small_card.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/view_all_row/view_all_row.dart';

import '../../../../core/widgets/scaffold_image.dart';
import '../../../../core/widgets/shimmer_indicator/build_shimmer.dart';
import 'cubit/analytics_cubit.dart';

class AnalyticsView extends StatefulWidget {
  const AnalyticsView({super.key});

  @override
  State<AnalyticsView> createState() => _AnalyticsViewState();
}

class _AnalyticsViewState extends State<AnalyticsView> {
  late final AnalyticsCubit cubit;
  @override
  void initState() {
    BlocProvider.of<AnalyticsCubit>(context).getDashboardData();
    cubit = AnalyticsCubit.get(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    DateTime? dateStart;
    DateTime? dateEnd;
    return ScaffoldImage(
      appBar: customAppBar(
        hasLeading: false,
        title: lang.analytics,
        context: context,
        hasIcon: false,
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<AnalyticsCubit, AnalyticsState>(
          builder: (context, state) {
            return state.when(failure: (err) {
              return Text(err);
            }, initial: () {
              return const SizedBox();
            }, loading: () {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const DefaultDivider(),
                  SizedBox(
                    height: 30.h,
                  ),
                  SizedBox(
                    width: screenWidth(context, 0.8),
                    child: const LineChartSample(),
                  ),
                  SizedBox(
                    height: screenHeight(context, 0.33),
                    child: Padding(
                      padding: EdgeInsets.all(16.0.sp),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          ViewAllRow(
                            noPadding: true,
                            text: lang.bestSeller,
                            noButton: true,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          SizedBox(
                              height: 1.sw > 600 ? 220 : 145,
                              width: screenWidth(context, 1),
                              child: buildShimmerIndicatorAnalyticsBigCard(
                                  context)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    width: screenWidth(context, 1),
                    color: ColorManager.primaryG17,
                    child: Column(
                      children: [
                        OutlinedButtonBuilder(
                          text: lang.guideBook,
                          ontap: () {
                            navigateTo(
                                context: context,
                                screen: BlocProvider<GuideBookCubit>(
                                  create: (context) => GuideBookCubit(),
                                  child: const GuideBookView(),
                                ));
                          },
                          withIcon: true,
                          height: 55.h,
                          iconData: Icons.book_outlined,
                          width: screenWidth(context, 0.92),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        BlocBuilder<ReservationDateCubit, ReservationDateState>(
                          builder: (context, state) {
                            var cubit =
                                BlocProvider.of<ReservationDateCubit>(context);
                            dateStart = cubit.rangeStart;
                            dateEnd = cubit.rangeEnd;

                            return DateRow(
                              dateEnd: dateEnd,
                              dateStart: dateStart,
                            );
                          },
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        textWithInfoColumn(lang.mos,
                            lang.isANumberThatHelpYouToKnowHowGoodYoureAsABrandHowMuchSalesShouldBeYourNextTargetAndWhereYouAreStandingInYourMarket),
                        SizedBox(
                          height: screenHeight(context, 0.22),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.sp),
                            child: Row(
                              children: [
                                buildShimmerIndicatorAnalyticsBigCard(context),
                                const Spacer(),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    buildShimmerIndicatorAnalyticsSmallCard(
                                        context),
                                    buildShimmerIndicatorAnalyticsSmallCard(
                                        context),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        textWithInfoColumn(lang.kpis,
                            lang.AreNumbersWhichIndicatingThatYouareOnTheRightPathToReachYourGoalsEveryTimeTheseNumbersGotHigherThatMeansKeepItGoingYouAreNearerToYourGoalsMoreThanYesterday),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildShimmerIndicatorAnalyticsBigCard(context),
                              buildShimmerIndicatorAnalyticsBigCard(context),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16.sp,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }, success: () {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const DefaultDivider(),
                  SizedBox(
                    height: 30.h,
                  ),
                  SizedBox(
                    width: screenWidth(context, 0.8),
                    child: const LineChartSample(),
                  ),
                  SizedBox(
                    height: screenHeight(context, 0.33),
                    child: Padding(
                      padding: EdgeInsets.all(16.0.sp),
                      child: Column(
                        children: [
                          AnalyticsRatingRow(
                            rate: cubit.dashboardModel.storeRate.toDouble(),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ViewAllRow(
                            noPadding: true,
                            text: lang.bestSeller,
                            noButton: true,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          SizedBox(
                            height: 1.sw > 600 ? 220 : 145,
                            width: screenWidth(context, 1),
                            child: Center(
                                child:
                                    Text(cubit.dashboardModel.storeBestseller)),
                            // ListView.builder(
                            //   shrinkWrap: true,
                            //   scrollDirection: Axis.horizontal,
                            //   itemBuilder: (context, index) => Padding(
                            //     padding: const EdgeInsets.only(right: 8),
                            //     child: analyticsWideCard(context: context),
                            //   ),
                            //   itemCount: 5,
                            // ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    width: screenWidth(context, 1),
                    color: ColorManager.primaryG17,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        OutlinedButtonBuilder(
                          text: lang.guideBook,
                          ontap: () {
                            navigateTo(
                                context: context,
                                screen: BlocProvider<GuideBookCubit>(
                                  create: (context) => GuideBookCubit(),
                                  child: const GuideBookView(),
                                ));
                          },
                          withIcon: true,
                          height: 55.h,
                          iconData: Icons.book_outlined,
                          width: screenWidth(context, 0.92),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        BlocBuilder<ReservationDateCubit, ReservationDateState>(
                          builder: (context, state) {
                            var cubit =
                                BlocProvider.of<ReservationDateCubit>(context);
                            dateStart = cubit.rangeStart;
                            dateEnd = cubit.rangeEnd;

                            return DateRow(
                              dateEnd: dateEnd,
                              dateStart: dateStart,
                            );
                          },
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        textWithInfoColumn(lang.mos,
                            lang.isANumberThatHelpYouToKnowHowGoodYoureAsABrandHowMuchSalesShouldBeYourNextTargetAndWhereYouAreStandingInYourMarket),
                        SizedBox(
                          height: screenHeight(context, 0.24),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.sp),
                            child: Row(
                              children: [
                                AnalyticsBigCard(
                                  title: lang.ofItemsSold,
                                  number: (cubit.dashboardModel.storeFollowers)
                                      .toInt(),
                                  average: 700,
                                ),
                                const Spacer(),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AnalyticsSmallCard(
                                      title: lang.ofOrders,
                                      number: (cubit
                                              .dashboardModel.storeOrdersNumber)
                                          .toInt(),
                                      average: 700,
                                    ),
                                    AnalyticsSmallCard(
                                      title: lang.totalIncome,
                                      number: (cubit
                                              .dashboardModel.storeTotalIncome)
                                          .toInt(),
                                      average: 700,
                                      isGreen: true,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        textWithInfoColumn(lang.kpis,
                            lang.AreNumbersWhichIndicatingThatYouareOnTheRightPathToReachYourGoalsEveryTimeTheseNumbersGotHigherThatMeansKeepItGoingYouAreNearerToYourGoalsMoreThanYesterday),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AnalyticsBigCard(
                                title: lang.ofFollowers,
                                number: (cubit.dashboardModel.storeFollowers)
                                    .toInt(),
                                average: 700,
                                isOrange: false,
                              ),
                              AnalyticsBigCard(
                                title: lang.ofNoified,
                                number: (cubit.dashboardModel
                                        .storeNumberOfNotifications)
                                    .toInt(),
                                average: 700,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16.sp,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            });
          },
        ),
      ),
    );
  }

  Padding textWithInfoColumn(String text, String text2) {
    return Padding(
      padding: EdgeInsets.all(16.0.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: AppStylesManager.customTextStyleBl3,
          ),
          SizedBox(
            height: 12.h,
          ),
          Text(text2, style: AppStylesManager.customTextStyleG24),
          SizedBox(
            height: 8.h,
          ),
        ],
      ),
    );
  }
}
