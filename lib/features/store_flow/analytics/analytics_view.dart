import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/features/store_flow/analytics/cubit/analytics_cubit/analytics_cubit.dart';
import 'package:nilelon/features/store_flow/analytics/cubit/analytics_cubit/analytics_state.dart';
import 'package:nilelon/features/store_flow/analytics/cubit/reservation_cubit/reservation_date_cubit.dart';
import 'package:nilelon/features/store_flow/analytics/widget/analytics_rating_row.dart';
import 'package:nilelon/features/store_flow/analytics/widget/date_row.dart';
import 'package:nilelon/features/store_flow/analytics/widget/line_chart_sample.dart';
import 'package:nilelon/features/store_flow/guide_book/cubit/guide_book_cubit.dart';
import 'package:nilelon/features/store_flow/guide_book/guide_book_view.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/resources/appstyles_manager.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/resources/const_functions.dart';
import 'package:nilelon/utils/navigation.dart';
import 'package:nilelon/widgets/button/outlined_button_builder.dart';
import 'package:nilelon/widgets/cards/analytics/analytics_big_card.dart';
import 'package:nilelon/widgets/cards/analytics/analytics_small_card.dart';
import 'package:nilelon/widgets/cards/wide/analytics_wide_card.dart';
import 'package:nilelon/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/widgets/divider/default_divider.dart';
import 'package:nilelon/widgets/shimmer_indicator/build_shimmer.dart';
import 'package:nilelon/widgets/view_all_row/view_all_row.dart';

class AnalyticsView extends StatefulWidget {
  const AnalyticsView({super.key});

  @override
  State<AnalyticsView> createState() => _AnalyticsViewState();
}

class _AnalyticsViewState extends State<AnalyticsView> {
  @override
  void initState() {
    BlocProvider.of<AnalyticsCubit>(context).getNoOfFollowersSold();
    // BlocProvider.of<AnalyticsCubit>(context).getNoOfItemsSold();
    // BlocProvider.of<AnalyticsCubit>(context).getNoOfNotification();
    // BlocProvider.of<AnalyticsCubit>(context).getNoOfOrdersSold();
    // BlocProvider.of<AnalyticsCubit>(context).getTotalIncomeSold();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    DateTime? dateStart;
    DateTime? dateEnd;
    return Scaffold(
      backgroundColor: ColorManager.primaryW,
      appBar: customAppBar(
        hasLeading: false,
        title: lang.analytics,
        context: context,
        hasIcon: false,
      ),
      body: SingleChildScrollView(
        child: Column(
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
                    const AnalyticsRatingRow(
                      rate: 4,
                    ),
                    const SizedBox(
                      height: 24,
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
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: analyticsWideCard(context: context),
                        ),
                        itemCount: 5,
                      ),
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
                    height: screenHeight(context, 0.22),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.sp),
                      child: Row(
                        children: [
                          BlocBuilder<AnalyticsCubit, AnalyticsState>(
                            builder: (context, state) {
                              return state.getNoOfItemsSold.when(
                                initial: () =>
                                    buildShimmerIndicatorAnalyticsBigCard(
                                        context),
                                loading: () =>
                                    buildShimmerIndicatorAnalyticsBigCard(
                                        context),
                                success: (itemsSold) => AnalyticsBigCard(
                                  title: lang.ofItemsSold,
                                  number: (itemsSold.result ?? 0).toInt(),
                                  average: 700,
                                ),
                                failure: (fail) => AnalyticsBigCard(
                                  title: lang.ofItemsSold,
                                  number: 0,
                                  average: 700,
                                ),
                              );
                            },
                          ),
                          const Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BlocBuilder<AnalyticsCubit, AnalyticsState>(
                                builder: (context, state) {
                                  return state.getNoOfOrdersSold.when(
                                    initial: () =>
                                        buildShimmerIndicatorAnalyticsSmallCard(
                                            context),
                                    loading: () =>
                                        buildShimmerIndicatorAnalyticsSmallCard(
                                            context),
                                    success: (noOfOrders) => AnalyticsSmallCard(
                                      title: lang.ofOrders,
                                      number: (noOfOrders.result ?? 0).toInt(),
                                      average: 700,
                                    ),
                                    failure: (fail) => AnalyticsSmallCard(
                                      title: lang.ofOrders,
                                      number: 0,
                                      average: 700,
                                    ),
                                  );
                                },
                              ),
                              // AnalyticsSmallCard(
                              //   title: lang.ofOrders,
                              //   number: 168,
                              //   average: 700,
                              // ),
                              BlocBuilder<AnalyticsCubit, AnalyticsState>(
                                builder: (context, state) {
                                  return state.getTotalIncome.when(
                                    initial: () =>
                                        buildShimmerIndicatorAnalyticsSmallCard(
                                            context),
                                    loading: () =>
                                        buildShimmerIndicatorAnalyticsSmallCard(
                                            context),
                                    success: (itemsSold) => AnalyticsSmallCard(
                                      title: lang.totalIncome,
                                      number: (itemsSold.result ?? 0).toInt(),
                                      average: 700,
                                      isGreen: true,
                                    ),
                                    failure: (fail) => AnalyticsSmallCard(
                                      title: lang.totalIncome,
                                      number: 0,
                                      average: 700,
                                      isGreen: true,
                                    ),
                                  );
                                },
                              ),
                              // AnalyticsSmallCard(
                              //   title: lang.totalIncome,
                              //   number: 168,
                              //   average: 700,
                              //   isGreen: true,
                              // ),
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
                        BlocBuilder<AnalyticsCubit, AnalyticsState>(
                          builder: (context, state) {
                            return state.getNoOfFollowersSold.when(
                              initial: () =>
                                  buildShimmerIndicatorAnalyticsBigCard(
                                      context),
                              loading: () =>
                                  buildShimmerIndicatorAnalyticsBigCard(
                                      context),
                              success: (itemsSold) => AnalyticsBigCard(
                                title: lang.ofFollowers,
                                number: (itemsSold.result ?? 0).toInt(),
                                average: 700,
                                isOrange: false,
                              ),
                              failure: (fail) => AnalyticsBigCard(
                                title: lang.ofFollowers,
                                number: 0,
                                average: 700,
                                isOrange: false,
                              ),
                            );
                          },
                        ),
                        // AnalyticsBigCard(
                        //   title: lang.ofFollowers,
                        //   number: 168,
                        //   average: 700,
                        //   isOrange: false,
                        // ),
                        BlocBuilder<AnalyticsCubit, AnalyticsState>(
                          builder: (context, state) {
                            return state.getNoOfNotification.when(
                              initial: () =>
                                  buildShimmerIndicatorAnalyticsBigCard(
                                      context),
                              loading: () =>
                                  buildShimmerIndicatorAnalyticsBigCard(
                                      context),
                              success: (itemsSold) => AnalyticsBigCard(
                                title: lang.ofNoified,
                                number: (itemsSold.result ?? 0).toInt(),
                                average: 700,
                              ),
                              failure: (fail) => AnalyticsBigCard(
                                title: lang.ofNoified,
                                number: 0,
                                average: 700,
                              ),
                            );
                          },
                        ),
                        // AnalyticsBigCard(
                        //   title: lang.ofNoified,
                        //   number: 168,
                        //   average: 700,
                        // ),
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
