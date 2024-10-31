import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/resources/appstyles_manager.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/const_functions.dart';
import '../../../../core/widgets/text_form_field/text_field/text_form_field_builder.dart';
import '../cubit/add_product/add_product_cubit.dart';
import 'size_container.dart';

class VariantItems extends StatefulWidget {
  const VariantItems({
    super.key,
  });

  @override
  State<VariantItems> createState() => _VariantItemsState();
}

class _VariantItemsState extends State<VariantItems> {
  late final AddProductCubit cubit;

  @override
  void initState() {
    cubit = AddProductCubit.get(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cubit.sizes.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        bool isNonEditable = cubit.isVarientAdded[cubit.selectedColor]!;

        if (isNonEditable) {
          return _variantItem(index: index, isEditable: false);
        } else {
          return _variantItem(
            index: index,
            isEditable: cubit.sizes[index].isEdit,
          );
        }
      },
    );
  }

  Widget _variantItem({required int index, required bool isEditable}) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16,
        left: 20,
        right: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          sizeContainer(context, cubit.sizes[index].size),
          _buildQuantityTextField(cubit.sizes[index].quantity),
          if (isEditable)
            _buildPriceTextField(cubit.sizes[index].price)
          else
            _buildPriceText(index, cubit.sizes[index].price),
        ],
      ),
    );
  }

  Widget _buildPriceText(int index, TextEditingController priceController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          priceController.text.isNotEmpty
              ? priceController.text
              : cubit.priceC.text.isEmpty
                  ? '0'
                  : cubit.priceC.text,
          style: AppStylesManager.customTextStyleO3,
        ),
        IconButton(
          onPressed: () {
            cubit.sizes[index] = cubit.sizes[index].copyWith(isEdit: true);
            setState(() {});
          },
          icon: const Icon(Iconsax.edit_2,
              color: ColorManager.primaryG, size: 20),
        ),
      ],
    );
  }

  Widget _buildQuantityTextField(TextEditingController amountController) {
    return TextFormFieldBuilder(
      label: amountController.text,
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
}
