import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/core/constants/assets.dart';
import 'package:nilelon/core/widgets/shimmer_indicator/build_shimmer.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/features/notification/presentation/widgets/requests_view.dart';
import 'package:nilelon/features/notification/presentation/widgets/updates_view.dart';
import 'package:svg_flutter/svg.dart';

import '../../../../core/widgets/scaffold_image.dart';
import '../cubit/notification_cubit.dart';

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
                Expanded(
                  child: BlocBuilder<NotificationCubit, NotificationState>(
                    builder: (context, state) {
                      if (state is NotificationLoading) {
                        return buildShimmerIndicator();
                      } else if (state is NotificationSuccess) {
                        if (NotificationCubit.get(context)
                            .notificatios
                            .isEmpty) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                Assets.assetsImagesNoNotification,
                                width: 300,
                              ),
                              const SizedBox(height: 200),
                            ],
                          );
                        }
                        return const TabBarView(
                          children: [
                            RequestsView(),
                            UpdatesView(),
                          ],
                        );
                      } else {
                        return const Icon(Icons.error);
                      }
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
