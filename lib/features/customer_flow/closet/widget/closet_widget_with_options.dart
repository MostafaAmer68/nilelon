import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/resources/appstyles_manager.dart';
import 'package:nilelon/widgets/alert/show_delete_section_alert.dart';
import 'package:nilelon/widgets/pop_ups/rename_popup.dart';

class ClosetsWidgetWithOptions extends StatelessWidget {
  const ClosetsWidgetWithOptions({
    super.key,
    required this.onTap,
  });
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
              'T-Shirt',
              style: AppStylesManager.customTextStyleBl6,
            ),
            const Spacer(),
            PopupMenuButton(
              onSelected: (String result) {
                if (result == 'Rename') {
                  renameSectionDialog(context);
                } else if (result == 'Delete') {
                  showDeleteSectionAlert(context);
                }
                log(result);
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
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
