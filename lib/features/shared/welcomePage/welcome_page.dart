import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/features/shared/recommendation/presentation/view/recommendation_view.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/button/button_builder.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/features/auth/presentation/view/login_page.dart';
import 'package:svg_flutter/svg.dart';

import '../../../core/constants/assets.dart';
import '../../../core/widgets/scaffold_image.dart';

class ShopOrSellView extends StatelessWidget {
  const ShopOrSellView({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    return ScaffoldImage(
      body: Padding(
        padding: EdgeInsets.all(16.0.sp),
        child: Column(
          children: [
            const Spacer(
              flex: 12,
            ),
            SvgPicture.asset(
              Assets.assetsImagesLogo,
              width: 60.w,
              height: 60.h,
            ),
            SizedBox(
              height: 22.h,
            ),
            Image.asset(
              Assets.assetsImagesNilelonEcommerce,
              width: 184.w,
              height: 68.w,
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
