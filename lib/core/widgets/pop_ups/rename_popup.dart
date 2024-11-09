import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/tools.dart';
import 'package:nilelon/core/widgets/button/button_builder.dart';

import '../../../features/closet/presentation/cubit/closet_cubit.dart';
import '../../utils/navigation.dart';

Future renameSectionDialog(
  BuildContext context,
  String closetId,
) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (BuildContext context) {
      return BlocListener<ClosetCubit, ClosetState>(
        listener: (context, state) {
          state.mapOrNull(
            loading: (_) {
              BotToast.showLoading();
            },
            success: (_) {
              BotToast.closeAllLoading();
              navigatePop(context: context);
            },
          );
        },
        child: SingleChildScrollView(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: 500.h,
            width: screenWidth(context, 1),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    lang(context).renameSection,
                    style: AppStylesManager.customTextStyleBl6
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: ClosetCubit.get(context).closetName,
                    decoration: InputDecoration(
                      focusColor: ColorManager.primaryG,
                      hintText: lang(context).sectionName,
                      hintStyle: AppStylesManager.customTextStyleG2,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ButtonBuilder(
                        text: lang(context).save,
                        ontap: () {
                          ClosetCubit.get(context).updateCloset(closetId);
                        },
                        width: screenWidth(context, 0.28),
                        height: 45.h,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
