import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/features/product/presentation/widgets/image_container.dart';
import 'package:nilelon/features/refund/presentation/cubit/refund_cubit.dart';
import 'package:nilelon/generated/l10n.dart';

import '../../../../core/resources/appstyles_manager.dart';
import '../../../../core/widgets/pop_ups/camera_popup.dart';
import '../../../product/presentation/widgets/add_container.dart';

class ChangeMindWidget extends StatefulWidget {
  const ChangeMindWidget({super.key});

  @override
  State<ChangeMindWidget> createState() => _ChangeMindWidgetState();
}

class _ChangeMindWidgetState extends State<ChangeMindWidget> {
  @override
  Widget build(BuildContext context) {
    final cubit = RefundCubit.get(context);
    var lang = S.of(context);
    return Column(
      children: [
        SizedBox(
          height: 16.sp,
        ),
        Text(
          lang.PleaseUpload2ClearPhotos,
          style: AppStylesManager.customTextStyleBl12,
        ),
        SizedBox(
          height: 16.sp,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                cubit.fronImage == null
                    ? addContainer(
                        () async {
                          cubit.fronImage = await cameraDialog(context);
                          setState(() {});
                        },
                        context,
                        null,
                        null,
                      )
                    : imageContainer(
                        () {},
                        cubit.fronImage!.path,
                        context,
                        null,
                        null,
                      ),
                SizedBox(
                  height: 8.sp,
                ),
                Text(
                  lang.front,
                  style: AppStylesManager.customTextStyleBl12,
                ),
              ],
            ),
            Column(
              children: [
                cubit.backImage == null
                    ? addContainer(
                        () async {
                          cubit.backImage = await cameraDialog(context);
                          setState(() {});
                        },
                        context,
                        null,
                        null,
                      )
                    : imageContainer(
                        () {},
                        cubit.backImage!.path,
                        context,
                        null,
                        null,
                      ),
                SizedBox(
                  height: 8.sp,
                ),
                Text(
                  lang.back,
                  style: AppStylesManager.customTextStyleBl12,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
