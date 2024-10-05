import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/features/auth/presentation/view/customer_register/customer_register_view.dart';
import 'package:nilelon/features/auth/presentation/view/login/login_view.dart';
import 'package:nilelon/features/profile/presentation/pages/store_settings_view.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/alert/logout_alert.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/replacer/image_replacer.dart';
import 'package:nilelon/features/closet/presentation/view/closet_view.dart';
import 'package:nilelon/features/order/presentation/pages/order_customer_tab_bar.dart';
import 'package:nilelon/features/profile/presentation/widgets/profile_list_view.dart';
import 'package:nilelon/features/customer_flow/recommendation_profile/recommendation_profile_view.dart';
import 'package:nilelon/features/customer_flow/settings/settings_view.dart';
import 'package:svg_flutter/svg.dart';

import '../../../../core/resources/const_functions.dart';
import '../../../../core/widgets/button/gradient_button_builder.dart';
import '../../../../core/widgets/scaffold_image.dart';
import '../../../auth/domain/model/user_model.dart';

class ProfileGuestPage extends StatelessWidget {
  const ProfileGuestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return ScaffoldImage(
      appBar: customAppBar(
          title: lang.profile,
          context: context,
          hasIcon: false,
          hasLeading: false),
      body: Column(
        children: [
          const DefaultDivider(),
          SvgPicture.asset('assets/images/amico.svg'),
          const SizedBox(height: 30),
          Text(
            'You dont`t Have Account sign up\nto enjoy out features.',
            style: AppStylesManager.customTextStyleBl,
          ),
          const SizedBox(height: 30),
          TextButton.icon(
              iconAlignment: IconAlignment.end,
              onPressed: () {
                navigateTo(context: context, screen: const SettingsView());
              },
              label:
                  Text('Settings', style: AppStylesManager.customTextStyleG2),
              icon: const Icon(
                Icons.arrow_forward_ios,
                color: ColorManager.primaryG,
                size: 15,
              )),
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
                const TextSpan(text: 'Already have an account? '),
                TextSpan(
                    text: 'Sign in',
                    style: AppStylesManager.customTextStyleL,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        navigateTo(context: context, screen: const LoginView());
                      }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
