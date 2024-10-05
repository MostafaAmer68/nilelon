import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nilelon/core/helper.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/pop_ups/camera_popup.dart';
import 'package:nilelon/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:nilelon/features/order/data/models/order_customer_model.dart';
import 'package:nilelon/features/refund/data/models/create_ret_change_mind_model.dart';
import 'package:nilelon/features/refund/data/models/create_ret_missing_model.dart';
import 'package:nilelon/features/refund/data/models/create_ret_wrong_model.dart';
import 'package:nilelon/features/refund/data/models/refund_details_model.dart';
import 'package:nilelon/features/refund/data/models/refund_model.dart';
import 'package:nilelon/features/refund/data/repositories/refund_repo_impl.dart';

part 'refund_state.dart';

class RefundCubit extends Cubit<RefundState> {
  final RefundRepoImpl _refund;
  static RefundCubit get(context) => BlocProvider.of(context);
  RefundCubit(this._refund) : super(RefundInitial());
  List<RefundModel> refunds = [];

  String orderId = '';
  List<OrderProductVariant> selectedProducts = [];
  String? selectedValue;
  String? wrongSelectedValue;
  String selectedColor = '';
  String selectedSize = '';
  File? backImage;
  File? fronImage;
  File? damageImage;
  ReturnDetailsModel returnDetails = ReturnDetailsModel.empty();
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
    emit(RefundInitial());
    if (selectedProducts.isEmpty) {
      emit(const RefundFailure('Please select 1 of product'));
      return;
    }
    emit(RefundLoading());
    if (selectedProducts.length == 1) {
      final selectedProduct = selectedProducts.first;
      final result = await _refund.createRetMissingItem(CreateRetMissingModel(
        orderId,
        selectedProduct.productId,
        selectedProduct.size,
        selectedProduct.color,
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
          item.productId,
          item.size,
          item.color,
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

  Future<void> createWrongItem() async {
    emit(RefundInitial());
    if (selectedProducts.isEmpty) {
      emit(const RefundFailure('Please select 1 of product'));
      return;
    }
    log(wrongSelectedValue!);
    if (wrongSelectedValue == 'Damaged item') {
      if (fronImage == null || backImage == null || damageImage == null) {
        emit(const RefundFailure(
            'please upload 2 photo of product and damaged photo'));
        return;
      }
    }
    if (wrongSelectedValue == 'Color') {
      if (selectedColor.isEmpty) {
        emit(const RefundFailure('please select Color'));
        return;
      } else if (fronImage == null || backImage == null) {
        emit(const RefundFailure('please upload 2 photo of product'));
        return;
      }
    }
    if (wrongSelectedValue == 'Size') {
      if (selectedSize.isEmpty) {
        emit(const RefundFailure('please select Size'));
        return;
      } else if (fronImage == null || backImage == null) {
        emit(const RefundFailure('please upload 2 photo of product'));
        return;
      }
    }

    emit(RefundLoading());
    final fImage = await convertImageToBase64(fronImage!);
    final bImage = await convertImageToBase64(backImage!);
    final String dImage =
        damageImage != null ? await convertImageToBase64(damageImage!) : '';
    if (selectedProducts.length == 1) {
      final selectedProduct = selectedProducts.first;
      final result = await _refund.createRetWrongItem(CreateRetWrongModel(
        orderId: orderId,
        productId: selectedProduct.productId,
        size: selectedProduct.size,
        color: selectedProduct.color,
        returnedColor: selectedColor,
        returnedSize: selectedSize,
        frontImage: fImage,
        backImage: bImage,
        damageImage: dImage,
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
        final result = await _refund.createRetWrongItem(CreateRetWrongModel(
          orderId: orderId,
          productId: item.productId,
          size: item.size,
          color: item.color,
          returnedColor: selectedColor,
          returnedSize: selectedSize,
          frontImage: fImage,
          backImage: bImage,
          damageImage: '',
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

  Future<void> createRetChangeMindModel() async {
    emit(RefundInitial());
    if (selectedProducts.isEmpty) {
      emit(const RefundFailure('Please select 1 of product'));
      return;
    }
    if (fronImage == null || backImage == null) {
      emit(const RefundFailure('please upload 2 photo of product'));
      return;
    }
    emit(RefundLoading());
    final fImage = await convertImageToBase64(fronImage!);
    final bImage = await convertImageToBase64(backImage!);
    if (selectedProducts.length == 1) {
      final selectedProduct = selectedProducts.first;
      final result =
          await _refund.createRetChangeMindItem(CreateRetChangeMindModel(
        orderId,
        selectedProduct.productId,
        selectedProduct.size,
        selectedProduct.color,
        fImage,
        bImage,
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
        final result =
            await _refund.createRetChangeMindItem(CreateRetChangeMindModel(
          orderId,
          item.productId,
          item.size,
          item.color,
          fImage,
          bImage,
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

  Future<void> getReturnDetails(String returnId, String returnType) async {
    emit(RefundLoading());
    final result = await _refund.getReturnDetails(returnId, returnType);

    result.fold(
      (err) {
        emit(RefundFailure(err.errorMsg));
      },
      (result) {
        returnDetails = result;
        emit(RefundSuccess());
      },
    );
  }
}
