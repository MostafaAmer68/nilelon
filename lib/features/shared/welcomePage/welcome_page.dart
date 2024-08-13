import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/data/hive_stroage.dart';
import 'package:nilelon/features/shared/recommendation/recommendation_view.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/resources/const_functions.dart';
import 'package:nilelon/resources/appstyles_manager.dart';
import 'package:nilelon/utils/navigation.dart';
import 'package:nilelon/widgets/button/button_builder.dart';
import 'package:nilelon/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/features/auth/presentation/view/login/login_view.dart';

class ShopOrSellView extends StatelessWidget {
  const ShopOrSellView({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    return Scaffold(
      backgroundColor: ColorManager.primaryW,
      body: Padding(
        padding: EdgeInsets.all(16.0.sp),
        child: Column(
          children: [
            const Spacer(
              flex: 12,
            ),
            Container(
              width: 60.w,
              height: 60.w,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/1-Nilelon f logo d.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              height: 22.h,
            ),
            Container(
              width: 184.w,
              height: 68.w,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/nilelonEcommerce.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            GradientButtonBuilder(
              text: lang.shopOnApp,
              ontap: () {
                HiveStorage.set(HiveKeys.isStore, false);

                navigateTo(context: context, screen: const LoginView());
              },
              width: screenWidth(context, 1),
            ),
            const Spacer(),
            ButtonBuilder(
              text: lang.sellOnApp,
              ontap: () {
                HiveStorage.set(HiveKeys.isStore, true);

                navigateTo(context: context, screen: const LoginView());
              },
              width: screenWidth(context, 1),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                HiveStorage.set(HiveKeys.isStore, false);

                navigateTo(
                    context: context, screen: const RecommendationView());
              },
              child: Text(
                lang.shopAsAGuest,
                style: AppStylesManager.customTextStyleL,
              ),
            ),
            const Spacer(
              flex: 10,
            ),
          ],
        ),
      ),
    );
  }
}
