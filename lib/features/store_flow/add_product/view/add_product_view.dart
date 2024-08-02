import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:nilelon/features/store_flow/add_product/model/product_data/product_data.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/resources/const_functions.dart';
import 'package:nilelon/resources/appstyles_manager.dart';
import 'package:nilelon/utils/app_logs.dart';
import 'package:nilelon/utils/navigation.dart';
import 'package:nilelon/widgets/alert/delete_alert.dart';
import 'package:nilelon/widgets/alert/draft_alert.dart';
import 'package:nilelon/widgets/button/button_builder.dart';
import 'package:nilelon/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/widgets/divider/default_divider.dart';
import 'package:nilelon/widgets/drop_down_menu/drop_down_menu.dart';
import 'package:nilelon/widgets/pop_ups/camera_popup.dart';
import 'package:nilelon/widgets/text_form_field/text_and_form_field_column/without_icon/text_and_form_field_column_no_icon.dart';
import 'package:nilelon/widgets/text_form_field/text_field/const_text_form_field.dart';
import 'package:nilelon/widgets/text_form_field/text_field/text_form_field_builder.dart';
import 'package:nilelon/widgets/view_all_row/view_all_row.dart';
import 'package:nilelon/data/hive_stroage.dart';
import 'package:nilelon/features/store_flow/add_product/model/add_product/add_product_model.dart';
import 'package:nilelon/features/store_flow/add_product/widget/add_container.dart';
import 'package:nilelon/features/store_flow/add_product/widget/color_circle.dart';
import 'package:nilelon/features/store_flow/add_product/widget/image_container.dart';
import 'package:nilelon/features/store_flow/add_product/widget/size_container.dart';
import 'package:nilelon/features/store_flow/add_product/widget/table_headers.dart';
import 'package:nilelon/features/store_flow/add_product/widget/total_row.dart';

import 'cubit/addproduct_cubit.dart';

class AddProductView extends StatefulWidget {
  const AddProductView({super.key, required this.categoryName});
  final String categoryName;
  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  late final AddproductCubit cubit;

  @override
  void initState() {
    cubit = AddproductCubit.get(context);
    super.initState();
  }

  List<Map<String, bool>> generateIsEditableList(
      List<int> colors, List<bool> isEditable) {
    List<Map<String, bool>> editableList = [];
    for (int i = 0; i < colors.length; i++) {
      editableList.add({colors[i].toRadixString(16): isEditable[i]});
    }
    return editableList;
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    return Scaffold(
      backgroundColor: ColorManager.primaryW,
      appBar: customAppBar(
        title: lang.addProduct,
        context: context,
        hasIcon: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const DefaultDivider(),
            const SizedBox(
              height: 24,
            ),
            // Add to draft
            addToDraft(lang.addToDraft),
            Padding(
              padding: EdgeInsets.all(16.0.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  TextAndFormFieldColumnNoIcon(
                    title: lang.productName,
                    label: lang.enterProductName,
                    controller: cubit.productNameController,
                    type: TextInputType.text,
                    height: 30.h,
                  ),

                  // Product Description
                  TextAndFormFieldColumnNoIcon(
                    title: lang.productDescription,
                    label: lang.enterProductDescription,
                    controller: cubit.productDescriptionController,
                    type: TextInputType.text,
                    height: 30.h,
                    maxlines: false,
                    fieldHeight: 170,
                  ),

                  // Type
                  productType(context, lang.type, lang.selectType),

                  // Product Price
                  TextAndFormFieldColumnNoIcon(
                    title: lang.productPrice,
                    label: lang.enterProductPrice,
                    controller: cubit.priceController,
                    type: TextInputType.number,
                    height: 30.h,
                  ),

                  // Size Guide Image
                  Text(
                    lang.sizeGuide,
                    style: AppStylesManager.customTextStyleBl5,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      cubit.sizeGuideImage == null
                          ? addContainer(
                              () async {
                                cubit.sizeGuideImage =
                                    await cameraDialog(context);
                                setState(() {});
                              },
                              context,
                              screenWidth(context, 0.3),
                              screenWidth(context, 0.3),
                            )
                          : imageContainer(
                              () async {
                                cubit.sizeGuideImage =
                                    await cameraDialog(context);
                                setState(() {});
                              },
                              cubit.image!,
                              context,
                              screenWidth(context, 0.3),
                              screenWidth(context, 0.3),
                            ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  // Product Colors
                  productColor(
                    lang.productColors,
                  ),
                ],
              ),
            ),
            cubit.isNonEditable[cubit.selectedIndex]
                ? Column(
                    children: [
                      editRow(lang.editSizesForThisColor,
                          lang.areYouSureYouWantToDeleteAllSizesForThisColor),
                      nonEditableStack(context, lang.total),
                    ],
                  )
                : cubit.isAdd
                    ? varientImageAndTable(context, lang.total)
                    : Column(
                        children: [
                          addRow(lang.addSizesForThisColor),
                          nonEditableStack(context, lang.total),
                        ],
                      ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                lang.pressSubmitToConfirmOnlyThisColorDetailsAndUploadForAllColorsDetails,
                style: AppStylesManager.customTextStyleG17,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            buttonRow(context, lang.submit, lang.upload),
          ],
        ),
      ),
    );
  }

  Stack nonEditableStack(BuildContext context, String total) {
    return Stack(
      children: [
        varientImageAndTableNonEditable(context, total),
        Container(
          width: double.infinity,
          height: 1.sw > 600 ? 1000 : 770,
          color: ColorManager.primaryG.withOpacity(0.6),
        )
      ],
    );
  }

  Column productColor(String productCol) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          productCol,
          style: AppStylesManager.customTextStyleBl5,
        ),
        const SizedBox(
          height: 12,
        ),
        colorRow(),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }

  Column productType(BuildContext context, String type, String selectType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          type,
          style: AppStylesManager.customTextStyleBl5,
        ),
        const SizedBox(
          height: 12,
        ),
        dropDownMenu(
          hint: selectType,
          selectedValue: cubit.selectedValue,
          items: cubit.items,
          context: context,
          onChanged: (gender) {
            cubit.selectedValue = gender;
            setState(() {});
          },
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Padding varientImageAndTable(
    BuildContext context,
    String total,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      child: Column(
        children: [
          imageRow(context),
          const SizedBox(
            height: 40,
          ),
          const TableHeaders(),
          sizeListView(),
          totalRow(
              context,
              (cubit.xsController.text == ''
                      ? 0
                      : int.parse(cubit.xsController.text)) +
                  (cubit.sController.text == ''
                      ? 0
                      : int.parse(cubit.sController.text)) +
                  (cubit.lController.text == ''
                      ? 0
                      : int.parse(cubit.lController.text)) +
                  (cubit.xlController.text == ''
                      ? 0
                      : int.parse(cubit.xlController.text)) +
                  (cubit.xxlController.text == ''
                      ? 0
                      : int.parse(cubit.xxlController.text)) +
                  (cubit.xxxlController.text == ''
                      ? 0
                      : int.parse(cubit.xxxlController.text)) +
                  (cubit.mController.text == ''
                      ? 0
                      : int.parse(cubit.mController.text)),
              total),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }

  Padding varientImageAndTableNonEditable(BuildContext context, String total) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      child: SizedBox(
        height: 1.sw > 600 ? 1000 : 770,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            imageRowUnEditable(context),
            const SizedBox(
              height: 40,
            ),
            const TableHeaders(),
            sizeListView(),
            totalRow(
                context,
                (cubit.xsController.text == ''
                        ? 0
                        : int.parse(cubit.xsController.text)) +
                    (cubit.sController.text == ''
                        ? 0
                        : int.parse(cubit.sController.text)) +
                    (cubit.lController.text == ''
                        ? 0
                        : int.parse(cubit.lController.text)) +
                    (cubit.xlController.text == ''
                        ? 0
                        : int.parse(cubit.xlController.text)) +
                    (cubit.xxlController.text == ''
                        ? 0
                        : int.parse(cubit.xxlController.text)) +
                    (cubit.xxxlController.text == ''
                        ? 0
                        : int.parse(cubit.xxxlController.text)) +
                    (cubit.mController.text == ''
                        ? 0
                        : int.parse(cubit.mController.text)),
                total),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }

  Padding editRow(String editSizes, String deleteAlertStr) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              cubit.isAdd = true;
              cubit.isSubmit = true;
              cubit.isNonEditable[cubit.selectedIndex] = false;

              for (var element in cubit.nonEditableVarients) {
                if (cubit.selectedColor.toRadixString(16) == element.color) {
                  List varients = [];
                  varients = HiveStorage.get(HiveKeys.varients);
                  varients.remove(element);
                  HiveStorage.set(HiveKeys.varients, varients);
                }
              }

              setState(() {});
            },
            child: const Icon(
              Iconsax.edit_2,
              size: 22,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            editSizes,
            style: AppStylesManager.customTextStyleB,
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              deleteAlert(
                context,
                deleteAlertStr,
                () {
                  cubit.isNonEditable[cubit.selectedIndex] = false;
                  ProductVarieants? proVar;
                  List varients = [];
                  for (var element in cubit.nonEditableVarients) {
                    if (cubit.selectedColor.toRadixString(16) ==
                        element.color) {
                      proVar = element;
                      varients = HiveStorage.get(HiveKeys.varients);
                    }
                  }
                  cubit.nonEditableVarients.remove(proVar);
                  varients.remove(proVar);
                  HiveStorage.set(HiveKeys.varients, varients);
                  cubit.xsController = TextEditingController(text: "0");
                  cubit.sController = TextEditingController(text: "0");
                  cubit.mController = TextEditingController(text: "0");
                  cubit.lController = TextEditingController(text: "0");
                  cubit.xlController = TextEditingController(text: "0");
                  cubit.xxlController = TextEditingController(text: "0");
                  cubit.xxxlController = TextEditingController(text: "0");

                  if (cubit.nonEditableVarients.isEmpty) {
                    cubit.isActivated = false;
                    cubit.isSubmit = true;
                  }
                  navigatePop(context: context);
                  setState(() {});
                },
              );
            },
            child: Container(
              padding: EdgeInsets.all(4.sp),
              decoration: BoxDecoration(
                  color: ColorManager.primaryO,
                  borderRadius: BorderRadius.circular(20)),
              child: Icon(
                Iconsax.trash,
                color: ColorManager.primaryW,
                size: 18.r,
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding addRow(String addSizes) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              cubit.isAdd = true;
              cubit.isActivated = true;
              cubit.isSubmit = true;
              setState(() {});
            },
            child: Icon(
              Iconsax.edit_2,
              size: 22.r,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            addSizes,
            style: AppStylesManager.customTextStyleB,
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Padding buttonRow(
    BuildContext context,
    String submitStr,
    String uploadStr,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.94,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ButtonBuilder(
                text: submitStr,
                isActivated:
                    cubit.isActivated ? cubit.isSubmit : !cubit.isSubmit,
                ontap: () {
                  if (HiveStorage.get(HiveKeys.varients) == null) {
                    ProductVarieants productVarieants = ProductVarieants(
                        color: cubit.selectedColor.toRadixString(16),
                        imagesList: const [
                          '', //image == null ? File('') : image!,
                          '', //image1 == null ? File('') : image1!,
                          '', //image2 == null ? File('') : image2!,
                          '', //image3 == null ? File('') : image3!
                        ],
                        allSizesList: [
                          AllSizes(
                            size: 'XS',
                            price: (cubit.xsPriceController.text != '')
                                ? cubit.xsPriceController.text
                                : cubit.priceController.text == ''
                                    ? '0'
                                    : cubit.priceController.text,
                            amount: (cubit.xsController.text == ''
                                    ? 0
                                    : int.parse(cubit.xsController.text))
                                .toString(),
                          ),
                          AllSizes(
                            size: 'S',
                            price: (cubit.sPriceController.text != '')
                                ? cubit.sPriceController.text
                                : cubit.priceController.text == ''
                                    ? '0'
                                    : cubit.priceController.text,
                            amount: (cubit.sController.text == ''
                                    ? 0
                                    : int.parse(cubit.sController.text))
                                .toString(),
                          ),
                          AllSizes(
                            size: 'M',
                            price: (cubit.mPriceController.text != '')
                                ? cubit.mPriceController.text
                                : cubit.priceController.text == ''
                                    ? '0'
                                    : cubit.priceController.text,
                            amount: (cubit.mController.text == ''
                                    ? 0
                                    : int.parse(cubit.mController.text))
                                .toString(),
                          ),
                          AllSizes(
                            size: 'L',
                            price: (cubit.lPriceController.text != '')
                                ? cubit.lPriceController.text
                                : cubit.priceController.text == ''
                                    ? '0'
                                    : cubit.priceController.text,
                            amount: (cubit.lController.text == ''
                                    ? 0
                                    : int.parse(cubit.lController.text))
                                .toString(),
                          ),
                          AllSizes(
                            size: 'XL',
                            price: (cubit.xlPriceController.text != '')
                                ? cubit.xlPriceController.text
                                : cubit.priceController.text == ''
                                    ? '0'
                                    : cubit.priceController.text,
                            amount: (cubit.xlController.text == ''
                                    ? 0
                                    : int.parse(cubit.xlController.text))
                                .toString(),
                          ),
                          AllSizes(
                            size: 'XXL',
                            price: (cubit.xxlPriceController.text != '')
                                ? cubit.xxlPriceController.text
                                : cubit.priceController.text == ''
                                    ? '0'
                                    : cubit.priceController.text,
                            amount: (cubit.xxlController.text == ''
                                    ? 0
                                    : int.parse(cubit.xxlController.text))
                                .toString(),
                          ),
                          AllSizes(
                            size: 'XXXL',
                            price: (cubit.xxlPriceController.text != '')
                                ? cubit.xxxlPriceController.text
                                : cubit.priceController.text == ''
                                    ? '0'
                                    : cubit.priceController.text,
                            amount: (cubit.xxxlController.text == ''
                                    ? 0
                                    : int.parse(cubit.xxxlController.text))
                                .toString(),
                          ),
                        ]);
                    ProductVarieants? proVar;
                    for (var element in cubit.nonEditableVarients) {
                      if (cubit.selectedColor.toRadixString(16) ==
                          element.color) {
                        proVar = element;
                      }
                    }
                    cubit.nonEditableVarients.remove(proVar);
                    HiveStorage.set(HiveKeys.varients,
                        <ProductVarieants>[productVarieants]);
                    cubit.nonEditableVarients.add(productVarieants);
                  } else {
                    List varients = [];
                    varients = HiveStorage.get(HiveKeys.varients);
                    ProductVarieants productVarieants = ProductVarieants(
                        color: cubit.selectedColor.toRadixString(16),
                        imagesList: const [
                          '', //image == null ? File('') : image!,
                          '', //image == null ? File('') : image!,
                          '', //image1 == null ? File('') : image1!,
                          '', //image2 == null ? File('') : image2!,
                          '', //image3 == null ? File('') : image3!
                        ],
                        allSizesList: [
                          AllSizes(
                            size: 'XS',
                            price: (cubit.xsPriceController.text != '')
                                ? cubit.xsPriceController.text
                                : cubit.priceController.text == ''
                                    ? '0'
                                    : cubit.priceController.text,
                            amount: (cubit.xsController.text == ''
                                    ? 0
                                    : int.parse(cubit.xsController.text))
                                .toString(),
                          ),
                          AllSizes(
                            size: 'S',
                            price: (cubit.sPriceController.text != '')
                                ? cubit.sPriceController.text
                                : cubit.priceController.text == ''
                                    ? '0'
                                    : cubit.priceController.text,
                            amount: (cubit.sController.text == ''
                                    ? 0
                                    : int.parse(cubit.sController.text))
                                .toString(),
                          ),
                          AllSizes(
                            size: 'M',
                            price: (cubit.mPriceController.text != '')
                                ? cubit.mPriceController.text
                                : cubit.priceController.text == ''
                                    ? '0'
                                    : cubit.priceController.text,
                            amount: (cubit.mController.text == ''
                                    ? 0
                                    : int.parse(cubit.mController.text))
                                .toString(),
                          ),
                          AllSizes(
                            size: 'L',
                            price: (cubit.lPriceController.text != '')
                                ? cubit.lPriceController.text
                                : cubit.priceController.text == ''
                                    ? '0'
                                    : cubit.priceController.text,
                            amount: (cubit.lController.text == ''
                                    ? 0
                                    : int.parse(cubit.lController.text))
                                .toString(),
                          ),
                          AllSizes(
                            size: 'XL',
                            price: (cubit.xlPriceController.text != '')
                                ? cubit.xlPriceController.text
                                : cubit.priceController.text == ''
                                    ? '0'
                                    : cubit.priceController.text,
                            amount: (cubit.xlController.text == ''
                                    ? 0
                                    : int.parse(cubit.xlController.text))
                                .toString(),
                          ),
                          AllSizes(
                            size: 'XXL',
                            price: (cubit.xxlPriceController.text != '')
                                ? cubit.xxlPriceController.text
                                : cubit.priceController.text == ''
                                    ? '0'
                                    : cubit.priceController.text,
                            amount: (cubit.xxlController.text == ''
                                    ? 0
                                    : int.parse(cubit.xxlController.text))
                                .toString(),
                          ),
                          AllSizes(
                            size: 'XXXL',
                            price: (cubit.xxlPriceController.text != '')
                                ? cubit.xxxlPriceController.text
                                : cubit.priceController.text == ''
                                    ? '0'
                                    : cubit.priceController.text,
                            amount: (cubit.xxxlController.text == ''
                                    ? 0
                                    : int.parse(cubit.xxxlController.text))
                                .toString(),
                          ),
                        ]);
                    ProductVarieants? proVar;
                    for (var element in cubit.nonEditableVarients) {
                      if (cubit.selectedColor.toRadixString(16) ==
                          element.color) {
                        proVar = element;
                      }
                    }
                    cubit.nonEditableVarients.remove(proVar);
                    varients.add(productVarieants);
                    HiveStorage.set(HiveKeys.varients, varients);
                    cubit.nonEditableVarients.add(productVarieants);
                  }
                  cubit.isNonEditable[cubit.selectedIndex] = true;
                  cubit.isAdd = false;
                  cubit.isSubmit = false;
                  cubit.sizes = [
                    {
                      'size': 'XS',
                      "isEdit": false,
                    },
                    {
                      'size': 'S',
                      "isEdit": false,
                    },
                    {
                      'size': 'M',
                      "isEdit": false,
                    },
                    {
                      'size': 'L',
                      "isEdit": false,
                    },
                    {
                      'size': 'XL',
                      "isEdit": false,
                    },
                    {
                      'size': 'XXL',
                      "isEdit": false,
                    },
                    {
                      'size': 'XXXL',
                      "isEdit": false,
                    },
                  ];
                  setState(() {});
                  AppLogs.infoLog(
                      HiveStorage.get(HiveKeys.varients).toString());
                }),
            GradientButtonBuilder(
                isActivated: !cubit.isSubmit,
                text: uploadStr,
                ontap: () {
                  AppLogs.infoLog(
                      HiveStorage.get(HiveKeys.varients).toString());
                  navigatePop(context: context);
                }),
          ],
        ),
      ),
    );
  }

  ListView sizeListView() {
    return ListView.builder(
      itemBuilder: (context, index) => cubit.isNonEditable[cubit.selectedIndex]
          ? sizeRowUnEditable(
              context,
              cubit.sizes[index]['size'],
              index == 0
                  ? cubit.xsPriceController
                  : index == 1
                      ? cubit.sPriceController
                      : index == 2
                          ? cubit.mPriceController
                          : index == 3
                              ? cubit.lPriceController
                              : index == 4
                                  ? cubit.xlPriceController
                                  : index == 5
                                      ? cubit.xxlPriceController
                                      : cubit.xxxlPriceController,
              index == 0
                  ? cubit.xsController
                  : index == 1
                      ? cubit.sController
                      : index == 2
                          ? cubit.mController
                          : index == 3
                              ? cubit.lController
                              : index == 4
                                  ? cubit.xlController
                                  : index == 5
                                      ? cubit.xxlController
                                      : cubit.xxxlController,
            )
          : sizeRow(
              context,
              cubit.sizes[index]['size'],
              () {
                cubit.sizes[index]['isEdit'] = true;
                setState(() {});
              },
              cubit.sizes[index]['isEdit'],
              index == 0
                  ? cubit.xsPriceController
                  : index == 1
                      ? cubit.sPriceController
                      : index == 2
                          ? cubit.mPriceController
                          : index == 3
                              ? cubit.lPriceController
                              : index == 4
                                  ? cubit.xlPriceController
                                  : index == 5
                                      ? cubit.xxlPriceController
                                      : cubit.xxxlPriceController,
              index == 0
                  ? cubit.xsController
                  : index == 1
                      ? cubit.sController
                      : index == 2
                          ? cubit.mController
                          : index == 3
                              ? cubit.lController
                              : index == 4
                                  ? cubit.xlController
                                  : index == 5
                                      ? cubit.xxlController
                                      : cubit.xxxlController,
            ),
      itemCount: cubit.sizes.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }

  GestureDetector sizeRow(
      BuildContext context,
      String size,
      void Function() onTap,
      bool isEdit,
      TextEditingController defaultPriceController,
      TextEditingController amountController) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 16,
              left: 30,
              right: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                sizeContainer(context, size),
                TextFormFieldBuilder(
                  label:
                      amountController.text == '' ? '0' : amountController.text,
                  controller: amountController,
                  type: TextInputType.number,
                  textAlign: TextAlign.center,
                  height: 46.h,
                  disabledBorder:
                      const BorderSide(color: ColorManager.primaryB2),
                  width: 1.sw > 600
                      ? screenWidth(context, 0.4)
                      : screenWidth(context, 0.2),
                  noIcon: true,
                ),
                isEdit
                    ? TextFormFieldBuilder(
                        label: (defaultPriceController.text != '')
                            ? defaultPriceController.text
                            : '0',
                        controller: defaultPriceController,
                        type: TextInputType.number,
                        textAlign: TextAlign.center,
                        height: 46.h,
                        disabledBorder: const BorderSide(
                          color: ColorManager.primaryB2,
                        ),
                        width: 1.sw > 600
                            ? screenWidth(context, 0.15)
                            : screenWidth(context, 0.3),
                        noIcon: true,
                      )
                    : SizedBox(
                        width: screenWidth(context, 0.15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              defaultPriceController.text != ''
                                  ? defaultPriceController.text
                                  : cubit.priceController.text == ''
                                      ? '0'
                                      : cubit.priceController.text,
                              style: AppStylesManager.customTextStyleO3,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            const Icon(
                              Iconsax.edit_2,
                              color: ColorManager.primaryG,
                              size: 20,
                            )
                          ],
                        ),
                      )
              ],
            ),
          )
        ],
      ),
    );
  }

  Column sizeRowUnEditable(
      BuildContext context,
      String size,
      TextEditingController defaultPriceController,
      TextEditingController amountController) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 16,
            left: 30,
            right: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              sizeContainer(context, size),
              ConstTextFieldBuilder(
                label:
                    amountController.text == '' ? '0' : amountController.text,
                textAlign: TextAlign.center,
                height: 46.h,
                style: AppStylesManager.customTextStyleG2,
                disabledBorder: const BorderSide(color: ColorManager.primaryB2),
                width: 1.sw > 600
                    ? screenWidth(context, 0.4)
                    : screenWidth(context, 0.2),
              ),
              SizedBox(
                width: screenWidth(context, 0.15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      defaultPriceController.text != ''
                          ? defaultPriceController.text
                          : cubit.priceController.text == ''
                              ? '0'
                              : cubit.priceController.text,
                      style: AppStylesManager.customTextStyleO3,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Icon(
                      Iconsax.edit_2,
                      color: ColorManager.primaryG,
                      size: 20,
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  ViewAllRow addToDraft(String addToDraft) {
    return ViewAllRow(
      noText: true,
      style: AppStylesManager.customTextStyleBl5.copyWith(
        fontWeight: FontWeight.w500,
      ),
      buttonWidget: GestureDetector(
          onTap: () {
            draftAlert(context, () {
              navigatePop(context: context);

              if (HiveStorage.get(HiveKeys.productData) == null) {
                if (HiveStorage.get(HiveKeys.varients) == null) {
                  List<ProductVarieants> varients = [];
                  HiveStorage.set(
                    HiveKeys.productData,
                    <ProductData>[
                      ProductData(
                        productPrice: cubit.priceController.text,
                        product: AddProductModel(
                          categoryName: widget.categoryName,
                          productName: cubit.productNameController.text,
                          type: cubit.selectedValue.toString(),
                          productDescription:
                              cubit.productDescriptionController.text,
                          varieantsList: varients,
                          sizeGuideImage: '',
                        ),
                        isEditable: generateIsEditableList(
                            cubit.colors, cubit.isNonEditable), //[],
                      ),
                    ],
                  );
                  HiveStorage.remove(HiveKeys.varients);
                } else {
                  List varients = [];
                  varients = HiveStorage.get(HiveKeys.varients);
                  HiveStorage.set(
                    HiveKeys.productData,
                    <ProductData>[
                      ProductData(
                        productPrice: cubit.priceController.text,
                        product: AddProductModel(
                          categoryName: widget.categoryName,
                          productName: cubit.productNameController.text,
                          type: cubit.selectedValue.toString(),
                          productDescription:
                              cubit.productDescriptionController.text,
                          varieantsList: varients,
                          sizeGuideImage: '',
                        ),
                        isEditable: generateIsEditableList(
                            cubit.colors, cubit.isNonEditable),
                      ),
                    ],
                  );
                  HiveStorage.remove(HiveKeys.varients);
                }
              } else {
                if (HiveStorage.get(HiveKeys.varients) == null) {
                  List<ProductVarieants> varients = [];
                  List data = [];
                  data = HiveStorage.get(HiveKeys.productData);
                  data.add(
                    ProductData(
                      productPrice: cubit.priceController.text,
                      product: AddProductModel(
                        categoryName: widget.categoryName,
                        productName: cubit.productNameController.text,
                        type: cubit.selectedValue.toString(),
                        productDescription:
                            cubit.productDescriptionController.text,
                        varieantsList: varients,
                        sizeGuideImage: '',
                      ),
                      isEditable: generateIsEditableList(
                          cubit.colors, cubit.isNonEditable),
                    ),
                  );
                  HiveStorage.set(
                    HiveKeys.productData, data,
                    // <ProductData>[],
                  );
                  HiveStorage.remove(HiveKeys.varients);
                } else {
                  List<ProductVarieants> varients = [];
                  varients = HiveStorage.get(HiveKeys.varients);
                  List data = [];
                  data = HiveStorage.get(HiveKeys.productData);
                  data.add(ProductData(
                    productPrice: cubit.priceController.text,
                    product: AddProductModel(
                      categoryName: widget.categoryName,
                      productName: cubit.productNameController.text,
                      type: cubit.selectedValue.toString(),
                      productDescription:
                          cubit.productDescriptionController.text,
                      varieantsList: varients,
                      sizeGuideImage: '',
                    ),
                    isEditable: generateIsEditableList(
                        cubit.colors, cubit.isNonEditable),
                  ));
                  HiveStorage.set(
                    HiveKeys.productData,
                    data,
                  );
                  HiveStorage.remove(HiveKeys.varients);
                }
              }
              navigatePop(context: context);
              // showToast('Saved As Draft');
            });
          },
          child: Text(
            addToDraft,
            style: AppStylesManager.customTextStyleO,
          )),
    );
  }

  SizedBox colorRow() {
    return SizedBox(
      height: 40.h,
      child: ListView.builder(
        itemBuilder: (context, index) => colorCircle(() {
          cubit.selectedIndex = index;
          cubit.selectedColor = cubit.colors[cubit.selectedIndex];
          cubit.sizes = [
            {
              'size': 'XS',
              "isEdit": false,
            },
            {
              'size': 'S',
              "isEdit": false,
            },
            {
              'size': 'M',
              "isEdit": false,
            },
            {
              'size': 'L',
              "isEdit": false,
            },
            {
              'size': 'XL',
              "isEdit": false,
            },
            {
              'size': 'XXL',
              "isEdit": false,
            },
            {
              'size': 'XXXL',
              "isEdit": false,
            },
          ];
          for (var varieant in cubit.nonEditableVarients) {
            if (varieant.color.toLowerCase() ==
                cubit.selectedColor.toRadixString(16)) {
              if (varieant.allSizesList.isNotEmpty) {
                cubit.xsController = TextEditingController(
                    text: varieant.allSizesList[0].amount);
                cubit.sController = TextEditingController(
                    text: varieant.allSizesList[1].amount);
                cubit.mController = TextEditingController(
                    text: varieant.allSizesList[2].amount);
                cubit.lController = TextEditingController(
                    text: varieant.allSizesList[3].amount);
                cubit.xlController = TextEditingController(
                    text: varieant.allSizesList[4].amount);
                cubit.xxlController = TextEditingController(
                    text: varieant.allSizesList[5].amount);
                cubit.xxxlController = TextEditingController(
                    text: varieant.allSizesList[6].amount);
                cubit.xsPriceController =
                    TextEditingController(text: varieant.allSizesList[0].price);
                cubit.sPriceController =
                    TextEditingController(text: varieant.allSizesList[1].price);
                cubit.mPriceController =
                    TextEditingController(text: varieant.allSizesList[2].price);
                cubit.lPriceController =
                    TextEditingController(text: varieant.allSizesList[3].price);
                cubit.xlPriceController =
                    TextEditingController(text: varieant.allSizesList[4].price);
                cubit.xxlPriceController =
                    TextEditingController(text: varieant.allSizesList[5].price);
                cubit.xxxlPriceController =
                    TextEditingController(text: varieant.allSizesList[6].price);
              }
            } else {
              cubit.xsController = TextEditingController(text: '0');
              cubit.sController = TextEditingController(text: '0');
              cubit.mController = TextEditingController(text: '0');
              cubit.lController = TextEditingController(text: '0');
              cubit.xlController = TextEditingController(text: '0');
              cubit.xxlController = TextEditingController(text: '0');
              cubit.xxxlController = TextEditingController(text: '0');
              cubit.xsPriceController =
                  TextEditingController(text: cubit.priceController.text);
              cubit.sPriceController =
                  TextEditingController(text: cubit.priceController.text);
              cubit.mPriceController =
                  TextEditingController(text: cubit.priceController.text);
              cubit.lPriceController =
                  TextEditingController(text: cubit.priceController.text);
              cubit.xlPriceController =
                  TextEditingController(text: cubit.priceController.text);
              cubit.xxlPriceController =
                  TextEditingController(text: cubit.priceController.text);
              cubit.xxxlPriceController =
                  TextEditingController(text: cubit.priceController.text);
            }
          }

          setState(() {});
        }, cubit.colors[index], cubit.selectedIndex, index,
            cubit.isNonEditable[index]),
        itemCount: cubit.colors.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  SizedBox imageRow(BuildContext context) {
    return SizedBox(
      height: screenWidth(context, 0.21),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          cubit.image == null
              ? addContainer(
                  () async {
                    cubit.image = await cameraDialog(context);
                    setState(() {});
                  },
                  context,
                  null,
                  null,
                )
              : imageContainer(
                  () async {
                    cubit.image = await cameraDialog(context);
                    setState(() {});
                  },
                  cubit.image!,
                  context,
                  null,
                  null,
                ),
          cubit.image1 == null
              ? addContainer(
                  () async {
                    cubit.image1 = await cameraDialog(context);
                    setState(() {});
                  },
                  context,
                  null,
                  null,
                )
              : imageContainer(
                  () async {
                    cubit.image1 = await cameraDialog(context);
                    setState(() {});
                  },
                  cubit.image1!,
                  context,
                  null,
                  null,
                ),
          cubit.image2 == null
              ? addContainer(
                  () async {
                    cubit.image2 = await cameraDialog(context);
                    setState(() {});
                  },
                  context,
                  null,
                  null,
                )
              : imageContainer(
                  () async {
                    cubit.image2 = await cameraDialog(context);
                    setState(() {});
                  },
                  cubit.image2!,
                  context,
                  null,
                  null,
                ),
          cubit.image3 == null
              ? addContainer(
                  () async {
                    cubit.image3 = await cameraDialog(context);
                    setState(() {});
                  },
                  context,
                  null,
                  null,
                )
              : imageContainer(
                  () async {
                    cubit.image3 = await cameraDialog(context);
                    setState(() {});
                  },
                  cubit.image3!,
                  context,
                  null,
                  null,
                ),
        ],
      ),
    );
  }

  SizedBox imageRowUnEditable(BuildContext context) {
    return SizedBox(
      // height: screenWidth(context, 0.21),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          cubit.image == null
              ? addContainer(
                  () {},
                  context,
                  null,
                  null,
                )
              : imageContainer(
                  () {},
                  cubit.image!,
                  context,
                  null,
                  null,
                ),
          cubit.image1 == null
              ? addContainer(
                  () {},
                  context,
                  null,
                  null,
                )
              : imageContainer(
                  () {},
                  cubit.image1!,
                  context,
                  null,
                  null,
                ),
          cubit.image2 == null
              ? addContainer(
                  () {},
                  context,
                  null,
                  null,
                )
              : imageContainer(
                  () {},
                  cubit.image2!,
                  context,
                  null,
                  null,
                ),
          cubit.image3 == null
              ? addContainer(
                  () {},
                  context,
                  null,
                  null,
                )
              : imageContainer(
                  () {},
                  cubit.image3!,
                  context,
                  null,
                  null,
                ),
        ],
      ),
    );
  }
}
