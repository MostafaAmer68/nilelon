import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/features/profile/presentation/pages/edit_email_page.dart';
import 'package:nilelon/features/profile/presentation/pages/edit_password_page.dart';
import 'package:nilelon/features/profile/presentation/pages/edit_phone_page.dart';
import 'package:nilelon/features/profile/presentation/widgets/profile_list_view.dart';

import '../../../../core/widgets/scaffold_image.dart';

class SecurityView extends StatelessWidget {
  const SecurityView({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    return ScaffoldImage(
      appBar:
          customAppBar(title: lang.security, context: context, hasIcon: false),
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
                  name: lang.phoneNumber,
                  image: 'assets/images/phone.svg',
                  onTap: () {
                    navigateTo(
                        context: context, screen: const EditPhoneNumPage());
                  },
                  trailingWidget: trailingWidget(lang.change),
                ),
                ProfileListTile(
                  name: lang.email,
                  image: 'assets/images/email.svg',
                  onTap: () {
                    navigateTo(
                        context: context, screen: const ChangeEmailPage());
                  },
                  trailingWidget: trailingWidget(lang.change),
                ),
                ProfileListTile(
                  name: lang.password,
                  image: 'assets/images/lock_b.svg',
                  onTap: () {
                    navigateTo(
                        context: context, screen: const ChangePasswordPage());
                  },
                  trailingWidget: trailingWidget(lang.change),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SizedBox trailingWidget(String change) {
    return SizedBox(
      width: 50.w,
      child: Row(
        children: [
          Text(
            change,
            style: AppStylesManager.customTextStyleG14,
          ),
          const SizedBox(
            width: 2,
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 10,
            color: ColorManager.primaryG2,
          )
        ],
      ),
    );
  }
}
