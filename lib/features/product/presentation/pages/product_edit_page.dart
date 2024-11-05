import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/alert/draft_alert.dart';
import 'package:nilelon/core/widgets/button/button_builder.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/drop_down_menu/drop_down_menu.dart';
import 'package:nilelon/core/widgets/pop_ups/camera_popup.dart';
import 'package:nilelon/core/widgets/text_form_field/text_and_form_field_column/without_icon/text_and_form_field_column_no_icon.dart';
import 'package:nilelon/core/widgets/view_all_row/view_all_row.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/features/product/domain/models/product_model.dart';
import 'package:nilelon/features/product/presentation/widgets/add_container.dart';
import 'package:nilelon/features/product/presentation/widgets/image_container.dart';
import 'package:nilelon/features/product/presentation/widgets/product_details_widget.dart';

import '../../../../core/widgets/scaffold_image.dart';
import '../cubit/add_product/add_product_cubit.dart';

class EditProductpage extends StatefulWidget {
  const EditProductpage({super.key, required this.product});
  final ProductModel product;

  @override
  State<EditProductpage> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<EditProductpage> {
  late final AddProductCubit cubit;

  @override
  void dispose() {
    HiveStorage.set(HiveKeys.tempVarients, null);
    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();

    cubit = AddProductCubit.get(context);

    cubit.isEdit = true;
    cubit.productEdit = widget.product;
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return BlocListener<AddProductCubit, AddproductState>(
      listener: (context, state) {
        state.mapOrNull(loading: (value) {
          BotToast.showLoading();
        }, success: (v) {
          BotToast.closeAllLoading();
        }, failure: (r) {
          BotToast.closeAllLoading();
          BotToast.showText(text: r.message);
        });
      },
      child: ScaffoldImage(
        appBar: customAppBar(
          title: lang.editProduct,
          context: context,
          hasIcon: false,
        ),
        body: Form(
          key: cubit.globalKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DefaultDivider(),
                SizedBox(height: 24.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.sp),
                  child: _buildProductForm(lang),
                ),
                ProductDetailsWidget(
                  cubit: cubit,
                  product: widget.product,
                  onTapAddButton: () {
                    cubit.activateVariant();
                    setState(() {});
                  },
                  onTapEditButton: () {
                    cubit.editVariant();
                    setState(() {});
                  },
                  onTapDeleteButton: () {
                    cubit.deleteVariant();
                    setState(() {});
                  },
                ),
                _buildSubmitSection(lang),
              ],
            ),
          ),
        ),
      ),
    );
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
          validator: (value) {
            if (value!.isEmpty) {
              return lang.enterProductName;
            }
            return null;
          },
          controller: cubit.productNameC,
          type: TextInputType.text,
          height: 30.h,
        ),
        SizedBox(height: 16.h),
        TextAndFormFieldColumnNoIcon(
          title: lang.productDescription,
          label: lang.enterProductDescription,
          controller: cubit.productDesC,
          type: TextInputType.text,
          validator: (value) {
            if (value!.isEmpty) {
              return lang.enterProductName;
            }
            return null;
          },
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
          validator: (value) {
            if (value!.isEmpty) {
              return lang.enterProductName;
            }
            return null;
          },
          controller: cubit.priceC,
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
          selectedValue: cubit.productType,
          items: cubit.items,
          context: context,
          onChanged: (gender) {
            cubit.productType = gender;
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
        cubit.sizeGuideImage.path.isEmpty || cubit.sizeGuideImage.path.isEmpty
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
                cubit.sizeGuideImage.path.isEmpty
                    ? widget.product.sizeguide
                    : cubit.sizeGuideImage.path,
                context,
                screenWidth(context, 0.3),
                screenWidth(context, 0.3),
              ),
        SizedBox(height: 30.h),
      ],
    );
  }

  Widget _buildSubmitSection(S lang) {
    return _buildButtonRow(lang.submit, lang.editProduct);
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
      isActivated:
          cubit.isNotFirstTimeActivated ? cubit.isSubmit : !cubit.isSubmit,
      ontap: () {
        if (cubit.isEdit) {
          cubit.updateVariant(widget.product);
        } else {
          cubit.handleSubmit();
        }
        setState(() {});
      },
    );
  }

  Widget _buildUploadButton(String uploadStr) {
    return GradientButtonBuilder(
      isActivated: !cubit.isSubmit,
      text: uploadStr,
      ontap: () {
        // AppLogs.infoLog(HiveStorage.get(HiveKeys.varients).toString());
        cubit.updateProduct(widget.product);
        // navigatePop(context: context);
      },
    );
  }
}
