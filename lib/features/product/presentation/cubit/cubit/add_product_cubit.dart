import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nilelon/core/helper.dart';
import 'package:nilelon/data/hive_stroage.dart';
import 'package:nilelon/features/auth/domain/model/user_model.dart';
import 'package:nilelon/features/product/data/repositories/products_repos_impl.dart';

import '../../../../../core/sizes_consts.dart';
import '../../../../../utils/app_logs.dart';
import '../../../domain/models/add_product/add_product_model.dart';

part 'add_product_state.dart';
part 'add_product_cubit.freezed.dart';

class AddproductCubit extends Cubit<AddproductState> {
  static AddproductCubit get(context) =>
      BlocProvider.of<AddproductCubit>(context);
  TextEditingController priceController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  List<Map<String, dynamic>> quantityControllers = [];
  List<Map<String, dynamic>> priceControllers = [];

  File sizeGuideImage = File('');
  List<File> images = [];

  List<int> colors = [
    0xFFD80000,
    0xFF1F00DF,
    0xFFFFCD1C,
    0xFFFFFFFF,
    0xFF101010,
    0xFF170048,
    0xFF165A11,
  ];
  List<bool> isNonEditable = List.generate(7, (index) => false);
  int selectedColor = 0xFFD80000;
  List<Variant> nonEditableVarients = [];
  List<Map<String, dynamic>> sizes = [];
  int selectedIndex = 0;
  String? productType;
  String categoryId = '';
  bool isSubmit = true;
  bool isActivated = false;
  bool isAdd = false;

  List<String> items = ['Male', 'Female', 'Both'];
  final ProductsReposImpl _product;

  AddproductCubit(this._product) : super(const AddproductState.initial());

  Future<void> createProduct() async {
    emit(const AddproductState.loading());
    final sizeGuid = await convertImageToBase64(sizeGuideImage);
    final result = await _product.createProduct(
      AddProductModel(
        name: productNameController.text,
        description: productDescriptionController.text,
        type: productType!,
        storeId: JwtDecoder.decode(
            HiveStorage.get<UserModel>(HiveKeys.userModel).token)['id'],
        categoryID: categoryId,
        sizeguide: sizeGuid,
        variants: HiveStorage.get<List<Variant>>(HiveKeys.varients),
      ),
    );
    result.fold((err) {
      emit(AddproductState.failure(err.errorMsg));
    }, (res) {
      HiveStorage.set(HiveKeys.varients, null);
      emit(const AddproductState.success());
    });
  }

  void _updateExistingVariant() {
    List<Variant> varients = HiveStorage.get<List<Variant>>(HiveKeys.varients);
    Variant productVarieants = _createProductVariant();
    nonEditableVarients
        .removeWhere((element) => element.color == selectedColor);
    varients.add(productVarieants);
    HiveStorage.set(HiveKeys.varients, varients);
    nonEditableVarients.add(productVarieants);
  }

  Future<void> handleSubmit() async {
    // HiveStorage.set(HiveKeys.varients, null);
    if (HiveStorage.get(HiveKeys.varients) == null) {
      _saveNewVariant();
    } else {
      _updateExistingVariant();
    }
    isNonEditable[selectedIndex] = true;
    isAdd = false;
    isSubmit = false;
    _resetSizeControllersToDefault();

    AppLogs.infoLog(HiveStorage.get(HiveKeys.varients).toString());
  }

  void _saveNewVariant() {
    Variant productVarieants = _createProductVariant();

    nonEditableVarients
        .removeWhere((element) => element.color == selectedColor);
    HiveStorage.set(HiveKeys.varients, <Variant>[productVarieants]);
    nonEditableVarients.add(productVarieants);
  }

  Variant _createProductVariant() {
    final Completer<String> image = Completer();

    List<String> convertedImages = [];
    for (var img in images) {
      convertImageToBase64(img).then((value) async {
        image.complete(value);
        convertedImages.add((await image.future));
      });
    }
    return Variant(
      color: selectedColor,
      images: convertedImages,
      sizes: List<SizeModel>.from(
        sizes.map(
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
    sizes = SizeTypes.values
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

  void deleteVariant() {
    Variant? proVar;
    List varients = HiveStorage.get(HiveKeys.varients);
    for (var element in nonEditableVarients) {
      if (selectedColor == element.color) {
        proVar = element;
      }
    }
    nonEditableVarients.remove(proVar);
    varients.remove(proVar);
    HiveStorage.set(HiveKeys.varients, varients);
    resetSizeControllers();

    if (nonEditableVarients.isEmpty) {
      isActivated = false;
      isSubmit = true;
    }
  }

  int calculateTotalSizes() {
    return sizes
        .map((e) => (e['quantityController'] as TextEditingController).text)
        .fold(0, (sum, controller) => sum + (int.tryParse(controller) ?? 0));
  }

  void initializeSizeControllers() {
    sizes = SizeTypes.values
        .map(
          (e) => {
            'size': e.name,
            'isEdit': false,
            'quantityController': TextEditingController(),
            'priceController': TextEditingController(),
          },
        )
        .toList();

    for (var variant in nonEditableVarients) {
      if (variant.color == selectedColor) {
        if (variant.sizes.isNotEmpty) {
          for (var item in variant.sizes) {
            for (var itemSize in sizes) {
              itemSize['quantityController'] =
                  TextEditingController(text: item.quantity.toString());
              itemSize['priceController'] =
                  TextEditingController(text: item.price.toString());
            }
          }
        }
      } else {
        resetSizeControllers();
      }
    }
  }

  void resetSizeControllers() {
    for (var item in sizes) {
      item['quantityController'] = TextEditingController(text: '0');
      item['priceController'] =
          TextEditingController(text: priceController.text);
    }
  }
}
