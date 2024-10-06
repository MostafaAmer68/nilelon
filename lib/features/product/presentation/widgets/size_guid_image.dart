// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/features/product/presentation/cubit/add_product/add_product_cubit.dart';

import '../../../../core/resources/appstyles_manager.dart';
import '../../../../core/resources/const_functions.dart';
import '../../../../core/widgets/pop_ups/camera_popup.dart';
import 'add_container.dart';
import 'image_container.dart';

class SizeGuidImage extends StatefulWidget {
  const SizeGuidImage({
    super.key,
    required this.lang,
  });
  final S lang;

  @override
  State<SizeGuidImage> createState() => _SizeGuidImageState();
}

class _SizeGuidImageState extends State<SizeGuidImage> {
  late final AddProductCubit cubit;
  @override
  void initState() {
    cubit = AddProductCubit.get(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.lang.sizeGuide, style: AppStylesManager.customTextStyleBl5),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            cubit.sizeGuideImage.path.isEmpty
                ? addContainer(
                    () async {
                      cubit.sizeGuideImage = await cameraDialog(context);
                      setState(() {});
                    },
                    context,
                    screenWidth(context, 0.3),
                    screenWidth(context, 0.3),
                  )
                : imageContainer(
                    () async {
                      cubit.sizeGuideImage = await cameraDialog(context);
                      setState(() {});
                    },
                    cubit.sizeGuideImage.path,
                    context,
                    screenWidth(context, 0.3),
                    screenWidth(context, 0.3),
                  ),
          ],
        ),
        Visibility(
          visible: cubit.sizeGuideImage.path.isEmpty,
          child: Text(
            S.of(context).youMustSelectGuidImage,
            style: AppStylesManager.customTextStyleR,
          ),
        ),
        SizedBox(height: 30.h),
      ],
    );
  }
}
