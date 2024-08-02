import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/resources/const_functions.dart';
import 'package:nilelon/resources/appstyles_manager.dart';
import 'package:nilelon/widgets/button/button_builder.dart';

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
                  decoration: InputDecoration(
                    // fillColor: AppStyles.primaryW,
                    focusColor: ColorManager.primaryG,
                    // border: OutlineInputBorder(borderSide: BorderSide.none,
                    //   borderRadius: BorderRadius.circular(12),
                    // ),

                    hintText: 'Section Name',
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
                      text: 'Save',
                      ontap: () {
                        print(MediaQuery.of(context).viewInsets.bottom);
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
      );
    },
  );
}
