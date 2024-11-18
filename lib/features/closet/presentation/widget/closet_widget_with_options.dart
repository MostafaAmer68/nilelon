import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/constants/assets.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/features/closet/domain/model/closet_model.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';

import '../../../../core/resources/const_functions.dart';
import '../../../../core/utils/navigation.dart';
import '../../../../core/widgets/alert/empty_closets_alert.dart';
import '../../../../core/widgets/alert/show_delete_section_alert.dart';
import '../../../../core/widgets/pop_ups/rename_popup.dart';

class ClosetsWidgetWithOptions extends StatelessWidget {
  const ClosetsWidgetWithOptions({
    super.key,
    required this.onTap,
    // required this.onActionTap,
    required this.closet,
    this.isPage = false,
  });
  final ClosetModel closet;
  final bool isPage;
  final void Function() onTap;
  // final void Function() onActionTap;
  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    return InkWell(
      child: Container(
        // margin: const EdgeInsets.only(top: 16, bottom: 16, left: 24, right: 36),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: isPage
            ? BoxDecoration(
                color: ColorManager.primaryW,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(2, 8),
                    color: ColorManager.primaryO3,
                  ),
                ],
              )
            : null,
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: onTap,
                child: Row(
                  children: [
                    SizedBox(
                      width: 50.w,
                      height: 50.w,
                      child: Image.asset(Assets.assetsImagesClosetFollowing),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 170,
                      child: Text(
                        closet.name,
                        overflow: TextOverflow.ellipsis,
                        style: AppStylesManager.customTextStyleBl6,
                      ),
                    ),
                    // const Spacer(),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor:
                      Colors.transparent, // Background color of the modal
                  builder: (context) {
                    return Container(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: ColorManager.primaryW,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                TextButton(
                                  child: Text(
                                    lang.rename,
                                    style: AppStylesManager.customTextStyleBl6,
                                  ),
                                  onPressed: () {
                                    if (closet.name == 'Default') {
                                      BotToast.showText(
                                          text: lang.renameDefault);
                                      return;
                                    }
                                    renameSectionDialog(context, closet.id);
                                  },
                                ),
                                const Divider(),
                                TextButton(
                                  child: Text(
                                    lang.emptyCloset,
                                    style: AppStylesManager.customTextStyleR,
                                  ),
                                  onPressed: () {
                                    navigatePop(context: context);
                                    showEmptyClosetAlert(context, closet);
                                    // ClosetCubit.get(context).getclosets();
                                  },
                                ),
                                const Divider(),
                                TextButton(
                                  child: Text(
                                    lang.delete,
                                    style: AppStylesManager.customTextStyleR,
                                  ),
                                  onPressed: () {
                                    if (closet.name == 'Default') {
                                      BotToast.showText(
                                          text: lang.deleteDefault);
                                      return;
                                    }
                                    navigatePop(context: context);
                                    showDeleteSectionAlert(context, closet);
                                    // ClosetCubit.get(context).getclosets();
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                              color: ColorManager.primaryW,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            width: double.infinity,
                            height: 60,
                            child: TextButton(
                              child: Text(
                                lang.cancel,
                                style: AppStylesManager.customTextStyleBl10,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              icon: Icon(
                Icons.more_vert_rounded,
                size: 20.r,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
