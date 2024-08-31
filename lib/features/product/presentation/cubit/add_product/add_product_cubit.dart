import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nilelon/core/helper.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/features/auth/domain/model/user_model.dart';
import 'package:nilelon/features/product/data/repositories/products_repos_impl.dart';
import 'package:nilelon/features/product/domain/models/product_data/draft_product_model.dart';
import 'package:nilelon/features/product/domain/models/product_model.dart';

import '../../../../../core/sizes_consts.dart';
import '../../../../../core/utils/app_logs.dart';
import '../../../domain/models/add_product/add_product_model.dart';

part 'add_product_state.dart';
part 'add_product_cubit.freezed.dart';

class AddProductCubit extends Cubit<AddproductState> {
  static AddProductCubit get(context) =>
      BlocProvider.of<AddProductCubit>(context);
  TextEditingController priceController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  List<Map<String, dynamic>> quantityControllers = [];
  List<Map<String, dynamic>> priceControllers = [];

  File sizeGuideImage = File('');
  List<File> images = [];

  List<Map<String, bool>> generateIsEditableList(
      List<String> colors, List<bool> isEditable) {
    List<Map<String, bool>> editableList = [];
    for (int i = 0; i < colors.length; i++) {
      editableList.add({colors[i]: isEditable[i]});
    }
    return editableList;
  }

  Future<void> saveDraft(BuildContext context) async {
    final List<Variant> variants = HiveStorage.get(HiveKeys.tempVarients) ?? [];
    final List<DraftProductModel> productDataList =
        HiveStorage.get(HiveKeys.draftProduct) ?? [];

    final newProductData = DraftProductModel(
      productPrice: priceController.text,
      product: AddProductModel(
        categoryID: categoryId,
        name: productNameController.text,
        type: selectedColor,
        description: productDescriptionController.text,
        variants: variants,
        sizeguide: (await convertImageToBase64(sizeGuideImage)),
        storeId: JwtDecoder.decode(
            HiveStorage.get<UserModel>(HiveKeys.userModel).token)['id'],
      ),
      isEditable: generateIsEditableList(colors, isNonEditable),
    );

    productDataList.add(newProductData);
    HiveStorage.set(HiveKeys.draftProduct, productDataList);
    HiveStorage.remove(HiveKeys.tempVarients);
  }

  List<String> colors = [
    '0xFFD80000',
    '0xFF1F00DF',
    '0xFFFFCD1C',
    '0xFFFFFFFF',
    '0xFF101010',
    '0xFF170048',
    '0xFF165A11',
  ];
  List<bool> isNonEditable = List.generate(7, (index) => false);
  String selectedColor = '0xFFD80000';
  List<Variant> addedVarients = [];
  List<Map<String, dynamic>> sizes = [];
  int selectedIndex = 0;
  String? productType;
  String categoryId = '';
  bool isSubmit = true;
  bool isActivated = false;
  bool isAdd = false;

  List<String> items = ['Male', 'Female', 'UniSex'];
  final ProductsReposImpl _product;

  AddProductCubit(this._product) : super(const AddproductState.initial());

  Future<void> createProduct() async {
    emit(const AddproductState.loading());
    final sizeGuid = await convertImageToBase64(sizeGuideImage);
    try {
      final result = await _product.createProduct(
        AddProductModel(
          name: productNameController.text,
          description: productDescriptionController.text,
          type: productType!,
          storeId: JwtDecoder.decode(
              HiveStorage.get<UserModel>(HiveKeys.userModel).token)['id'],
          categoryID: categoryId,
          sizeguide: sizeGuid,
          variants: List<Variant>.from(
              HiveStorage.get<List>(HiveKeys.tempVarients).map((e) =>
                  Variant(color: e.color, images: e.images, sizes: e.sizes))),
        ),
      );
      result.fold((err) {
        emit(AddproductState.failure(err.errorMsg));
      }, (res) {
        HiveStorage.set(HiveKeys.tempVarients, null);
        emit(const AddproductState.success());
      });
    } catch (e) {
      emit(AddproductState.failure(e.toString()));
    }
  }

  void _updateExistingVariant() {
    final varients = HiveStorage.get<List>(HiveKeys.tempVarients);
    Variant productVarieants = _createProductVariant();
    addedVarients.removeWhere(
        (element) => int.parse(element.color) == int.parse(selectedColor));
    varients.add(productVarieants);
    HiveStorage.set(HiveKeys.tempVarients, varients);
    addedVarients.add(productVarieants);
  }

  Future<void> handleSubmit() async {
    // HiveStorage.set(HiveKeys.tempVarients, null);
    if (HiveStorage.get(HiveKeys.tempVarients) == null) {
      _saveNewVariant();
    } else {
      _updateExistingVariant();
    }
    isNonEditable[selectedIndex] = true;
    isAdd = false;
    isSubmit = false;
    _resetSizeControllersToDefault();

    AppLogs.infoLog(HiveStorage.get(HiveKeys.tempVarients).toString());
  }

  void _saveNewVariant() {
    Variant productVarieants = _createProductVariant();

    addedVarients.removeWhere((element) => (element.color == selectedColor));
    List<Variant> variants = [];
    variants.add(productVarieants);
    HiveStorage.set<List<Variant>>(HiveKeys.tempVarients, variants);
    addedVarients.add(productVarieants);
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
      color: selectedColor.substring(2),
      images: convertedImages,
      sizes: List<SizeModel>.from(
        sizes.map(
          (e) => SizeModel(
            size: e['size'],
            price: num.parse(e['priceController'].text.isEmpty
                ? priceController.text
                : e['priceController'].text),
            quantity: int.parse(e['quantityController'].text.isEmpty
                ? priceController.text
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
    List varients = HiveStorage.get(HiveKeys.tempVarients);
    for (var element in addedVarients) {
      if (selectedColor == element.color) {
        proVar = element;
      }
    }
    addedVarients.remove(proVar);
    varients.remove(proVar);
    HiveStorage.set(HiveKeys.tempVarients, varients);
    resetSizeControllers();

    if (addedVarients.isEmpty) {
      isActivated = false;
      isSubmit = true;
    }
  }

  void removeNonEditableVariant() {
    for (var element in addedVarients) {
      if (selectedColor == element.color) {
        final varients = HiveStorage.get<List<Variant>>(HiveKeys.tempVarients);
        varients.remove(element);
        HiveStorage.set(HiveKeys.tempVarients, varients);
      }
    }
  }

  int calculateTotalSizes() {
    return sizes
        .map((e) => (e['quantityController'] as TextEditingController).text)
        .fold(0, (sum, controller) => sum + (int.tryParse(controller) ?? 0));
  }

  void initializeVarientsDraft(DraftProductModel product) {
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

    for (var variant in product.product.variants) {
      // if (variant.sizes.isNotEmpty) {
      if (variant.color == selectedColor.substring(2)) {
        for (var item in variant.sizes) {
          for (int i = 0; i < sizes.length; i++) {
            sizes[i]['quantityController'] =
                TextEditingController(text: item.quantity.toString());
            sizes[i]['priceController'] =
                TextEditingController(text: item.price.toString());
            // log(sizes[i]['priceController'].text);
            // log(sizes[i]['size'].text);
          }
        }
      }

      // } else {
      // resetSizeControllers();
      // }
    }
  }

  void initializeVarientsEdit(ProductModel product) {
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
    priceController.text = product.productVariants.first.price.toString();
    productNameController.text = product.name;
    productDescriptionController.text = product.description;

    for (var variant in product.productVariants) {
      // if (variant.sizes.isNotEmpty) {
      if (variant.color == selectedColor.substring(2)) {
        for (int i = 0; i < sizes.length; i++) {
          sizes[i]['quantityController'] =
              TextEditingController(text: variant.quantity.toString());
          sizes[i]['priceController'] =
              TextEditingController(text: variant.price.toString());
        }
      }

      // } else {
      // resetSizeControllers();
      // }
    }
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

    for (var variant in addedVarients) {
      if (variant.color == selectedColor.substring(2)) {
        if (variant.sizes.isNotEmpty) {
          for (var item in variant.sizes) {
            for (int i = 0; i < sizes.length; i++) {
              sizes[i]['quantityController'] =
                  TextEditingController(text: item.quantity.toString());
              sizes[i]['priceController'] =
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
