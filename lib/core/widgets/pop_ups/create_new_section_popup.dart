import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/features/closet/presentation/cubit/closet_cubit.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/widgets/button/button_builder.dart';

Future createNewSectionDialog(
  BuildContext context,
) {
  return showModalBottomSheet(
    isScrollControlled: true,
    useSafeArea: true,
    context: context,
    builder: (BuildContext context) {
      return SingleChildScrollView(
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
                  'Add New Section',
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
                    hintText: 'Section Name',
                    hintStyle: AppStylesManager.customTextStyleG2,
                  ),
                ),
                SizedBox(
                  height: 16.h,
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ButtonBuilder(
                        text: 'Save',
                        ontap: () {
                          ClosetCubit.get(context).createCloset();
                        },
                        width: screenWidth(context, 0.28),
                        height: 45.h,
                      ),
                      ButtonBuilder(
                        text: 'Close',
                        ontap: () {
                          Navigator.pop(context);
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
      );
    },
  );
}
