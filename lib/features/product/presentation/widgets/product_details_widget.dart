import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/features/product/domain/models/product_model.dart';
import 'package:nilelon/features/product/presentation/cubit/add_product/add_product_cubit.dart';
import 'package:nilelon/features/product/presentation/widgets/image_row.dart';

import 'package:nilelon/generated/l10n.dart';
import '../../../../core/resources/appstyles_manager.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/sizes_consts.dart';
import '../../domain/models/size_variant_controller.dart';
import 'color_selection_widget.dart';
import 'table_headers.dart';
import 'total_row.dart';
import 'variant_item_content.dart';

class ProductDetailsWidget extends StatefulWidget {
  const ProductDetailsWidget({
    super.key,
    required this.onTapAddButton,
    required this.onTapEditButton,
    required this.onTapDeleteButton,
    this.product,
    required this.cubit,
  });
  final VoidCallback onTapAddButton;
  final VoidCallback onTapEditButton;
  final VoidCallback onTapDeleteButton;
  final ProductModel? product;
  final AddProductCubit cubit;

  @override
  State<ProductDetailsWidget> createState() => _ProductDetailsWidgetState();
}

class _ProductDetailsWidgetState extends State<ProductDetailsWidget> {
  late final AddProductCubit cubit;
  @override
  void initState() {
    cubit = widget.cubit;

    if (widget.product != null) {
      cubit.initializeVarientsInEditMode(widget.product!);
    } else {
      cubit.sizes = SizeTypes.values
          .map(
            (e) => SizeController(
              size: e.name,
              isEdit: false,
              quantity: TextEditingController(),
              price: TextEditingController(),
            ),
          )
          .toList();
      log('init state', name: 'init test');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    return BlocBuilder<AddProductCubit, AddproductState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductColorsSelection(
              onTap: (index) {
                cubit.onSelectedColor(index);
                setState(() {});
              },
            ),
            if (cubit.isVarientAdded[cubit.selectedColor]!)
              _buildEditListTile(
                lang.editSizesForThisColor,
                lang.areYouSureYouWantToDeleteAllSizesForThisColor,
              )
            else
              _buildAddButton(lang.addSizesForThisColor),
            _buildSizeVariantSection(lang),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                lang.pressSubmitToConfirmOnlyThisColorDetailsAndUploadForAllColorsDetails,
                style: AppStylesManager.customTextStyleG17,
              ),
            ),
            SizedBox(height: 20.h),
          ],
        );
      },
    );
  }

  Widget _buildSizeVariantSection(S lang) {
    if (cubit.isVarientAdded[cubit.selectedColor]! || !cubit.isVarientActive) {
      return _buildDisabledVarient(lang.total);
    } else {
      return _buildEditableVariantSection(lang.total);
    }
  }

  Widget _buildAddButton(String addSizes) {
    return Visibility(
      visible: !cubit.isVarientActive,
      child: InkWell(
        onTap: widget.onTapAddButton,
        child: Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(Iconsax.edit_2, size: 22.r),
              SizedBox(width: 8.w),
              Text(addSizes, style: AppStylesManager.customTextStyleB),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditListTile(String editSizes, String deleteAlertStr) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          InkWell(onTap: widget.onTapEditButton, child: _buildEditBtn()),
          SizedBox(width: 8.w),
          InkWell(
              onTap: widget.onTapEditButton,
              child: Text(editSizes, style: AppStylesManager.customTextStyleB)),
          const Spacer(),
          _buildDeleteBtn(deleteAlertStr),
        ],
      ),
    );
  }

  Widget _buildDisabledVarient(String total) {
    return Stack(
      children: [
        _buildEditableVariantSection(total),
        Container(
          width: double.infinity,
          height: 1.sw > 600 ? 1000 : 800,
          color: ColorManager.primaryG.withOpacity(0.6),
        ),
      ],
    );
  }

  Widget _buildEditableVariantSection(String total) {
    return BlocBuilder<AddProductCubit, AddproductState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.sp),
          child: Column(
            children: [
              const ImageRow(),
              Visibility(
                visible: cubit.images.isEmpty,
                child: Text(
                  S.of(context).youMustSelectOneImage,
                  style: AppStylesManager.customTextStyleR,
                ),
              ),
              SizedBox(height: 40.h),
              const TableHeaders(),
              VariantItems(onChange: () {
                cubit.calculateTotalSizes();
                setState(() {});
              }),
              totalRow(context, cubit.calculateTotalSizes(), total),
              SizedBox(height: 24.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEditBtn() {
    return const Icon(Iconsax.edit_2, size: 22);
  }

  Widget _buildDeleteBtn(String deleteAlertStr) {
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
}
