import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/features/product/presentation/cubit/add_product/add_product_cubit.dart';
import 'package:nilelon/features/product/presentation/widgets/size_container.dart';

import 'package:nilelon/generated/l10n.dart';
import '../../../../core/resources/appstyles_manager.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/sizes_consts.dart';
import '../../../../core/widgets/pop_ups/camera_popup.dart';
import '../../../../core/widgets/text_form_field/text_field/text_form_field_builder.dart';
import 'add_container.dart';
import 'color_selection_widget.dart';
import 'image_container.dart';
import 'table_headers.dart';
import 'total_row.dart';

class ProductDetailsWidget extends StatefulWidget {
  const ProductDetailsWidget(
      {super.key,
      required this.onTapAddButton,
      required this.onTapEditButton,
      required this.onTapDeleteButton});
  final VoidCallback onTapAddButton;
  final VoidCallback onTapEditButton;
  final VoidCallback onTapDeleteButton;

  @override
  State<ProductDetailsWidget> createState() => _ProductDetailsWidgetState();
}

class _ProductDetailsWidgetState extends State<ProductDetailsWidget> {
  late final AddProductCubit cubit;
  @override
  void initState() {
    cubit = AddProductCubit.get(context);
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductColorsSelection(
          onTap: (index) {
            cubit.onSelectedColor(index);
            setState(() {});
          },
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

  Widget _buildDisabledVariantSection(String total) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      child: SizedBox(
        height: 1.sw > 600 ? 1000 : 770,
        child: Column(
          children: [
            SizedBox(height: 10.h),
            _buildDisabledImages(),
            SizedBox(height: 28.h),
            const TableHeaders(),
            _buildSizeListView(),
            totalRow(context, cubit.calculateTotalSizes(), total),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildEditIcon() {
    return GestureDetector(
      onTap: widget.onTapEditButton,
      child: const Icon(Iconsax.edit_2, size: 22),
    );
  }

  Widget _buildDeleteIcon(String deleteAlertStr) {
    return GestureDetector(
      onTap: widget.onTapDeleteButton,
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

  Widget _buildAmountTextField(TextEditingController amountController) {
    return TextFormFieldBuilder(
      label: amountController.text.isEmpty
          ? amountController.text
          : amountController.text,
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
                    if (cubit.isVarientActive) {
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

  Widget _buildDisabledImages() {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          addContainer(() async {
            if (cubit.isVarientActive) {
              cubit.images.add((await cameraDialog(context)));

              setState(() {});
            }
          }, context, null, null),
          addContainer(() async {
            if (cubit.isVarientActive) {
              cubit.images.add((await cameraDialog(context)));

              setState(() {});
            }
          }, context, null, null),
          addContainer(() async {
            if (cubit.isVarientActive) {
              cubit.images.add((await cameraDialog(context)));

              setState(() {});
            }
          }, context, null, null),
          addContainer(() async {
            if (cubit.isVarientActive) {
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
      cubit.images[index].path,
      context,
      null,
      null,
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

  Widget _buildSizeRowContent(int index, bool isEditable) {
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
          _buildAmountTextField(cubit.sizes[index]['quantityController']),
          isEditable
              ? _buildPriceTextField(cubit.sizes[index]['priceController'])
              : _buildPriceText(index, cubit.sizes[index]['priceController']),
        ],
      ),
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

  Widget _buildDisabledSizeRow(int index) {
    return Column(
      children: [
        _buildSizeRowContent(index, false),
      ],
    );
  }

  Widget _buildSizeListView() {
    return ListView.builder(
      itemCount: cubit.sizes.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        bool isNonEditable = cubit.isVarientAdded[cubit.selectedIndex];

        return isNonEditable
            ? _buildDisabledSizeRow(index)
            : _buildSizeRow(index);
      },
    );
  }

  Widget _buildAddButton(String addSizes) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: widget.onTapAddButton,
            child: Icon(Iconsax.edit_2, size: 22.r),
          ),
          SizedBox(width: 8.w),
          Text(addSizes, style: AppStylesManager.customTextStyleB),
          const Spacer(),
        ],
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

  Widget _buildEditableVariantSection(String total) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      child: Column(
        children: [
          _buildImageRow(),
          Visibility(
            visible: cubit.images.isEmpty,
            child: Text(
              S.of(context).youMustSelectOneImage,
              style: AppStylesManager.customTextStyleR,
            ),
          ),
          SizedBox(height: 40.h),
          const TableHeaders(),
          _buildSizeListView(),
          totalRow(context, cubit.calculateTotalSizes(), total),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildDisabledVarient(String total) {
    return Stack(
      children: [
        _buildDisabledVariantSection(total),
        Container(
          width: double.infinity,
          height: 1.sw > 600 ? 1000 : 770,
          color: ColorManager.primaryG.withOpacity(0.6),
        ),
      ],
    );
  }

  Widget _buildSizeVariantSection(S lang) {
    return cubit.isVarientAdded[cubit.selectedIndex]
        ? Column(
            children: [
              _buildEditRow(lang.editSizesForThisColor,
                  lang.areYouSureYouWantToDeleteAllSizesForThisColor),
              _buildDisabledVarient(lang.total),
            ],
          )
        : cubit.isVarientActive
            ? _buildEditableVariantSection(lang.total)
            : Column(
                children: [
                  _buildAddButton(lang.addSizesForThisColor),
                  _buildDisabledVarient(lang.total),
                ],
              );
  }
}
