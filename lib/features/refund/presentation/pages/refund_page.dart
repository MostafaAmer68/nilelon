import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/constants/assets.dart';
import 'package:nilelon/features/refund/presentation/cubit/refund_cubit.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/scaffold_image.dart';
import 'package:nilelon/features/profile/presentation/widgets/profile_list_view.dart';
import 'package:nilelon/features/refund/presentation/pages/return_item_page.dart';
// import 'package:nilelon/generated/l10n.dart';

class RefundPage extends StatefulWidget {
  const RefundPage({super.key, required this.orderId});
  final String orderId;

  @override
  State<RefundPage> createState() => _RefundPageState();
}

class _RefundPageState extends State<RefundPage> {
  @override
  void initState() {
    RefundCubit.get(context).orderId = widget.orderId;
    super.initState();
  }

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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 24.sp),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
                decoration: BoxDecoration(
                  color: ColorManager.primaryW,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    ProfileListTile(
                      name: lang.returnItem,
                      image: Assets.assetsImagesRepeatCircle,
                      onTap: () {
                        navigateTo(
                            context: context, screen: const ReturnItemPage());
                      },
                    ),
                    ProfileListTile(
                      name: lang.missingItem,
                      image: Assets.assetsImagesMissing,
                      onTap: () {
                        navigateTo(
                            context: context, screen: const ReturnItemPage());
                        // navigateTo(context: context, screen: const ClosetView());
                      },
                    ),
                    ProfileListTile(
                      name: lang.wrongItem,
                      image: Assets.assetsImagesWrong,
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
                      image: Assets.assetsImagesCall,
                      onTap: () {
                        // navigateTo(context: context, screen: const SettingsView());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
