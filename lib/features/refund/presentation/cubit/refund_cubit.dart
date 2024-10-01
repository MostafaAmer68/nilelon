import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/pop_ups/camera_popup.dart';
import 'package:nilelon/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:nilelon/features/product/domain/models/product_model.dart';
import 'package:nilelon/features/refund/data/models/create_ret_missing_model.dart';
import 'package:nilelon/features/refund/data/models/refund_model.dart';
import 'package:nilelon/features/refund/data/repositories/refund_repo_impl.dart';

part 'refund_state.dart';

class RefundCubit extends Cubit<RefundState> {
  final RefundRepoImpl _refund;
  RefundCubit(this._refund) : super(RefundInitial());
  List<RefundModel> refunds = [];
  List<String>sizes = ['XSmall','Small','Medium','Large','XLarge','XXLarge','XXXLarge'];
  String orderId = '';
  List<ProductModel> selectedProducts = [];
  String? selectedValue;
  String? wrongSelectedValue;
  String selectedColor='0xFFD80000';
  String selectedSize='XSmall';
  File? image1;
  File? image2;
  File? image3;
  Future<File> cameraDialog(BuildContext context) async {
    Completer<File> completer = Completer<File>();

    await showCupertinoModalPopup<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is PickImageSuccess) {
              navigatePop(context: context);
            }
          },
          child: SizedBox(
            width: screenWidth(context, 0.95),
            child: CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                  onPressed: () async {
                    // AuthCubit.get(context).pickImage(ImageSource.camera);
                    File? image = await pickImage(ImageSource.camera);
                    completer.complete(image);
                    navigatePop(context: context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.camera_alt_outlined,
                        color: ColorManager.primaryB2,
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Text(
                        'Camera',
                        style: AppStylesManager.customTextStyleB4,
                      ),
                    ],
                  ),
                ),
                CupertinoActionSheetAction(
                  onPressed: () async {
                    // AuthCubit.get(context).pickImage(ImageSource.gallery);
                    File? image = await pickImage(ImageSource.gallery);
                    completer.complete(image);
                    navigatePop(context: context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.file_upload_outlined,
                        color: ColorManager.primaryB2,
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Text(
                        'Upload From Gallery',
                        style: AppStylesManager.customTextStyleB4,
                      ),
                    ],
                  ),
                ),
              ],
              cancelButton: CupertinoActionSheetAction(
                onPressed: () {
                  completer.complete(File(''));
                  navigatePop(context: context);
                },
                child: Text(
                  'Cancel',
                  style: AppStylesManager.customTextStyleB4,
                ),
              ),
            ),
          ),
        );
      },
    );

    return completer.future;
  }

  Future<void> createRetMissingItem() async {
    emit(RefundLoading());
    if (selectedProducts.length == 1) {
      final selectedProduct = selectedProducts.first;
      final result = await _refund.createRetMissingItem(CreateRetMissingModel(
        orderId,
        selectedProduct.id,
        selectedProduct.productVariants.first.size,
        selectedProduct.productVariants.first.color,
        '',
      ));

      result.fold(
        (err) {
          emit(RefundFailure(err.errorMsg));
        },
        (result) {
          // refunds = result;
          emit(RefundSuccess());
        },
      );
    } else {
      for (var item in selectedProducts) {
        final result = await _refund.createRetMissingItem(CreateRetMissingModel(
          orderId,
          item.id,
          item.productVariants.first.size,
          item.productVariants.first.color,
          '',
        ));

        result.fold(
          (err) {
            emit(RefundFailure(err.errorMsg));
          },
          (result) {
            // refunds = result;
            emit(RefundSuccess());
          },
        );
      }
    }
  }

  Future<void> getRefunds() async {
    emit(RefundLoading());
    final result = await _refund.getRefunds();

    result.fold(
      (err) {
        emit(RefundFailure(err.errorMsg));
      },
      (result) {
        refunds = result;
        emit(RefundSuccess());
      },
    );
  }
}
