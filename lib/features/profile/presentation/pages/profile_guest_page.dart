import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nilelon/core/constants/assets.dart';
import 'package:nilelon/features/shared/welcomePage/welcome_page.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:svg_flutter/svg.dart';

import '../../../../core/resources/const_functions.dart';
import '../../../../core/widgets/button/gradient_button_builder.dart';
import '../../../../core/widgets/scaffold_image.dart';
import '../../../auth/presentation/view/customer_register_view.dart';

class ProfileGuestPage extends StatelessWidget {
  const ProfileGuestPage({super.key, this.hasLeading});
  final bool? hasLeading;
  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return ScaffoldImage(
      appBar: customAppBar(
          title: lang.profile,
          context: context,
          hasIcon: false,
          hasLeading: hasLeading ?? false),
      body: Column(
        children: [
          const DefaultDivider(),
          const Spacer(),
          SvgPicture.asset(Assets.assetsImagesAmico),
          const SizedBox(height: 30),
          Text(
            S.of(context).guestMsg,
            style: AppStylesManager.customTextStyleBl,
          ),
          const SizedBox(height: 30),
          const SizedBox(height: 30),
          GradientButtonBuilder(
            text: S.of(context).createAccount,
            width: screenWidth(context, 0.9),
            ontap: () {
              navigateTo(
                  context: context, screen: const CustomerRegisterView());
            },
          ),
          const SizedBox(height: 30),
          RichText(
            text: TextSpan(
              style: AppStylesManager.customTextStyleB5,
              children: [
                TextSpan(text: S.of(context).alreadyExits),
                TextSpan(
                  text: S.of(context).signIn,
                  style: AppStylesManager.customTextStyleL,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      navigateTo(
                          context: context, screen: const ShopOrSellView());
                    },
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
