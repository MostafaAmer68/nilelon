import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/resources/appstyles_manager.dart';
import 'package:nilelon/utils/navigation.dart';
import 'package:nilelon/widgets/button/button_builder.dart';

Future errorAlert(context, String message) => showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
          height: 90.h,
          child: Column(
            children: [
              SizedBox(
                height: 24.h,
              ),
              Text(
                message,
                style: AppStylesManager.customTextStyleBl8,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        actions: [
          ButtonBuilder(
              text: 'Ok',
              ontap: () {
                navigatePop(context: context);
              }),
        ],
      );
    });
