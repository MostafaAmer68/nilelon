import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/features/refund/data/models/refund_details_model.dart';
import 'package:nilelon/features/refund/presentation/cubit/refund_cubit.dart';
import 'package:nilelon/generated/l10n.dart';

import '../../../../core/color_const.dart';
import '../../../../core/resources/appstyles_manager.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/const_functions.dart';
import '../../../../core/sizes_consts.dart';
import '../../../../core/utils/navigation.dart';
import '../../../../core/widgets/drop_down_menu/drop_down_menu.dart';
import '../../../../core/widgets/pop_ups/camera_popup.dart';
import '../../../../core/widgets/replacer/image_replacer.dart';
import '../../../product/presentation/widgets/add_container.dart';
import '../../../product/presentation/widgets/color_selector.dart';
import '../../../product/presentation/widgets/custom_toggle_button.dart';
import '../../../product/presentation/widgets/image_container.dart';

class WrongItemWidget extends StatefulWidget {
  const WrongItemWidget({super.key, this.isPreview = false});
  final bool isPreview;
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
        if (!widget.isPreview)
          dropDownMenu(
              hint: lang.chooseAnswer,
              selectedValue: cubit.wrongSelectedValue,
              items: wrongItems,
              context: context,
              onChanged: (item) {
                cubit.wrongSelectedValue = item!;
                setState(() {});
              })
        else
          Container(
            height: 70,
            padding: const EdgeInsets.all(20),
            width: screenWidth(context, 0.9),
            decoration: BoxDecoration(
              color: ColorManager.primaryW,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(cubit.returnDetails.returnedColor.isNotEmpty
                ? "Color"
                : 'Size'),
          ),
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
    log(cubit.returnDetails.returnedColor);
    return Row(
      children: [
        Text(
          lang.receivedColor,
          style: AppStylesManager.customTextStyleBl12,
        ),
        SizedBox(
          height: 16.sp,
        ),
        if (widget.isPreview) ...[
          ColorSelector(
            colors: colorProducts
                .where((e) =>
                    e.substring(2).toLowerCase() ==
                    cubit.returnDetails.returnedColor)
                .map((e) => e.substring(2))
                .toList(),
            selectedColor: cubit.selectedColor,
            onColorSelected: (color) {},
          ),
        ] else
          ColorSelector(
            colors: colorProducts.map((e) => e.substring(2)).toList(),
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
        if (widget.isPreview) ...[
          SizeToggleButtons(
            sizes: SizeTypes.values
                .where((e) => e.name == cubit.returnDetails.returnedSize)
                .map((e) => e.name)
                .toList(),
            selectedSize: cubit.selectedSize,
            onSizeSelected: (size) {},
          ),
        ] else
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

  _buildDamageWidget(S lang) {
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
                if (widget.isPreview)
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (c) {
                          return Scaffold(
                            appBar: AppBar(
                              centerTitle: true,
                              title: Text(lang.front),
                              leading: IconButton(
                                onPressed: () {
                                  navigatePop(context: c);
                                },
                                icon: const Icon(Icons.close),
                              ),
                            ),
                            body: Center(
                              child: imageReplacer(
                                  height: screenHeight(context, 0.85),
                                  url: cubit.returnDetails.frontImage),
                            ),
                          );
                        },
                      );
                    },
                    child: imageReplacer(
                      url: cubit.returnDetails.frontImage,
                      radius: 16,
                      width: screenWidth(context, 0.25),
                      height: screenWidth(context, 0.20),
                    ),
                  )
                else
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
                if (widget.isPreview)
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (c) {
                          return Scaffold(
                            appBar: AppBar(
                              centerTitle: true,
                              title: Text(lang.back),
                              leading: IconButton(
                                onPressed: () {
                                  navigatePop(context: c);
                                },
                                icon: const Icon(Icons.close),
                              ),
                            ),
                            body: Center(
                              child: imageReplacer(
                                  height: screenHeight(context, 0.85),
                                  url: cubit.returnDetails.backImage),
                            ),
                          );
                        },
                      );
                    },
                    child: imageReplacer(
                      url: cubit.returnDetails.backImage,
                      radius: 16,
                      width: screenWidth(context, 0.25),
                      height: screenWidth(context, 0.20),
                    ),
                  )
                else
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
                if (widget.isPreview)
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (c) {
                          return Scaffold(
                            appBar: AppBar(
                              centerTitle: true,
                              title: Text(lang.damagedPart),
                              leading: IconButton(
                                onPressed: () {
                                  navigatePop(context: c);
                                },
                                icon: const Icon(Icons.close),
                              ),
                            ),
                            body: Center(
                              child: imageReplacer(
                                  height: screenHeight(context, 0.85),
                                  url: cubit.returnDetails.damageImage),
                            ),
                          );
                        },
                      );
                    },
                    child: imageReplacer(
                      url: cubit.returnDetails.damageImage,
                      radius: 16,
                      width: screenWidth(context, 0.25),
                      height: screenWidth(context, 0.20),
                    ),
                  )
                else
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
      if (widget.isPreview) ...[
        cubit.returnDetails.returnedColor.isEmpty
            ? _buildSizeSelector(cubit, lang)
            : _buildColorSelector(cubit, lang),
      ] else
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
              if (widget.isPreview)
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (c) {
                        return Scaffold(
                          appBar: AppBar(
                            centerTitle: true,
                            title: Text(lang.front),
                            leading: IconButton(
                              onPressed: () {
                                navigatePop(context: c);
                              },
                              icon: const Icon(Icons.close),
                            ),
                          ),
                          body: Center(
                            child: imageReplacer(
                                height: screenHeight(context, 0.85),
                                url: cubit.returnDetails.frontImage),
                          ),
                        );
                      },
                    );
                  },
                  child: imageReplacer(
                    url: cubit.returnDetails.frontImage,
                    radius: 16,
                    width: screenWidth(context, 0.25),
                    height: screenWidth(context, 0.20),
                  ),
                )
              else
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
              if (widget.isPreview)
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (c) {
                        return Scaffold(
                          appBar: AppBar(
                            centerTitle: true,
                            title: Text(lang.front),
                            leading: IconButton(
                              onPressed: () {
                                navigatePop(context: c);
                              },
                              icon: const Icon(Icons.close),
                            ),
                          ),
                          body: Center(
                            child: imageReplacer(
                                height: screenHeight(context, 0.85),
                                url: cubit.returnDetails.backImage),
                          ),
                        );
                      },
                    );
                  },
                  child: imageReplacer(
                    url: cubit.returnDetails.backImage,
                    radius: 16,
                    width: screenWidth(context, 0.25),
                    height: screenWidth(context, 0.20),
                  ),
                )
              else
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
