import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/color_const.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/drop_down_menu/drop_down_menu.dart';
import 'package:nilelon/core/widgets/pop_ups/camera_popup.dart';
import 'package:nilelon/core/widgets/scaffold_image.dart';
import 'package:nilelon/features/product/presentation/widgets/add_container.dart';
import 'package:nilelon/features/product/presentation/widgets/color_selector.dart';
import 'package:nilelon/features/refund/presentation/cubit/refund_cubit.dart';

class ReturnItemPage extends StatefulWidget {
  const ReturnItemPage({super.key});

  @override
  State<ReturnItemPage> createState() => _ReturnItemPageState();
}

class _ReturnItemPageState extends State<ReturnItemPage> {
  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    var cubit = BlocProvider.of<RefundCubit>(context);
    List<String> items = [
      lang.ChangedMyMind,
      lang.wrongItem,
      lang.missingItem,
    ];
    List<String> wrongItems = [
      lang.size,
      lang.color,
      lang.damagedItem,
    ];
    return ScaffoldImage(
        appBar: customAppBar(
          title: lang.returnItem,
          context: context,
          hasIcon: false,
          hasLeading: true,
        ),
        body: Column(
          children: [
            const DefaultDivider(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 24.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lang.whichItem,
                    style: AppStylesManager.customTextStyleBl12,
                  ),
                  SizedBox(
                    height: 16.sp,
                  ),
                  //! card
                  Text(
                    lang.whydoyouwanttoreturnthisitem,
                    style: AppStylesManager.customTextStyleBl12,
                  ),
                  SizedBox(
                    height: 16.sp,
                  ),
                  dropDownMenu(
                      hint: lang.chooseAnswer,
                      selectedValue: cubit.selectedValue,
                      items: items,
                      context: context,
                      onChanged: (item) {
                        cubit.selectedValue = item;
                      }),

                  if (cubit.selectedValue == lang.ChangedMyMind) ...[
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
                            addContainer(() async {
                              cubit.image1 = await cameraDialog(context);
                            }, context, null, null),
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
                            addContainer(() async {
                              cubit.image2 = await cameraDialog(context);
                            }, context, null, null),
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
                    SizedBox(
                      height: 8.sp,
                    ),
                    Text(
                      lang.checkReturn,
                      style: AppStylesManager.customTextStyleBl12,
                    ),
                    SizedBox(
                      height: 8.sp,
                    ),
                    GradientButtonBuilder(
                      text: lang.returnItem,
                      ontap: () {},
                      width: screenWidth(context, 1),
                    )
                  ],
                  if (cubit.selectedValue == lang.wrongItem) ...[
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
                          cubit.wrongSelectedValue = item;
                        }),
                    SizedBox(
                      height: 16.sp,
                    ),
                    if (cubit.wrongSelectedValue == lang.size ||
                        cubit.wrongSelectedValue == lang.color) ...[
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
                              addContainer(() async {
                                cubit.image1 = await cameraDialog(context);
                              }, context, null, null),
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
                              addContainer(() async {
                                cubit.image2 = await cameraDialog(context);
                              }, context, null, null),
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
                      SizedBox(
                        height: 8.sp,
                      ),
                      Text(
                        lang.checkReturn,
                        style: AppStylesManager.customTextStyleBl12,
                      ),
                      SizedBox(
                        height: 8.sp,
                      ),
                      GradientButtonBuilder(
                        text: lang.returnItem,
                        ontap: () {},
                        width: screenWidth(context, 1),
                      )
                    ],
                    if (cubit.wrongSelectedValue == lang.damagedItem) ...[
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
                              addContainer(() async {
                                cubit.image1 = await cameraDialog(context);
                              }, context, null, null),
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
                              addContainer(() async {
                                cubit.image2 = await cameraDialog(context);
                              }, context, null, null),
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
                              addContainer(() async {
                                cubit.image3 = await cameraDialog(context);
                              }, context, null, null),
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
                      SizedBox(
                        height: 8.sp,
                      ),
                      Text(
                        lang.checkReturn,
                        style: AppStylesManager.customTextStyleBl12,
                      ),
                      SizedBox(
                        height: 8.sp,
                      ),
                      GradientButtonBuilder(
                        text: lang.returnItem,
                        ontap: () {},
                        width: screenWidth(context, 1),
                      )
                    ]
                  ],
                  if (cubit.selectedValue == lang.missingItem) ...[
                    SizedBox(
                      height: 8.sp,
                    ),
                    Text(
                      lang.checkReturn,
                      style: AppStylesManager.customTextStyleBl12,
                    ),
                    SizedBox(
                      height: 8.sp,
                    ),
                    GradientButtonBuilder(
                      text: lang.returnItem,
                      ontap: () {},
                      width: screenWidth(context, 1),
                    )
                  ]
                ],
              ),
            ),
          ],
        ));
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
          colors: colorProducts.map((e) => e).toList().toSet().toList(),
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
        ListView.builder(
            itemCount: cubit.sizes.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  cubit.selectedSize = cubit.sizes[index];
                  setState(() {});
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorManager.primaryO,
                    boxShadow: cubit.selectedSize == cubit.sizes[index]
                        ? [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.6),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ]
                        : null,
                    border: cubit.selectedSize == cubit.sizes[index]
                        ? Border.all(
                            color: Colors.orange,
                            width: 3,
                          )
                        : null,
                  ),
                  child: Text(cubit.sizes[index]),
                ),
              );
            })
      ],
    );
  }
}
