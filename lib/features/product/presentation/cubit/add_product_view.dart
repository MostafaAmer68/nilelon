import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
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

import '../../../../core/helper.dart';
import '../../../../core/sizes_consts.dart';
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
    super.initState();

    cubit = AddproductCubit.get(context);
    cubit.sizes = SizeTypes.values
        .map(
          (e) => {
            'size': e.name,
            'isEdit': false,
            'quantityController': TextEditingController(),
            'priceController': TextEditingController(),
          },
        )
        .toList();
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DefaultDivider(),
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              child: _buildAddToDraft(lang.addToDraft),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              child: _buildProductForm(lang),
            ),
            _buildProductDetailsSection(lang),
            _buildSubmitSection(lang),
          ],
        ),
      ),
    );
  }

  Widget _buildAddToDraft(String addToDraft) {
    return addToDraftWidget(addToDraft);
  }

  Widget addToDraftWidget(String addToDraft) {
    return ViewAllRow(
      noText: true,
      style: AppStylesManager.customTextStyleBl5.copyWith(
        fontWeight: FontWeight.w500,
      ),
      buttonWidget: GestureDetector(
        onTap: () {
          draftAlert(context, () {
            navigatePop(context: context);

            // Draft saving logic goes here

            navigatePop(context: context);
            // showToast('Saved As Draft');
          });
        },
        child: Text(
          addToDraft,
          style: AppStylesManager.customTextStyleO,
        ),
      ),
    );
  }

  //product form
  Widget _buildProductForm(S lang) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextAndFormFieldColumnNoIcon(
          title: lang.productName,
          label: lang.enterProductName,
          controller: cubit.productNameController,
          type: TextInputType.text,
          height: 30.h,
        ),
        SizedBox(height: 16.h),
        TextAndFormFieldColumnNoIcon(
          title: lang.productDescription,
          label: lang.enterProductDescription,
          controller: cubit.productDescriptionController,
          type: TextInputType.text,
          height: 30.h,
          maxlines: false,
          fieldHeight: 170,
        ),
        SizedBox(height: 16.h),
        _buildProductTypeDropdown(lang),
        SizedBox(height: 16.h),
        TextAndFormFieldColumnNoIcon(
          title: lang.productPrice,
          label: lang.enterProductPrice,
          controller: cubit.priceController,
          type: TextInputType.number,
          height: 30.h,
        ),
        SizedBox(height: 16.h),
        _buildSizeGuideImageSection(lang),
      ],
    );
  }

  Widget _buildProductTypeDropdown(S lang) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(lang.type, style: AppStylesManager.customTextStyleBl5),
        SizedBox(height: 12.h),
        dropDownMenu(
          hint: lang.selectType,
          selectedValue: cubit.selectedValue,
          items: cubit.items,
          context: context,
          onChanged: (gender) {
            cubit.selectedValue = gender;
            setState(() {});
          },
        ),
        SizedBox(height: 30.h),
      ],
    );
  }

  // size guid image
  Widget _buildSizeGuideImageSection(S lang) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(lang.sizeGuide, style: AppStylesManager.customTextStyleBl5),
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
                    cubit.sizeGuideImage,
                    context,
                    screenWidth(context, 0.3),
                    screenWidth(context, 0.3),
                  ),
          ],
        ),
        SizedBox(height: 30.h),
      ],
    );
  }

  Widget _buildProductDetailsSection(S lang) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.sp),
          child: _buildProductColorSection(lang.productColors),
        ),
        _buildSizeVariantSection(lang),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            lang.pressSubmitToConfirmOnlyThisColorDetailsAndUploadForAllColorsDetails,
            style: AppStylesManager.customTextStyleG17,
          ),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }

  Widget _buildProductColorSection(String productColors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(productColors, style: AppStylesManager.customTextStyleBl5),
        SizedBox(height: 12.h),
        _buildColorRow(),
        SizedBox(height: 40.h),
      ],
    );
  }

  Widget _buildSizeVariantSection(S lang) {
    return cubit.isNonEditable[cubit.selectedIndex]
        ? Column(
            children: [
              _buildEditRow(lang.editSizesForThisColor,
                  lang.areYouSureYouWantToDeleteAllSizesForThisColor),
              _buildNonEditableStack(lang.total),
            ],
          )
        : cubit.isAdd
            ? _buildEditableVariantSection(lang.total)
            : Column(
                children: [
                  _buildAddRow(lang.addSizesForThisColor),
                  _buildNonEditableStack(lang.total),
                ],
              );
  }

  Widget _buildSubmitSection(S lang) {
    return _buildButtonRow(lang.submit, lang.upload);
  }

  Widget _buildColorRow() {
    return SizedBox(
      height: 40.h,
      child: ListView.builder(
        itemCount: cubit.colors.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => colorCircle(
          () {
            cubit.selectedIndex = index;
            cubit.selectedColor = cubit.colors[cubit.selectedIndex];

            _initializeSihzeControllers();
            if (!cubit.isNonEditable[cubit.selectedIndex]) {
              cubit.isSubmit = false;
              cubit.isAdd = false;
            } else {
              cubit.isAdd = true;
              cubit.isSubmit = true;
            }
            setState(() {});
          },
          cubit.colors[index],
          cubit.selectedIndex,
          index,
          cubit.isNonEditable[index],
        ),
      ),
    );
  }

  void _initializeSihzeControllers() {
    cubit.sizes = SizeTypes.values
        .map(
          (e) => {
            'size': e.name,
            'isEdit': false,
            'quantityController': TextEditingController(),
            'priceController': TextEditingController(),
          },
        )
        .toList();
    for (var variant in cubit.nonEditableVarients) {
      if (variant.color == cubit.selectedColor) {
        if (variant.sizes.isNotEmpty) {
          for (var item in variant.sizes) {
            for (var itemSize in cubit.sizes) {
              itemSize['quantityController'] =
                  TextEditingController(text: item.quantity.toString());
              itemSize['priceController'] =
                  TextEditingController(text: item.price.toString());
            }
          }
        }
      } else {
        _resetSizeControllers();
      }
    }
  }

  void _resetSizeControllers() {
    for (var item in cubit.sizes) {
      item['quantityController'] = TextEditingController(text: '0');
      item['priceController'] =
          TextEditingController(text: cubit.priceController.text);
    }
  }

  Widget _buildEditableVariantSection(String total) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      child: Column(
        children: [
          _buildImageRow(),
          SizedBox(height: 40.h),
          const TableHeaders(),
          _buildSizeListView(),
          totalRow(context, _calculateTotalSizes(), total),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildNonEditableStack(String total) {
    return Stack(
      children: [
        _buildNonEditableVariantSection(total),
        Container(
          width: double.infinity,
          height: 1.sw > 600 ? 1000 : 770,
          color: ColorManager.primaryG.withOpacity(0.6),
        ),
      ],
    );
  }

  Widget _buildNonEditableVariantSection(String total) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      child: SizedBox(
        height: 1.sw > 600 ? 1000 : 770,
        child: Column(
          children: [
            SizedBox(height: 10.h),
            _buildImageRowUnEditable(),
            SizedBox(height: 40.h),
            const TableHeaders(),
            _buildSizeListView(),
            totalRow(context, _calculateTotalSizes(), total),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildEditRow(String editSizes, String deleteAlertStr) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildEditIcon(),
          SizedBox(width: 8.w),
          Text(editSizes, style: AppStylesManager.customTextStyleB),
          const Spacer(),
          _buildDeleteIcon(deleteAlertStr),
        ],
      ),
    );
  }

  Widget _buildEditIcon() {
    return GestureDetector(
      onTap: () {
        cubit.isAdd = true;
        cubit.isSubmit = true;
        cubit.isNonEditable[cubit.selectedIndex] = false;
        _removeNonEditableVariant();
        setState(() {});
      },
      child: const Icon(Iconsax.edit_2, size: 22),
    );
  }

  void _removeNonEditableVariant() {
    for (var element in cubit.nonEditableVarients) {
      if (cubit.selectedColor == element.color) {
        List varients = HiveStorage.get(HiveKeys.varients);
        varients.remove(element);
        HiveStorage.set(HiveKeys.varients, varients);
      }
    }
  }

  Widget _buildDeleteIcon(String deleteAlertStr) {
    return GestureDetector(
      onTap: () {
        deleteAlert(context, deleteAlertStr, () {
          cubit.isNonEditable[cubit.selectedIndex] = false;
          _deleteVariant();
          navigatePop(context: context);
          setState(() {});
        });
      },
      child: Container(
        padding: EdgeInsets.all(4.sp),
        decoration: BoxDecoration(
          color: ColorManager.primaryO,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(Iconsax.trash, color: ColorManager.primaryW, size: 18.r),
      ),
    );
  }

  void _deleteVariant() {
    Variant? proVar;
    List varients = HiveStorage.get(HiveKeys.varients);
    for (var element in cubit.nonEditableVarients) {
      if (cubit.selectedColor == element.color) {
        proVar = element;
      }
    }
    cubit.nonEditableVarients.remove(proVar);
    varients.remove(proVar);
    HiveStorage.set(HiveKeys.varients, varients);
    _resetSizeControllers();

    if (cubit.nonEditableVarients.isEmpty) {
      cubit.isActivated = false;
      cubit.isSubmit = true;
    }
  }

  Widget _buildAddRow(String addSizes) {
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
            child: Icon(Iconsax.edit_2, size: 22.r),
          ),
          SizedBox(width: 8.w),
          Text(addSizes, style: AppStylesManager.customTextStyleB),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildButtonRow(String submitStr, String uploadStr) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildSubmitButton(submitStr),
            _buildUploadButton(uploadStr),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton(String submitStr) {
    return ButtonBuilder(
      text: submitStr,
      isActivated: cubit.isActivated ? cubit.isSubmit : !cubit.isSubmit,
      ontap: _handleSubmit,
    );
  }

  Widget _buildUploadButton(String uploadStr) {
    return GradientButtonBuilder(
      isActivated: !cubit.isSubmit,
      text: uploadStr,
      ontap: () {
        AppLogs.infoLog(HiveStorage.get(HiveKeys.varients).toString());
        navigatePop(context: context);
      },
    );
  }

  void _handleSubmit() {
    if (HiveStorage.get(HiveKeys.varients) == null) {
      _saveNewVariant();
    } else {
      _updateExistingVariant();
    }
    cubit.isNonEditable[cubit.selectedIndex] = true;
    cubit.isAdd = false;
    cubit.isSubmit = false;
    _resetSizeControllersToDefault();
    setState(() {});
    AppLogs.infoLog(HiveStorage.get(HiveKeys.varients).toString());
  }

  void _saveNewVariant() {
    Variant productVarieants = _createProductVariant();
    cubit.nonEditableVarients.removeWhere(
        (element) => element == cubit.selectedColor.toRadixString(16));
    HiveStorage.set(HiveKeys.varients, <Variant>[productVarieants]);
    cubit.nonEditableVarients.add(productVarieants);
  }

  void _updateExistingVariant() {
    List varients = HiveStorage.get(HiveKeys.varients);
    Variant productVarieants = _createProductVariant();
    cubit.nonEditableVarients
        .removeWhere((element) => element.color == cubit.selectedColor);
    varients.add(productVarieants);
    HiveStorage.set(HiveKeys.varients, varients);
    cubit.nonEditableVarients.add(productVarieants);
  }

  Variant _createProductVariant() {
    final Completer<String> image = Completer();
    List<String> images = [];
    for (var img in cubit.images) {
      convertImageToBase64(img).then((value) async {
        image.complete(value);
        images.add((await image.future));
      });
    }
    return Variant(
      color: cubit.selectedColor,
      images: images,
      sizes: List<SizeModel>.from(
        cubit.sizes.map(
          (e) => SizeModel(
            size: e['size'],
            price: num.parse(e['priceController'].text.isEmpty
                ? '0'
                : e['priceController'].text),
            quantity: int.parse(e['quantityController'].text.isEmpty
                ? '0'
                : e['quantityController'].text),
          ),
        ),
      ).toList(),
    );
  }

  void _resetSizeControllersToDefault() {
    cubit.sizes = SizeTypes.values
        .map(
          (e) => {
            'size': e.name,
            'isEdit': false,
            'quantityController': TextEditingController(),
            'priceController': TextEditingController(),
          },
        )
        .toList();
  }

  Widget _buildSizeListView() {
    return ListView.builder(
      itemCount: cubit.sizes.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        bool isNonEditable = cubit.isNonEditable[cubit.selectedIndex];
        return isNonEditable
            ? _buildSizeRowUnEditable(index)
            : _buildSizeRow(index);
      },
    );
  }

  Widget _buildSizeRow(int index) {
    return GestureDetector(
      onTap: () {
        cubit.sizes[index]['isEdit'] = true;
        setState(() {});
      },
      child: Column(
        children: [
          _buildSizeRowContent(index, cubit.sizes[index]['isEdit']),
        ],
      ),
    );
  }

  Widget _buildSizeRowUnEditable(int index) {
    return Column(
      children: [
        _buildSizeRowContent(index, false),
      ],
    );
  }

  Widget _buildSizeRowContent(int index, bool isEditable) {
    TextEditingController quantityController =
        cubit.sizes[index]['quantityController'];
    TextEditingController priceController =
        cubit.sizes[index]['priceController'];

    return Padding(
      padding: const EdgeInsets.only(
        top: 16,
        left: 30,
        right: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          sizeContainer(context, cubit.sizes[index]['size'] as String),
          _buildAmountTextField(quantityController),
          isEditable
              ? _buildPriceTextField(priceController)
              : _buildPriceText(index, priceController),
        ],
      ),
    );
  }

  // TextEditingController _getQuantityController(int index) {
  //   switch (index) {
  //     case 0:
  //       return cubit.xsController;
  //     case 1:
  //       return cubit.sController;
  //     case 2:
  //       return cubit.mController;
  //     case 3:
  //       return cubit.lController;
  //     case 4:
  //       return cubit.xlController;
  //     case 5:
  //       return cubit.xxlController;
  //     case 6:
  //       return cubit.xxxlController;
  //     default:
  //       return TextEditingController();
  //   }
  // }

  // TextEditingController _getPriceController(int index) {
  //   switch (index) {
  //     case 0:
  //       return cubit.xsPriceController;
  //     case 1:
  //       return cubit.sPriceController;
  //     case 2:
  //       return cubit.mPriceController;
  //     case 3:
  //       return cubit.lPriceController;
  //     case 4:
  //       return cubit.xlPriceController;
  //     case 5:
  //       return cubit.xxlPriceController;
  //     case 6:
  //       return cubit.xxxlPriceController;
  //     default:
  //       return TextEditingController();
  //   }
  // }

  Widget _buildAmountTextField(TextEditingController amountController) {
    return TextFormFieldBuilder(
      label: amountController.text.isEmpty ? '0' : amountController.text,
      controller: amountController,
      type: TextInputType.number,
      textAlign: TextAlign.center,
      height: 46.h,
      disabledBorder: const BorderSide(color: ColorManager.primaryB2),
      width: 1.sw > 600 ? screenWidth(context, 0.4) : screenWidth(context, 0.2),
      noIcon: true,
    );
  }

  Widget _buildPriceTextField(TextEditingController priceController) {
    return TextFormFieldBuilder(
      label: priceController.text.isEmpty ? '0' : priceController.text,
      controller: priceController,
      type: TextInputType.number,
      textAlign: TextAlign.center,
      height: 46.h,
      disabledBorder: const BorderSide(color: ColorManager.primaryB2),
      width:
          1.sw > 600 ? screenWidth(context, 0.15) : screenWidth(context, 0.3),
      noIcon: true,
    );
  }

  Widget _buildPriceText(int index, TextEditingController priceController) {
    return SizedBox(
      width: screenWidth(context, 0.15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            priceController.text.isNotEmpty
                ? priceController.text
                : cubit.priceController.text.isEmpty
                    ? '0'
                    : cubit.priceController.text,
            style: AppStylesManager.customTextStyleO3,
          ),
          SizedBox(width: 4.w),
          const Icon(Iconsax.edit_2, color: ColorManager.primaryG, size: 20),
        ],
      ),
    );
  }

  Widget _buildImageRow() {
    return SizedBox(
      height: screenWidth(context, 0.21),
      width: screenWidth(context, 1),
      child: ListView.builder(
        itemCount: cubit.images.length + 1,
        itemBuilder: (context, index) {
          return index == cubit.images.length
              ? addContainer(
                  () async {
                    if (cubit.isAdd) {
                      cubit.images.add((await cameraDialog(context)));

                      setState(() {});
                    }
                  },
                  context,
                  null,
                  null,
                )
              : _buildImageContainer(index);
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget _buildImageRowUnEditable() {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          addContainer(() async {
            if (cubit.isAdd) {
              cubit.images.add((await cameraDialog(context)));

              setState(() {});
            }
          }, context, null, null),
          addContainer(() async {
            if (cubit.isAdd) {
              cubit.images.add((await cameraDialog(context)));

              setState(() {});
            }
          }, context, null, null),
          addContainer(() async {
            if (cubit.isAdd) {
              cubit.images.add((await cameraDialog(context)));

              setState(() {});
            }
          }, context, null, null),
          addContainer(() async {
            if (cubit.isAdd) {
              cubit.images.add((await cameraDialog(context)));

              setState(() {});
            }
          }, context, null, null),
        ],
      ),
    );
  }

  Widget _buildImageContainer(index, {bool isEditable = true}) {
    return imageContainer(
      () async {
        if (isEditable) {
          cubit.images[index] = (await cameraDialog(context));
          setState(() {});
        }
      },
      cubit.images[index],
      context,
      null,
      null,
    );
  }

  int _calculateTotalSizes() {
    return cubit.sizes
        .map((e) => (e['quantityController'] as TextEditingController).text)
        .fold(0, (sum, controller) => sum + (int.tryParse(controller) ?? 0));
  }
}
