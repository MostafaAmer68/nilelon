import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/donts_widget.dart';
import 'package:nilelon/features/closet/domain/model/closet_model.dart';
import 'package:nilelon/features/closet/presentation/cubit/closet_cubit.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/button/button_builder.dart';
import 'package:nilelon/core/widgets/button/outlined_button_builder.dart';

Future showDeleteSectionAlert(context, ClosetModel closetId) => showDialog(
    context: context,
    builder: (BuildContext context) {
      final lang = S.of(context);

      return AlertDialog(
        shadowColor: ColorManager.primaryO,
        elevation: 5,
        backgroundColor: ColorManager.primaryW,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: SizedBox(
          height: 75.h,
          child: Column(
            children: [
              const DontsWidget(),
              const SizedBox(
                height: 10,
              ),
              const DefaultDivider(),
              SizedBox(
                height: 16.h,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Are you sure you want to remove\n',
                      style: AppStylesManager.customTextStyleBl8,
                    ),
                    TextSpan(
                      text: closetId.name,
                      style: AppStylesManager.customTextStyleO3,
                    ),
                    TextSpan(
                      text: ' Section ?',
                      style: AppStylesManager.customTextStyleBl8,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButtonBuilder(
                  text: lang.no,
                  width: screenWidth(context, 0.32),
                  height: screenHeight(context, 0.06),
                  ontap: () {
                    navigatePop(context: context);
                  }),
              SizedBox(
                width: 12.w,
              ),
              ButtonBuilder(
                  buttonColor: ColorManager.primaryR,
                  text: lang.yes,
                  width: screenWidth(context, 0.32),
                  height: screenHeight(context, 0.06),
                  ontap: () {
                    navigatePop(context: context);
                    ClosetCubit.get(context).deletCloset(closetId.id);
                  }),
            ],
          ),
        ],
      );
    });
