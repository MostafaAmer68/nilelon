import 'package:flutter/material.dart';
import 'package:nilelon/features/auth/presentation/view/login/login_view.dart';
import 'package:nilelon/core/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/alert/delete_alert.dart';
import 'package:nilelon/core/widgets/button/button_builder.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/features/auth/presentation/view/edit_account/edit_account_view.dart';
import 'package:nilelon/features/shared/language/language_view.dart';
import 'package:nilelon/features/profile/presentation/widgets/profile_list_view.dart';
import 'package:nilelon/features/auth/presentation/view/security_view.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Scaffold(
      backgroundColor: ColorManager.primaryW,
      appBar:
          customAppBar(title: lang.settings, context: context, hasIcon: false),
      body: Column(
        children: [
          const DefaultDivider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ProfileListTile(
                  name: lang.editAccount,
                  image: 'assets/images/edit-2.svg',
                  onTap: () {
                    navigateTo(
                        context: context, screen: const EditAccountView());
                  },
                ),
                ProfileListTile(
                  name: lang.language,
                  image: 'assets/images/Language.svg',
                  onTap: () {
                    navigateTo(context: context, screen: const LanguageView());
                  },
                ),
                ProfileListTile(
                  name: lang.polices,
                  image: 'assets/images/Security.svg',
                  onTap: () {},
                ),
                ProfileListTile(
                  name: lang.security,
                  image: 'assets/images/lock_b.svg',
                  onTap: () {
                    navigateTo(context: context, screen: const SecurityView());
                  },
                ),
              ],
            ),
          ),
          const Spacer(
            flex: 4,
          ),
          ButtonBuilder(
            text: lang.deleteAccount,
            ontap: () {
              deleteAlert(
                context,
                lang.areYouSureYouWntToDeleteYourAccount,
                () {
                  navigateTo(context: context, screen: const LoginView());
                },
              );
            },
            width: screenWidth(context, 0.42),
            height: screenHeight(context, 0.06),
            buttonColor: Colors.transparent,
            frameColor: ColorManager.primaryR,
            style: AppStylesManager.customTextStyleB4
                .copyWith(color: ColorManager.primaryR, fontSize: 16),
          ),
          const Spacer(
              // flex: 2,
              )
        ],
      ),
    );
  }
}
