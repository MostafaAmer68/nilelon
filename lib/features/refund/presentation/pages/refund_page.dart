import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/scaffold_image.dart';
import 'package:nilelon/features/profile/presentation/widgets/profile_list_view.dart';
import 'package:nilelon/features/refund/presentation/pages/return_item_page.dart';
import 'package:nilelon/generated/l10n.dart';

class RefundPage extends StatelessWidget {
  const RefundPage({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return ScaffoldImage(
        appBar: customAppBar(
          title: lang.reportOrder,
          context: context,
          hasIcon: false,
          hasLeading: true,
        ),
        body: Column(
          children: [
            const DefaultDivider(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
              decoration: BoxDecoration(
                color: ColorManager.primaryW,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  ProfileListTile(
                    name: lang.returnItem,
                    image: 'assets/images/repeat-circle.svg',
                    onTap: () {
                      navigateTo(
                          context: context, screen: const ReturnItemPage());
                    },
                  ),
                  ProfileListTile(
                    name: lang.missingItem,
                    image: 'assets/images/missing.svg',
                    onTap: () {
                      navigateTo(
                          context: context, screen: const ReturnItemPage());
                      // navigateTo(context: context, screen: const ClosetView());
                    },
                  ),
                  ProfileListTile(
                    name: lang.wrongItem,
                    image: 'assets/images/wrong.svg',
                    onTap: () {
                      navigateTo(
                          context: context, screen: const ReturnItemPage());
                      // navigateTo(
                      //     context: context,
                      //     screen: const RecommendationProfileView());
                    },
                  ),
                  ProfileListTile(
                    name: lang.contactUs,
                    image: 'assets/images/call.svg',
                    onTap: () {
                      // navigateTo(context: context, screen: const SettingsView());
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
