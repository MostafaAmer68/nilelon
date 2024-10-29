import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/widgets/button/button_builder.dart';
import 'package:nilelon/generated/l10n.dart';

import '../../../../core/color_const.dart';
import '../../../../core/resources/appstyles_manager.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/utils/navigation.dart';
import '../cubit/closet_cubit.dart';

class CreateNewSection extends StatelessWidget {
  const CreateNewSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 700,
      child: Scaffold(
        backgroundColor: ColorManager.primaryGB3,
        appBar: AppBar(
          backgroundColor: ColorManager.primaryW,
          automaticallyImplyLeading: false,
          actions: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: colorConst
                    .map(
                      (e) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        width: 10.w,
                        height: 10.w,
                        decoration: BoxDecoration(
                          color: e,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  S.of(context).createNewSection,
                  style: AppStylesManager.customTextStyleBl6
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: ClosetCubit.get(context).closetName,
                  decoration: InputDecoration(
                    focusColor: ColorManager.primaryG,
                    hintText: S.of(context).sectionName,
                    hintStyle: AppStylesManager.customTextStyleG2,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                BlocListener<ClosetCubit, ClosetState>(
                  listener: (context, state) {
                    state.mapOrNull(
                      loading: (_) {
                        BotToast.showLoading();
                      },
                      success: (_) {
                        BotToast.closeAllLoading();
                        navigatePop(context: context);
                        ClosetCubit.get(context).getclosets();
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ButtonBuilder(
                        text: S.of(context).save,
                        frameColor: ColorManager.primaryO3,
                        ontap: () {
                          ClosetCubit.get(context).createCloset();
                        },
                        width: screenWidth(context, 0.28),
                        height: 45.h,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
