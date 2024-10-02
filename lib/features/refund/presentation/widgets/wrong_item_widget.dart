import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/features/refund/presentation/cubit/refund_cubit.dart';
import 'package:nilelon/generated/l10n.dart';

import '../../../../core/color_const.dart';
import '../../../../core/resources/appstyles_manager.dart';
import '../../../../core/sizes_consts.dart';
import '../../../../core/widgets/drop_down_menu/drop_down_menu.dart';
import '../../../../core/widgets/pop_ups/camera_popup.dart';
import '../../../product/presentation/widgets/add_container.dart';
import '../../../product/presentation/widgets/color_selector.dart';
import '../../../product/presentation/widgets/custom_toggle_button.dart';
import '../../../product/presentation/widgets/image_container.dart';

class WrongItemWidget extends StatefulWidget {
  const WrongItemWidget({super.key});

  @override
  State<WrongItemWidget> createState() => _WrongItemWidgetState();
}

class _WrongItemWidgetState extends State<WrongItemWidget> {
  late final RefundCubit cubit;
  @override
  void initState() {
    cubit = RefundCubit.get(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var lang = S.of(context);
    List<String> wrongItems = [
      lang.size,
      lang.color,
      lang.damagedItem,
    ];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 16.sp,
        ),
        Text(
          lang.Whatiswrongonthisitem,
          style: AppStylesManager.customTextStyleBl12,
        ),
        SizedBox(
          height: 16.sp,
        ),
        dropDownMenu(
            hint: lang.chooseAnswer,
            selectedValue: cubit.wrongSelectedValue,
            items: wrongItems,
            context: context,
            onChanged: (item) {
              cubit.wrongSelectedValue = item!;
              setState(() {});
            }),
        SizedBox(
          height: 16.sp,
        ),
        if (cubit.wrongSelectedValue == lang.size ||
            cubit.wrongSelectedValue == lang.color)
          _buildVariantWrogngWidget(lang),
        if (cubit.wrongSelectedValue == lang.damagedItem)
          _buildDamageWidget(lang),
      ],
    );
  }

  Widget _buildColorSelector(RefundCubit cubit, S lang) {
    return Row(
      children: [
        Text(
          lang.receivedColor,
          style: AppStylesManager.customTextStyleBl12,
        ),
        SizedBox(
          height: 16.sp,
        ),
        ColorSelector(
          colors: colorProducts.map((e) => e.replaceRange(0, 3, '')).toList(),
          selectedColor: cubit.selectedColor,
          onColorSelected: (color) {
            cubit.selectedColor = color;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildSizeSelector(RefundCubit cubit, S lang) {
    return Row(
      children: [
        Text(
          lang.receivedSize,
          style: AppStylesManager.customTextStyleBl12,
        ),
        SizedBox(
          height: 16.sp,
        ),
        SizeToggleButtons(
          sizes: SizeTypes.values.map((e) => e.name).toList(),
          selectedSize: cubit.selectedSize,
          onSizeSelected: (size) {
            cubit.selectedSize = size;
            setState(() {});
          },
        ),
      ],
    );
  }

  _buildDamageWidget(lang) {
    return Column(
      children: [
        Text(
          lang.PleaseUpload3ClearPhotos,
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
            Column(
              children: [
                cubit.damageImage == null
                    ? addContainer(
                        () async {
                          cubit.damageImage = await cameraDialog(context);
                          setState(() {});
                        },
                        context,
                        null,
                        null,
                      )
                    : imageContainer(
                        () {},
                        cubit.damageImage!.path,
                        context,
                        null,
                        null,
                      ),
                SizedBox(
                  height: 8.sp,
                ),
                Text(
                  lang.damagedPart,
                  style: AppStylesManager.customTextStyleBl12,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  _buildVariantWrogngWidget(lang) {
    return Column(children: [
      cubit.wrongSelectedValue == lang.size
          ? _buildSizeSelector(cubit, lang)
          : _buildColorSelector(cubit, lang),
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
    ]);
  }
}
