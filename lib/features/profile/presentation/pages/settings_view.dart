import 'package:flutter/material.dart';
import 'package:nilelon/core/constants/assets.dart';
import 'package:nilelon/core/widgets/button/outlined_button_builder.dart';
import 'package:nilelon/features/auth/presentation/view/login_page.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/alert/delete_alert.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/features/profile/presentation/pages/edit_profile_view.dart';
import 'package:nilelon/features/shared/language/language_view.dart';
import 'package:nilelon/features/profile/presentation/widgets/profile_list_view.dart';
import 'package:nilelon/features/profile/presentation/pages/security_page.dart';

import '../../../../core/data/hive_stroage.dart';
import '../../../../core/widgets/alert/logout_alert.dart';
import '../../../../core/widgets/scaffold_image.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return ScaffoldImage(
      appBar:
          customAppBar(title: lang.settings, context: context, hasIcon: false),
      body: Column(
        children: [
          const DefaultDivider(),
          Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: ColorManager.primaryW,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                ProfileListTile(
                  name: lang.editAccount,
                  image: Assets.assetsImagesEdit2,
                  onTap: () {
                    navigateTo(
                        context: context, screen: const EditProfileView());
                  },
                ),
                ProfileListTile(
                  name: lang.language,
                  image: Assets.assetsImagesLanguage,
                  onTap: () {
                    navigateTo(context: context, screen: const LanguageView());
                  },
                ),
                ProfileListTile(
                  name: lang.polices,
                  image: Assets.assetsImagesSecurity,
                  onTap: () {},
                ),
                ProfileListTile(
                  name: lang.security,
                  image: Assets.assetsImagesLockB,
                  onTap: () {
                    navigateTo(context: context, screen: const SecurityView());
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: ColorManager.primaryW,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Visibility(
              visible: HiveStorage.get(HiveKeys.userModel) == null,
              child: ProfileListTile(
                name: lang.logout,
                image: Assets.assetsImagesLogout,
                isRed: true,
                onTap: () {
                  logoutAlert(context);
                },
              ),
            ),
          ),
          OutlinedButtonBuilder(
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
            width: screenWidth(context, 0.8),
            height: screenHeight(context, 0.06),
            buttonColor: ColorManager.primaryW,
            frameColor: ColorManager.primaryR,
            style: AppStylesManager.customTextStyleB4
                .copyWith(color: ColorManager.primaryR, fontSize: 15),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
