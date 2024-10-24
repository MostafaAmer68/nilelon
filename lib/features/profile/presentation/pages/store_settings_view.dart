import 'package:flutter/material.dart';
import 'package:nilelon/core/constants/assets.dart';
import 'package:nilelon/features/auth/presentation/view/login_page.dart';
import 'package:nilelon/features/store_flow/subscription/subscription_view.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/alert/delete_alert.dart';
import 'package:nilelon/core/widgets/alert/logout_alert.dart';
import 'package:nilelon/core/widgets/button/button_builder.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/features/shared/language/language_view.dart';
import 'package:nilelon/features/profile/presentation/widgets/profile_list_view.dart';
import 'package:nilelon/features/profile/presentation/pages/security_page.dart';
import 'package:nilelon/features/profile/presentation/pages/edit_store_info_view.dart';
import 'package:nilelon/features/profile/presentation/pages/edit_store_profile_view.dart';

import '../../../../core/widgets/scaffold_image.dart';

class StoreSettingsView extends StatelessWidget {
  const StoreSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    return ScaffoldImage(
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
                  name: lang.editProfileInfo,
                  image: Assets.assetsImagesEdit,
                  onTap: () {
                    navigateTo(
                        context: context, screen: const EditStoreProfileView());
                  },
                ),
                ProfileListTile(
                  name: lang.editStoreInfo,
                  image: Assets.assetsImagesEdit,
                  onTap: () {
                    navigateTo(
                        context: context, screen: const EditStoreInfoView());
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
                  name: lang.subscription,
                  image: Assets.assetsImagesCard2,
                  onTap: () {
                    navigateTo(
                        context: context, screen: const SubscriptionView());
                  },
                ),
                ProfileListTile(
                  name: lang.security,
                  image: Assets.assetsImagesLockB,
                  onTap: () {
                    navigateTo(context: context, screen: const SecurityView());
                  },
                ),
                ProfileListTile(
                  name: lang.logout,
                  image: Assets.assetsImagesLogout,
                  isRed: true,
                  onTap: () {
                    logoutAlert(context);
                  },
                ),
              ],
            ),
          ),
          const Spacer(),
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
          ),
          const Spacer()
        ],
      ),
    );
  }
}
