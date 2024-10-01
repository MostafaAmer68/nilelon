import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/cards/customer_order_management/returned_customer_card.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/scaffold_image.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:svg_flutter/svg.dart';

class ReturnHistoryPage extends StatefulWidget {
  const ReturnHistoryPage({super.key});

  @override
  State<ReturnHistoryPage> createState() => _ReturnHistoryPageState();
}

class _ReturnHistoryPageState extends State<ReturnHistoryPage> {
  var formattedDate = DateFormat('MMMM d, yyyy, hh:mm a');
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
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ReturnedCustomerCard(
                    image: SvgPicture.asset('assets/images/repeat-circle.svg'),
                    title: 'You Returned 1 Item from Order 4098301',
                    time: formattedDate.format(DateTime.now()),
                    onTap: () {
                      // navigateTo(
                      //     context: context,
                      //     screen: OrderStoreDetailsView(
                      //       id: order.id,
                      //       index: 0,
                      //     ));
                    },
                  ),
                );
              },
              itemCount: 5,
            ),
          )
        ],
      ),
    );
  }
}
