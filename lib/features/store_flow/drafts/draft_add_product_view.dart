import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nilelon/features/auth/domain/model/user_model.dart';
import 'package:nilelon/features/product/domain/models/product_data/product_data.dart';
import 'package:nilelon/features/store_flow/drafts/drafts_view.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/resources/const_functions.dart';
import 'package:nilelon/resources/appstyles_manager.dart';
import 'package:nilelon/utils/app_logs.dart';
import 'package:nilelon/utils/navigation.dart';
import 'package:nilelon/widgets/alert/delete_alert.dart';
import 'package:nilelon/widgets/button/button_builder.dart';
import 'package:nilelon/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/widgets/divider/default_divider.dart';
import 'package:nilelon/widgets/drop_down_menu/drop_down_menu.dart';
import 'package:nilelon/widgets/pop_ups/camera_popup.dart';
import 'package:nilelon/widgets/shimmer_indicator/build_shimmer.dart';
import 'package:nilelon/widgets/text_form_field/text_and_form_field_column/without_icon/text_and_form_field_column_no_icon.dart';
import 'package:nilelon/widgets/text_form_field/text_field/const_text_form_field.dart';
import 'package:nilelon/widgets/text_form_field/text_field/text_form_field_builder.dart';
import 'package:nilelon/widgets/view_all_row/view_all_row.dart';
import 'package:nilelon/data/hive_stroage.dart';
import 'package:nilelon/features/product/domain/models/add_product/add_product_model.dart';
import 'package:nilelon/features/product/presentation/widgets/add_container.dart';
import 'package:nilelon/features/product/presentation/widgets/color_circle.dart';
import 'package:nilelon/features/product/presentation/widgets/image_container.dart';
import 'package:nilelon/features/product/presentation/widgets/size_container.dart';
import 'package:nilelon/features/product/presentation/widgets/table_headers.dart';
import 'package:nilelon/features/product/presentation/widgets/total_row.dart';

class DraftAddProductView extends StatefulWidget {
  const DraftAddProductView({
    super.key,
    required this.categoryName,
    required this.data,
    required this.selectionIndex,
  });
  final String categoryName;
  final ProductData data;
  final int selectionIndex;
  @override
  State<DraftAddProductView> createState() => _DraftAddProductViewState();
}

class _DraftAddProductViewState extends State<DraftAddProductView> {
  File? image;
  File? image1;
  File? image2;
  File? image3;
  File? sizeGuideImage;
  TextEditingController xsController = TextEditingController();
  TextEditingController sController = TextEditingController();
  TextEditingController mController = TextEditingController();
  TextEditingController lController = TextEditingController();
  TextEditingController xlController = TextEditingController();
  TextEditingController xxlController = TextEditingController();
  TextEditingController xxxlController = TextEditingController();
  TextEditingController xsPriceController = TextEditingController();
  TextEditingController sPriceController = TextEditingController();
  TextEditingController mPriceController = TextEditingController();
  TextEditingController lPriceController = TextEditingController();
  TextEditingController xlPriceController = TextEditingController();
  TextEditingController xxlPriceController = TextEditingController();
  TextEditingController xxxlPriceController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  List<int> colors = [
    0xFFD80000,
    0xFF1F00DF,
    0xFFFFCD1C,
    0xFFFFFFFF,
    0xFF101010,
    0xFF170048,
    0xFF165A11,
  ];
  List<bool> isNonEditable = [];
  int selectedColor = 0xFFD80000;
  List nonEditableVarients = [];
  List<Map<String, dynamic>> sizes = [
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
  int selectedIndex = 0;
  String? selectedValue;
  bool isSubmit = true;
  bool isActivated = false;
  bool isAdd = false;
  bool isLoading = true;

  List<String> items = ['Male', 'Female', 'Both'];

  List<Map<String, bool>> generateIsEditableList(
      List<int> colors, List<bool> isEditable) {
    List<Map<String, bool>> editableList = [];
    for (int i = 0; i < colors.length; i++) {
      editableList.add({colors[i].toRadixString(16): isEditable[i]});
    }
    return editableList;
  }

  Future<void> _initializeLists() async {
    await Future.delayed(const Duration(milliseconds: 100));
    for (int color in colors) {
      bool isEditable = true;
      for (var nonEditableColor in widget.data.isEditable) {
        if (color.toRadixString(16) == nonEditableColor.keys.first) {
          isEditable = nonEditableColor.values.first;
        }
      }
      isNonEditable.add(isEditable);
    }
    // print(isNonEditable);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _initializeLists();
    nonEditableVarients.addAll(widget.data.product.variants);
    xsController = TextEditingController(
        text: widget.data.product.variants.isNotEmpty
            ? widget.data.product.variants[selectedIndex].sizes[0].quantity
                .toString()
            : '0');
    sController = TextEditingController(
        text: widget.data.product.variants.isNotEmpty
            ? widget.data.product.variants[selectedIndex].sizes[1].quantity
                .toString()
            : '0');
    mController = TextEditingController(
        text: widget.data.product.variants.isNotEmpty
            ? widget.data.product.variants[selectedIndex].sizes[2].quantity
                .toString()
            : '0');
    lController = TextEditingController(
        text: widget.data.product.variants.isNotEmpty
            ? widget.data.product.variants[selectedIndex].sizes[3].quantity
                .toString()
            : '0');
    xlController = TextEditingController(
        text: widget.data.product.variants.isNotEmpty
            ? widget.data.product.variants[selectedIndex].sizes[4].quantity
                .toString()
            : '0');
    xxlController = TextEditingController(
        text: widget.data.product.variants.isNotEmpty
            ? widget.data.product.variants[selectedIndex].sizes[5].quantity
                .toString()
            : '0');
    xxxlController = TextEditingController(
        text: widget.data.product.variants.isNotEmpty
            ? widget.data.product.variants[selectedIndex].sizes[6].quantity
                .toString()
            : '0');
    xsPriceController = TextEditingController(
        text: widget.data.product.variants.isNotEmpty
            ? widget.data.product.variants[selectedIndex].sizes[0].price
                .toString()
            : '0');
    sPriceController = TextEditingController(
        text: widget.data.product.variants.isNotEmpty
            ? widget.data.product.variants[selectedIndex].sizes[1].price
                .toString()
            : '0');
    mPriceController = TextEditingController(
        text: widget.data.product.variants.isNotEmpty
            ? widget.data.product.variants[selectedIndex].sizes[2].price
                .toString()
            : '0');
    lPriceController = TextEditingController(
        text: widget.data.product.variants.isNotEmpty
            ? widget.data.product.variants[selectedIndex].sizes[3].price
                .toString()
            : '0');
    xlPriceController = TextEditingController(
        text: widget.data.product.variants.isNotEmpty
            ? widget.data.product.variants[selectedIndex].sizes[4].price
                .toString()
            : '0');
    xxlPriceController = TextEditingController(
        text: widget.data.product.variants.isNotEmpty
            ? widget.data.product.variants[selectedIndex].sizes[5].price
                .toString()
            : '0');
    xxxlPriceController = TextEditingController(
        text: widget.data.product.variants.isNotEmpty
            ? widget.data.product.variants[selectedIndex].sizes[6].price
                .toString()
            : '0');
    priceController = TextEditingController(
      text: widget.data.productPrice,
    );
    productNameController = TextEditingController(
      text: widget.data.product.name,
    );
    productDescriptionController = TextEditingController(
      text: widget.data.product.description,
    );
    selectedValue = widget.data.product.type;

    if (nonEditableVarients.isNotEmpty) {
      isActivated = true;
      isSubmit = false;
    }
    AppLogs.infoLog(isNonEditable.toString());
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    return Scaffold(
      backgroundColor: ColorManager.primaryW,
      appBar: customAppBar(
        leadingOnPressed: () {
          navigateAndReplace(context: context, screen: const DraftsView());
        },
        title: lang.addProduct,
        context: context,
        hasIcon: false,
      ),
      body: SingleChildScrollView(
        child: isNonEditable.isEmpty
            ? buildShimmerIndicator()
            : Column(
                children: [
                  const DefaultDivider(),
                  const SizedBox(
                    height: 24,
                  ),
                  // Add to draft
                  updateDraft(lang.updateDraft),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Name
                        TextAndFormFieldColumnNoIcon(
                          title: lang.productName,
                          label: lang.enterProductName,
                          controller: productNameController,
                          type: TextInputType.text,
                          height: 30,
                        ),

                        // Product Description
                        TextAndFormFieldColumnNoIcon(
                          title: lang.productDescription,
                          label: lang.enterProductDescription,
                          controller: productDescriptionController,
                          type: TextInputType.text,
                          height: 30,
                          maxlines: false,
                          fieldHeight: 170,
                        ),

                        // Type
                        productType(context, lang.type, lang.selectType),

                        // Product Price
                        TextAndFormFieldColumnNoIcon(
                          title: lang.productPrice,
                          label: lang.enterProductPrice,
                          controller: priceController,
                          type: TextInputType.number,
                          height: 30,
                        ),

                        // Size Guide Image
                        Text(
                          lang.sizeGuide,
                          style: AppStylesManager.customTextStyleBl5,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            sizeGuideImage == null
                                ? addContainer(
                                    () async {
                                      sizeGuideImage =
                                          await cameraDialog(context);
                                      setState(() {});
                                    },
                                    context,
                                    screenWidth(context, 0.3),
                                    screenWidth(context, 0.3),
                                  )
                                : imageContainer(
                                    () async {
                                      sizeGuideImage =
                                          await cameraDialog(context);
                                      setState(() {});
                                    },
                                    image!,
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
                        productColor(lang.productColors),
                      ],
                    ),
                  ),
                  isNonEditable[selectedIndex]
                      ? Column(
                          children: [
                            editRow(lang.editSizesForThisColor,
                                lang.areYouSureYouWantToDeleteAllSizesForThisColor),
                            nonEditableStack(context, lang.total),
                          ],
                        )
                      : isAdd
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
          height: 760,
          color: ColorManager.primaryG.withOpacity(0.6),
        )
      ],
    );
  }

  Column productColor(String productColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          productColor,
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
          selectedValue: selectedValue,
          items: items,
          context: context,
          onChanged: (gender) {
            selectedValue = gender;
            setState(() {});
          },
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Padding varientImageAndTable(BuildContext context, String total) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
              (xsController.text == '' ? 0 : int.parse(xsController.text)) +
                  (sController.text == '' ? 0 : int.parse(sController.text)) +
                  (lController.text == '' ? 0 : int.parse(lController.text)) +
                  (xlController.text == '' ? 0 : int.parse(xlController.text)) +
                  (xxlController.text == ''
                      ? 0
                      : int.parse(xxlController.text)) +
                  (xxxlController.text == ''
                      ? 0
                      : int.parse(xxxlController.text)) +
                  (mController.text == '' ? 0 : int.parse(mController.text)),
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 770,
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
                (xsController.text == '' ? 0 : int.parse(xsController.text)) +
                    (sController.text == '' ? 0 : int.parse(sController.text)) +
                    (lController.text == '' ? 0 : int.parse(lController.text)) +
                    (xlController.text == ''
                        ? 0
                        : int.parse(xlController.text)) +
                    (xxlController.text == ''
                        ? 0
                        : int.parse(xxlController.text)) +
                    (xxxlController.text == ''
                        ? 0
                        : int.parse(xxxlController.text)) +
                    (mController.text == '' ? 0 : int.parse(mController.text)),
                total),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }

  Padding editRow(String editColor, String deleteAlertStr) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              isAdd = true;
              isSubmit = true;
              isNonEditable[selectedIndex] = false;

              for (var element in nonEditableVarients) {
                if (selectedColor.toRadixString(16) == element.color) {
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
            editColor,
            style: AppStylesManager.customTextStyleB,
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              deleteAlert(
                context,
                deleteAlertStr,
                () {
                  isNonEditable[selectedIndex] = false;
                  var proVar;
                  List varients = [];
                  for (var element in nonEditableVarients) {
                    if (selectedColor.toRadixString(16) == element.color) {
                      proVar = element;
                      varients = HiveStorage.get(HiveKeys.varients);
                    }
                  }
                  nonEditableVarients.remove(proVar);
                  varients.remove(proVar);
                  HiveStorage.set(HiveKeys.varients, varients);
                  xsController = TextEditingController(text: "0");
                  sController = TextEditingController(text: "0");
                  mController = TextEditingController(text: "0");
                  lController = TextEditingController(text: "0");
                  xlController = TextEditingController(text: "0");
                  xxlController = TextEditingController(text: "0");
                  xxxlController = TextEditingController(text: "0");

                  if (nonEditableVarients.isEmpty) {
                    isActivated = false;
                    isSubmit = true;
                  }
                  navigatePop(context: context);
                  setState(() {});
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: ColorManager.primaryO,
                  borderRadius: BorderRadius.circular(20)),
              child: const Icon(
                Iconsax.trash,
                color: ColorManager.primaryW,
                size: 18,
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding addRow(String addSizes) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              isAdd = true;
              isActivated = true;
              isSubmit = true;
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
    String upload,
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
                isActivated: isActivated ? isSubmit : !isSubmit,
                ontap: () {
                  if (HiveStorage.get(HiveKeys.varients) == null) {
                    Variant productVarieants =
                        Variant(color: selectedColor, images: [
                      ''
                          ''
                          ''
                          ''
                          ''
                          ''
                    ], sizes: [
                      SizeModel(
                        size: 'XS',
                        price: (xsPriceController.text != '')
                            ? num.parse(priceController.text)
                            : priceController.text == ''
                                ? 0
                                : num.parse(priceController.text),
                        quantity: (xsController.text == ''
                            ? 0
                            : int.parse(xsController.text)),
                      ),
                      SizeModel(
                        size: 'S',
                        price: (sPriceController.text != '')
                            ? num.parse(sPriceController.text)
                            : priceController.text == ''
                                ? 0
                                : num.parse(sPriceController.text),
                        quantity: (sController.text == ''
                            ? 0
                            : int.parse(sController.text)),
                      ),
                      SizeModel(
                        size: 'M',
                        price: (mPriceController.text != '')
                            ? num.parse(mPriceController.text)
                            : priceController.text == ''
                                ? 0
                                : num.parse(mPriceController.text),
                        quantity: (mController.text == ''
                            ? 0
                            : int.parse(mController.text)),
                      ),
                      SizeModel(
                        size: 'L',
                        price: (lPriceController.text != '')
                            ? num.parse(lPriceController.text)
                            : priceController.text == ''
                                ? 0
                                : num.parse(lPriceController.text),
                        quantity: (lController.text == ''
                            ? 0
                            : int.parse(lController.text)),
                      ),
                      SizeModel(
                        size: 'XL',
                        price: (xlPriceController.text != '')
                            ? num.parse(xlPriceController.text)
                            : priceController.text == ''
                                ? 0
                                : num.parse(xlPriceController.text),
                        quantity: (xlController.text == ''
                            ? 0
                            : int.parse(xlController.text)),
                      ),
                      SizeModel(
                        size: 'XXL',
                        price: (xxlPriceController.text != '')
                            ? num.parse(xxlPriceController.text)
                            : priceController.text == ''
                                ? 0
                                : num.parse(xxlPriceController.text),
                        quantity: (xxlController.text == ''
                            ? 0
                            : int.parse(xxlController.text)),
                      ),
                      SizeModel(
                        size: 'XXXL',
                        price: (xxlPriceController.text != '')
                            ? num.parse(xxxlPriceController.text)
                            : priceController.text == ''
                                ? 0
                                : num.parse(xxxlPriceController.text),
                        quantity: (xxxlController.text == ''
                            ? 0
                            : int.parse(xxxlController.text)),
                      ),
                    ]);
                    var proVar;
                    for (var element in nonEditableVarients) {
                      if (selectedColor.toRadixString(16) == element.color) {
                        proVar = element;
                      }
                    }
                    nonEditableVarients.remove(proVar);
                    HiveStorage.set(
                        HiveKeys.varients, <Variant>[productVarieants]);
                    nonEditableVarients.add(productVarieants);
                  } else {
                    List varients = [];
                    varients = HiveStorage.get(HiveKeys.varients);
                    Variant productVarieants =
                        Variant(color: selectedColor, images: [
                      ''
                          ''
                          ''
                          ''
                          ''
                          ''
                    ], sizes: [
                      SizeModel(
                        size: 'XS',
                        price: (xsPriceController.text != '')
                            ? num.parse(priceController.text)
                            : priceController.text == ''
                                ? 0
                                : num.parse(priceController.text),
                        quantity: (xsController.text == ''
                            ? 0
                            : int.parse(xsController.text)),
                      ),
                      SizeModel(
                        size: 'S',
                        price: (sPriceController.text != '')
                            ? num.parse(sPriceController.text)
                            : priceController.text == ''
                                ? 0
                                : num.parse(sPriceController.text),
                        quantity: (sController.text == ''
                            ? 0
                            : int.parse(sController.text)),
                      ),
                      SizeModel(
                        size: 'M',
                        price: (mPriceController.text != '')
                            ? num.parse(mPriceController.text)
                            : priceController.text == ''
                                ? 0
                                : num.parse(mPriceController.text),
                        quantity: (mController.text == ''
                            ? 0
                            : int.parse(mController.text)),
                      ),
                      SizeModel(
                        size: 'L',
                        price: (lPriceController.text != '')
                            ? num.parse(lPriceController.text)
                            : priceController.text == ''
                                ? 0
                                : num.parse(lPriceController.text),
                        quantity: (lController.text == ''
                            ? 0
                            : int.parse(lController.text)),
                      ),
                      SizeModel(
                        size: 'XL',
                        price: (xlPriceController.text != '')
                            ? num.parse(xlPriceController.text)
                            : priceController.text == ''
                                ? 0
                                : num.parse(xlPriceController.text),
                        quantity: (xlController.text == ''
                            ? 0
                            : int.parse(xlController.text)),
                      ),
                      SizeModel(
                        size: 'XXL',
                        price: (xxlPriceController.text != '')
                            ? num.parse(xxlPriceController.text)
                            : priceController.text == ''
                                ? 0
                                : num.parse(xxlPriceController.text),
                        quantity: (xxlController.text == ''
                            ? 0
                            : int.parse(xxlController.text)),
                      ),
                      SizeModel(
                        size: 'XXXL',
                        price: (xxlPriceController.text != '')
                            ? num.parse(xxxlPriceController.text)
                            : priceController.text == ''
                                ? 0
                                : num.parse(xxxlPriceController.text),
                        quantity: (xxxlController.text == ''
                            ? 0
                            : int.parse(xxxlController.text)),
                      ),
                    ]);
                    var proVar;
                    for (var element in nonEditableVarients) {
                      if (selectedColor.toRadixString(16) == element.color) {
                        proVar = element;
                      }
                    }
                    nonEditableVarients.remove(proVar);
                    varients.add(productVarieants);
                    HiveStorage.set(HiveKeys.varients, varients);
                    nonEditableVarients.add(productVarieants);
                  }
                  isNonEditable[selectedIndex] = true;
                  isAdd = false;
                  isSubmit = false;
                  sizes = [
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
                isActivated: !isSubmit,
                text: upload,
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
      itemBuilder: (context, index) => isNonEditable[selectedIndex]
          ? sizeRowUnEditable(
              context,
              sizes[index]['size'],
              index == 0
                  ? xsPriceController
                  : index == 1
                      ? sPriceController
                      : index == 2
                          ? mPriceController
                          : index == 3
                              ? lPriceController
                              : index == 4
                                  ? xlPriceController
                                  : index == 5
                                      ? xxlPriceController
                                      : xxxlPriceController,
              index == 0
                  ? xsController
                  : index == 1
                      ? sController
                      : index == 2
                          ? mController
                          : index == 3
                              ? lController
                              : index == 4
                                  ? xlController
                                  : index == 5
                                      ? xxlController
                                      : xxxlController,
            )
          : sizeRow(
              context,
              sizes[index]['size'],
              () {
                sizes[index]['isEdit'] = true;
                setState(() {});
              },
              sizes[index]['isEdit'],
              index == 0
                  ? xsPriceController
                  : index == 1
                      ? sPriceController
                      : index == 2
                          ? mPriceController
                          : index == 3
                              ? lPriceController
                              : index == 4
                                  ? xlPriceController
                                  : index == 5
                                      ? xxlPriceController
                                      : xxxlPriceController,
              index == 0
                  ? xsController
                  : index == 1
                      ? sController
                      : index == 2
                          ? mController
                          : index == 3
                              ? lController
                              : index == 4
                                  ? xlController
                                  : index == 5
                                      ? xxlController
                                      : xxxlController,
            ),
      itemCount: sizes.length,
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
      TextEditingController quantityController) {
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
                  label: quantityController.text == ''
                      ? '0'
                      : quantityController.text,
                  controller: quantityController,
                  type: TextInputType.number,
                  textAlign: TextAlign.center,
                  height: 50,
                  disabledBorder:
                      const BorderSide(color: ColorManager.primaryB2),
                  width: screenWidth(context, 0.2),
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
                        height: 50,
                        disabledBorder: const BorderSide(
                          color: ColorManager.primaryB2,
                        ),
                        width: screenWidth(context, 0.15),
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
                                  : priceController.text == ''
                                      ? '0'
                                      : priceController.text,
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
      TextEditingController quantityController) {
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
                label: quantityController.text == ''
                    ? '0'
                    : quantityController.text,
                textAlign: TextAlign.center,
                height: 50,
                style: AppStylesManager.customTextStyleG2,
                disabledBorder: const BorderSide(color: ColorManager.primaryB2),
                width: screenWidth(context, 0.2),
              ),
              SizedBox(
                width: screenWidth(context, 0.15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      defaultPriceController.text != ''
                          ? defaultPriceController.text
                          : priceController.text == ''
                              ? '0'
                              : priceController.text,
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

  ViewAllRow updateDraft(String updateDraftStr) {
    return ViewAllRow(
      noText: true,
      style: AppStylesManager.customTextStyleBl5.copyWith(
        fontWeight: FontWeight.w500,
      ),
      buttonWidget: GestureDetector(
          onTap: () {
            if (HiveStorage.get(HiveKeys.productData) == null) {
              if (HiveStorage.get(HiveKeys.varients) == null) {
                List<Variant> varients = [];
                HiveStorage.set(
                  HiveKeys.productData,
                  <ProductData>[
                    ProductData(
                      product: ProductModel(
                        categoryID: widget.categoryName,
                        name: productNameController.text,
                        type: selectedValue.toString(),
                        description: productDescriptionController.text,
                        variants: varients,
                        sizeguide: '',
                        storeId: '',
                      ),
                      isEditable: generateIsEditableList(colors, isNonEditable),
                      productPrice: priceController.text, //[],
                    ),
                  ],
                );
                AppLogs.infoLog('check 1');
                HiveStorage.remove(HiveKeys.varients);
              } else {
                List<Variant> varients = [];
                varients = HiveStorage.get(HiveKeys.varients);
                HiveStorage.set(
                  HiveKeys.productData,
                  <ProductData>[
                    ProductData(
                      productPrice: priceController.text,
                      product: ProductModel(
                        categoryID: widget.categoryName,
                        name: productNameController.text,
                        type: selectedValue.toString(),
                        description: productDescriptionController.text,
                        variants: varients,
                        sizeguide: '',
                        storeId: '',
                      ),
                      isEditable: generateIsEditableList(colors, isNonEditable),
                    ),
                  ],
                );
                AppLogs.infoLog('check 2');
                HiveStorage.remove(HiveKeys.varients);
              }
            } else {
              if (HiveStorage.get(HiveKeys.varients) == null) {
                List<Variant> varients = [];
                List data = [];
                data = HiveStorage.get(HiveKeys.productData);
                data.remove(data[widget.selectionIndex]);
                data.add(
                  ProductData(
                    productPrice: priceController.text,
                    product: ProductModel(
                      categoryID: widget.categoryName,
                      name: productNameController.text,
                      type: selectedValue.toString(),
                      description: productDescriptionController.text,
                      variants: varients,
                      sizeguide: '',
                      storeId: JwtDecoder.decode(
                          HiveStorage.get<UserModel>(HiveKeys.userModel)
                              .token)['id'],
                    ),
                    isEditable: generateIsEditableList(colors, isNonEditable),
                  ),
                );
                HiveStorage.set(
                  HiveKeys.productData, data,
                  // <ProductData>[],
                );
                AppLogs.infoLog('check 3');
                HiveStorage.remove(HiveKeys.varients);
              } else {
                List<Variant> varients = [];
                varients = HiveStorage.get(HiveKeys.varients);
                List data = [];
                data = HiveStorage.get(HiveKeys.productData);
                data.remove(data[widget.selectionIndex]);
                data.add(ProductData(
                  productPrice: priceController.text,
                  product: ProductModel(
                    categoryID: widget.categoryName,
                    name: productNameController.text,
                    type: selectedValue.toString(),
                    description: productDescriptionController.text,
                    variants: varients,
                    sizeguide: '',
                    storeId: '',
                  ),
                  isEditable: generateIsEditableList(colors, isNonEditable),
                ));
                HiveStorage.set(
                  HiveKeys.productData,
                  data,
                );
                AppLogs.infoLog('check 4');
                HiveStorage.remove(HiveKeys.varients);
              }
            }
            AppLogs.infoLog('check 5');
            navigateAndReplace(context: context, screen: const DraftsView());
            // showToast('Saved As Draft');
          },
          child: Text(
            updateDraftStr,
            style: AppStylesManager.customTextStyleO,
          )),
    );
  }

  SizedBox colorRow() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        itemBuilder: (context, index) => colorCircle(() {
          selectedIndex = index;
          selectedColor = colors[selectedIndex];
          sizes = [
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
          for (var varieant in nonEditableVarients) {
            if (varieant.color.toLowerCase() ==
                selectedColor.toRadixString(16)) {
              if (varieant.sizes.isNotEmpty) {
                xsController =
                    TextEditingController(text: varieant.sizes[0].quantity);
                sController =
                    TextEditingController(text: varieant.sizes[1].quantity);
                mController =
                    TextEditingController(text: varieant.sizes[2].quantity);
                lController =
                    TextEditingController(text: varieant.sizes[3].quantity);
                xlController =
                    TextEditingController(text: varieant.sizes[4].quantity);
                xxlController =
                    TextEditingController(text: varieant.sizes[5].quantity);
                xxxlController =
                    TextEditingController(text: varieant.sizes[6].quantity);
                xsPriceController =
                    TextEditingController(text: varieant.sizes[0].price);
                sPriceController =
                    TextEditingController(text: varieant.sizes[1].price);
                mPriceController =
                    TextEditingController(text: varieant.sizes[2].price);
                lPriceController =
                    TextEditingController(text: varieant.sizes[3].price);
                xlPriceController =
                    TextEditingController(text: varieant.sizes[4].price);
                xxlPriceController =
                    TextEditingController(text: varieant.sizes[5].price);
                xxxlPriceController =
                    TextEditingController(text: varieant.sizes[6].price);
              }
            } else {
              xsController = TextEditingController(text: '0');
              sController = TextEditingController(text: '0');
              mController = TextEditingController(text: '0');
              lController = TextEditingController(text: '0');
              xlController = TextEditingController(text: '0');
              xxlController = TextEditingController(text: '0');
              xxxlController = TextEditingController(text: '0');
              xsPriceController =
                  TextEditingController(text: priceController.text);
              sPriceController =
                  TextEditingController(text: priceController.text);
              mPriceController =
                  TextEditingController(text: priceController.text);
              lPriceController =
                  TextEditingController(text: priceController.text);
              xlPriceController =
                  TextEditingController(text: priceController.text);
              xxlPriceController =
                  TextEditingController(text: priceController.text);
              xxxlPriceController =
                  TextEditingController(text: priceController.text);
            }
          }

          setState(() {});
        }, colors[index], selectedIndex, index, isNonEditable[index]),
        itemCount: colors.length,
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
          image == null
              ? addContainer(
                  () async {
                    image = await cameraDialog(context);
                    setState(() {});
                  },
                  context,
                  null,
                  null,
                )
              : imageContainer(
                  () async {
                    image = await cameraDialog(context);
                    setState(() {});
                  },
                  image!,
                  context,
                  null,
                  null,
                ),
          image1 == null
              ? addContainer(
                  () async {
                    image1 = await cameraDialog(context);
                    setState(() {});
                  },
                  context,
                  null,
                  null,
                )
              : imageContainer(
                  () async {
                    image1 = await cameraDialog(context);
                    setState(() {});
                  },
                  image1!,
                  context,
                  null,
                  null,
                ),
          image2 == null
              ? addContainer(
                  () async {
                    image2 = await cameraDialog(context);
                    setState(() {});
                  },
                  context,
                  null,
                  null,
                )
              : imageContainer(
                  () async {
                    image2 = await cameraDialog(context);
                    setState(() {});
                  },
                  image2!,
                  context,
                  null,
                  null,
                ),
          image3 == null
              ? addContainer(
                  () async {
                    image3 = await cameraDialog(context);
                    setState(() {});
                  },
                  context,
                  null,
                  null,
                )
              : imageContainer(
                  () async {
                    image3 = await cameraDialog(context);
                    setState(() {});
                  },
                  image3!,
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
      height: screenWidth(context, 0.21),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          image == null
              ? addContainer(
                  () {},
                  context,
                  null,
                  null,
                )
              : imageContainer(
                  () {},
                  image!,
                  context,
                  null,
                  null,
                ),
          image1 == null
              ? addContainer(
                  () {},
                  context,
                  null,
                  null,
                )
              : imageContainer(
                  () {},
                  image1!,
                  context,
                  null,
                  null,
                ),
          image2 == null
              ? addContainer(
                  () {},
                  context,
                  null,
                  null,
                )
              : imageContainer(
                  () {},
                  image2!,
                  context,
                  null,
                  null,
                ),
          image3 == null
              ? addContainer(
                  () {},
                  context,
                  null,
                  null,
                )
              : imageContainer(
                  () {},
                  image3!,
                  context,
                  null,
                  null,
                ),
        ],
      ),
    );
  }
}
