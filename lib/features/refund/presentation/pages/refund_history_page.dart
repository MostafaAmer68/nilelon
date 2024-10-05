import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/cards/customer_order_management/returned_customer_card.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/scaffold_image.dart';
import 'package:nilelon/core/widgets/shimmer_indicator/build_shimmer.dart';
import 'package:nilelon/features/refund/presentation/cubit/refund_cubit.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:svg_flutter/svg.dart';

import 'return_details_page.dart';

class ReturnHistoryPage extends StatefulWidget {
  const ReturnHistoryPage({super.key});

  @override
  State<ReturnHistoryPage> createState() => _ReturnHistoryPageState();
}

class _ReturnHistoryPageState extends State<ReturnHistoryPage> {
  var formattedDate = DateFormat('MMMM d, yyyy, hh:mm a');
  late final RefundCubit cubit;
  @override
  void initState() {
    cubit = RefundCubit.get(context);
    cubit.getRefunds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return ScaffoldImage(
      appBar: customAppBar(
        title: lang.returnedHistory,
        context: context,
        hasIcon: false,
        // hasLeading: false,
      ),
      body: Column(
        children: [
          const DefaultDivider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 16.sp),
            child: BlocBuilder<RefundCubit, RefundState>(
              builder: (context, state) {
                if (state is RefundLoading) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return buildShimmerIndicatorSmall();
                    },
                  );
                }
                if (state is RefundSuccess) {
                  if (cubit.refunds.isEmpty) {
                    return Text(S.of(context).noReturnItems);
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final refundItem = cubit.refunds[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ReturnedCustomerCard(
                          image: SvgPicture.asset(
                              'assets/images/repeat-circle.svg'),
                          title: refundItem.reason,
                          time: formattedDate
                              .format(DateTime.parse(refundItem.date)),
                          onTap: () {
                            navigateTo(
                              context: context,
                              screen: ReturnHistoryDetailsPage(
                                refundId: refundItem.id,
                                returnType: refundItem.reason,
                              ),
                            );
                          },
                        ),
                      );
                    },
                    itemCount: cubit.refunds.length,
                  );
                }
                return Text(S.of(context).noReturnItems);
              },
            ),
          )
        ],
      ),
    );
  }
}
