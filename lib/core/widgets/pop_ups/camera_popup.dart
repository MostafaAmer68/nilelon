import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nilelon/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';

Future<File?> pickImage(ImageSource source) async {
  var pickedImage = await ImagePicker().pickImage(source: source);
  if (pickedImage != null) {
    return File(pickedImage.path);
  } else {
    return null;
  }
}

Future<File> cameraDialog(BuildContext context) async {
  Completer<File> completer = Completer<File>();

  await showCupertinoModalPopup<void>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is PickImageSuccess) {
            navigatePop(context: context);
          }
        },
        child: SizedBox(
          width: screenWidth(context, 0.95),
          child: CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                onPressed: () async {
                  // AuthCubit.get(context).pickImage(ImageSource.camera);
                  File? image = await pickImage(ImageSource.camera);
                  if (image != null) {
                    completer.complete(image);
                  }
                  navigatePop(context: context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.camera_alt_outlined,
                      color: ColorManager.primaryB2,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text(
                      'Camera',
                      style: AppStylesManager.customTextStyleB4,
                    ),
                  ],
                ),
              ),
              CupertinoActionSheetAction(
                onPressed: () async {
                  // AuthCubit.get(context).pickImage(ImageSource.gallery);
                  File? image = await pickImage(ImageSource.gallery);
                  if (image != null) {
                    completer.complete(image);
                  }
                  navigatePop(context: context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.file_upload_outlined,
                      color: ColorManager.primaryB2,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text(
                      'Upload From Gallery',
                      style: AppStylesManager.customTextStyleB4,
                    ),
                  ],
                ),
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                // completer.complete(File(''));
                navigatePop(context: context);
              },
              child: Text(
                'Cancel',
                style: AppStylesManager.customTextStyleB4,
              ),
            ),
          ),
        ),
      );
    },
  );

  return completer.future;
}

// Future<File?> pickImage(ImageSource source) async {
//   var pickedImage = await ImagePicker().pickImage(source: source);
//   if (pickedImage != null) {
//     return File(pickedImage.path);
//   } else {
//     return null;
//   }
// }
// // Future<File?> cameraDialog(
// //   BuildContext context,
// // ) {
// //   return showCupertinoModalPopup<File?>(
// //     barrierDismissible: false,
// //     context: context,
// //     builder: (BuildContext context) {
// //       // File? image;

// //       return SizedBox(
// //         width: screenWidth(context, 0.95),
// //         child: CupertinoActionSheet(
// //           actions: [
// //             CupertinoActionSheetAction(
// //               onPressed: () async {
// //                 //image =
// //                 // File? image =
// //                 await pickImage(ImageSource.camera);
// //                 navigatePop(context: context);
// //               },
// //               child: const Row(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   Icon(
// //                     Icons.camera_alt_outlined,
// //                     color: AppStyles.primaryB2,
// //                   ),
// //                   SizedBox(
// //                     width: 4,
// //                   ),
// //                   Text(
// //                     'Camera',
// //                     style: AppStyles.customTextStyleB4,
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             CupertinoActionSheetAction(
// //               onPressed: () async {
// //                 // image =
// //                 // File? image =
// //                 await pickImage(ImageSource.gallery);
// //                 navigatePop(context: context);
// //               },
// //               child: const Row(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   Icon(
// //                     Icons.file_upload_outlined,
// //                     color: AppStyles.primaryB2,
// //                   ),
// //                   SizedBox(
// //                     width: 4,
// //                   ),
// //                   Text(
// //                     'Upload From Gallery',
// //                     style: AppStyles.customTextStyleB4,
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //           cancelButton: CupertinoActionSheetAction(
// //             onPressed: () {
// //               navigatePop(context: context);
// //             },
// //             child: const Text(
// //               'Cancel',
// //               style: AppStyles.customTextStyleB4,
// //             ),
// //           ),
// //         ),
// //       );
// //     },
// //   );
// // }

// // Future<File?> pickImage(ImageSource source) async {
// //   var pickedimage = await ImagePicker().pickImage(source: source);
// //   if (pickedimage != null) {
// //     return File(pickedimage.path);
// //   } else {
// //     return null;
// //   }
// // }
