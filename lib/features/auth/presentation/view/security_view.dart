import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/features/auth/presentation/view/change_email_number/change_email_number.dart';
import 'package:nilelon/features/auth/presentation/view/change_password/change_password.dart';
import 'package:nilelon/features/auth/presentation/view/change_phone_number/change_phone_number.dart';
import 'package:nilelon/features/profile/presentation/widgets/profile_list_view.dart';

class SecurityView extends StatelessWidget {
  const SecurityView({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    return Scaffold(
      appBar:
          customAppBar(title: lang.security, context: context, hasIcon: false),
      backgroundColor: ColorManager.primaryW,
      body: Column(
        children: [
          const DefaultDivider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ProfileListTile(
                  name: lang.phoneNumber,
                  image: 'assets/images/phone.svg',
                  onTap: () {
                    navigateTo(
                        context: context, screen: const ChangePhoneNumber());
                  },
                  trailingWidget: trailingWidget(lang.change),
                ),
                ProfileListTile(
                  name: lang.email,
                  image: 'assets/images/email.svg',
                  onTap: () {
                    navigateTo(context: context, screen: const ChangeEmail());
                  },
                  trailingWidget: trailingWidget(lang.change),
                ),
                ProfileListTile(
                  name: lang.password,
                  image: 'assets/images/lock_b.svg',
                  onTap: () {
                    navigateTo(
                        context: context, screen: const ChangePassword());
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
