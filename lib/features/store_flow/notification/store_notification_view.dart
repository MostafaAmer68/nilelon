// import 'package:flutter/material.dart';
// import 'package:nilelon/core/constants/const_functions.dart';
// import 'package:nilelon/core/constants/statics.dart';
// import 'package:nilelon/core/shared_widgets/custom_app_bar/custom_app_bar.dart';
// import 'package:nilelon/core/shared_widgets/different_cards/notify_gradient_card.dart';
// import 'package:nilelon/core/shared_widgets/different_cards/notify_viewed_card.dart';
// import 'package:nilelon/core/shared_widgets/different_cards/notify_card.dart';

// class StoreNotificationView extends StatelessWidget {
//   const StoreNotificationView({super.key, required this.noNotification});
//   final bool noNotification;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppStyles.primaryW,
//       appBar: customAppBar(title: 'Notification', context: context),
//       body: Column(
//         children: [
//           const SizedBox(
//             height: 4,
//             child: Divider(
//               color: AppStyles.primaryG8,
//             ),
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: noNotification
//                   ? Container(
//                       width: screenWidth(context, 0.5),
//                       decoration: const BoxDecoration(
//                           image: DecorationImage(
//                               image: AssetImage(
//                                   'assets/images/noNotification.png'))),
//                     )
//                   : const Column(
//                       children: [
//                         NotifyGradientCard(),
//                         SizedBox(
//                           height: 16,
//                         ),
//                         NotifyCard(),
//                         SizedBox(
//                           height: 16,
//                         ),
//                         NotifyViewedCard()
//                       ],
//                     ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
