import 'package:flutter/material.dart';
import 'package:nilelon/core/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/features/store_flow/notification/widget/requests_view.dart';
import 'package:nilelon/features/store_flow/notification/widget/updates_view.dart';

import '../../../core/widgets/scaffold_image.dart';

class NotificationTabBar extends StatefulWidget {
  const NotificationTabBar({super.key});

  @override
  State<NotificationTabBar> createState() => _NotificationTabBarState();
}

class _NotificationTabBarState extends State<NotificationTabBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    return DefaultTabController(
      length: 2,
      child: ScaffoldImage(
          appBar: customAppBar(title: lang.notification, context: context),
          body: Padding(
            padding: const EdgeInsetsDirectional.symmetric(vertical: 12),
            child: Column(
              children: [
                TabBar(
                  onTap: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  dividerColor: Colors.transparent,
                  labelColor: ColorManager.primaryO,
                  unselectedLabelColor: ColorManager.primaryG,
                  indicatorColor: ColorManager.primaryO,
                  unselectedLabelStyle: AppStylesManager.customTextStyleG2,
                  labelStyle: AppStylesManager.customTextStyleO3,
                  tabs: [
                    Tab(
                      child: Text(
                        lang.requests,
                      ),
                    ),
                    Tab(
                      child: Text(
                        lang.updates,
                      ),
                    ),
                  ],
                ),
                const Expanded(
                  child: TabBarView(
                    children: [
                      RequestsView(),
                      UpdatesView(),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
