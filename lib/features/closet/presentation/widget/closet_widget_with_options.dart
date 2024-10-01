import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/features/closet/domain/model/closet_model.dart';
import 'package:nilelon/features/customer_flow/section_details/section_details_view.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/widgets/alert/show_delete_section_alert.dart';
import 'package:nilelon/core/widgets/pop_ups/rename_popup.dart';

import '../../../../core/utils/navigation.dart';
import '../../../../core/widgets/alert/empty_closets_alert.dart';

class ClosetsWidgetWithOptions extends StatelessWidget {
  const ClosetsWidgetWithOptions({
    super.key,
    required this.onTap,
    required this.closet,
  });
  final ClosetModel closet;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                      image: AssetImage('assets/images/saveToCloset.png'),
                      fit: BoxFit.fill)),
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              closet.name,
              style: AppStylesManager.customTextStyleBl6,
            ),
            const Spacer(),
            PopupMenuButton(
              onSelected: (String result) {
                if (result == 'Rename') {
                  renameSectionDialog(context);
                } else if (result == 'Delete') {
                  showDeleteSectionAlert(context, closet);
                } else if (result == 'Show Items') {
                  navigateTo(
                      context: context,
                      screen: SectionDetailsView(
                        closet: closet,
                      ));
                } else if (result == 'Empty closets') {
                  showEmptyClosetAlert(context, closet);
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'Show Items',
                  child: SizedBox(
                    width: 60.w,
                    height: 25.w,
                    child: Text(
                      lang.showAll,
                      style: AppStylesManager.customTextStyleBl3
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'Rename',
                  child: SizedBox(
                    width: 60.w,
                    height: 25.w,
                    child: Text(
                      lang.rename,
                      style: AppStylesManager.customTextStyleBl3
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'Empty closets',
                  child: SizedBox(
                    width: 60.w,
                    height: 25.w,
                    child: Text(
                      'Empty Closet',
                      style: AppStylesManager.customTextStyleBl3
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'Delete',
                  child: SizedBox(
                    width: 50.w,
                    height: 25.w,
                    child: Text(
                      lang.delete,
                      style: AppStylesManager.customTextStyleR,
                    ),
                  ),
                ),
              ],
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
