import 'dart:async';
import 'dart:developer';
import 'dart:io';

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
import 'package:nilelon/features/product/domain/models/size_variant_controller.dart';
import 'package:nilelon/features/product/domain/models/update_variant_model.dart';

import '../../../../../core/sizes_consts.dart';
import '../../../../../core/utils/app_logs.dart';
import '../../../domain/models/add_product/add_product_model.dart';
import '../../../domain/models/update_product.dart';

part 'add_product_state.dart';
part 'add_product_cubit.freezed.dart';

class AddProductCubit extends Cubit<AddproductState> {
  static AddProductCubit get(context) =>
      BlocProvider.of<AddProductCubit>(context);
  TextEditingController priceC = TextEditingController();
  TextEditingController productNameC = TextEditingController();
  TextEditingController productDesC = TextEditingController();
  List<Map<String, dynamic>> quantityControllers = [];
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> priceControllers = [];

  File sizeGuideImage = File('');
  bool isEdit = false;
  List<File> images = [];
  ProductModel productEdit = ProductModel.empty();

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
      productPrice: priceC.text,
      product: AddProductModel(
        categoryID: categoryId,
        name: productNameC.text,
        type: selectedColor,
        description: productDesC.text,
        variants: variants,
        sizeguide: (await convertImageToBase64(sizeGuideImage)),
        storeId: JwtDecoder.decode(
            HiveStorage.get<UserModel>(HiveKeys.userModel).token)['id'],
      ),
      isEditable:
          generateIsEditableList(colors, isVarientAdded.values.toList()),
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
  Map<String, bool> isVarientAdded = {
    '0xFFD80000': false,
    '0xFF1F00DF': false,
    '0xFFFFCD1C': false,
    '0xFFFFFFFF': false,
    '0xFF101010': false,
    '0xFF170048': false,
    '0xFF165A11': false,
  };
  String selectedColor = '0xFFD80000';
  List<Variant> addedVarients = [];
  List<SizeController> sizes = [];
  int selectedIndex = 0;
  String? productType;
  String categoryId = '';
  bool isSubmit = true;
  bool isNotFirstTimeActivated = false;
  bool isVarientActive = false;

  List<String> items = ['Male', 'Female', 'UniSex'];
  final ProductsReposImpl _product;

  AddProductCubit(this._product) : super(const AddproductState.initial());

  Future<void> createProduct() async {
    emit(const AddproductState.loading());
    final sizeGuid = await convertImageToBase64(sizeGuideImage);
    final result = await _product.createProduct(
      AddProductModel(
        name: productNameC.text,
        description: productDesC.text,
        type: productType!,
        storeId: HiveStorage.get<UserModel>(HiveKeys.userModel).id,
        categoryID: categoryId,
        sizeguide: sizeGuid,
        variants: List<Variant>.from(
          HiveStorage.get<List>(HiveKeys.tempVarients).map(
            (e) => Variant(color: e.color, images: e.images, sizes: e.sizes),
          ),
        ),
      ),
    );
    result.fold((err) {
      emit(AddproductState.failure(err.errorMsg));
    }, (res) {
      HiveStorage.set(HiveKeys.tempVarients, null);
      emit(const AddproductState.success());
    });
    try {} catch (e) {
      emit(AddproductState.failure(e.toString()));
    }
  }

  Future<void> updateProduct(ProductModel product) async {
    emit(const AddproductState.loading());
    final sizeGuid = sizeGuideImage.path.contains('https') ||
            sizeGuideImage.path.contains('http')
        ? product.sizeguide
        : await convertImageToBase64(sizeGuideImage);
    final result = await _product.updateProduct(
      UpdateProduct(
        name: product.name,
        description: product.description,
        type: productType!,
        categoryID: categoryId,
        sizeguide: sizeGuid,
        productId: product.id,
      ).copyWith(
        name: product.name == productNameC.text ? null : productNameC.text,
        description:
            product.description == productDesC.text ? null : productDesC.text,
        type: product.type == productType! ? null : productType!,
        categoryID: product.categoryID,
        sizeguide: sizeGuid,
        productId: product.id,
      ),
    );
    result.fold((err) {
      emit(AddproductState.failure(err.errorMsg));
    }, (res) {
      HiveStorage.set(HiveKeys.tempVarients, null);
      emit(const AddproductState.success());
    });
    try {} catch (e) {
      emit(AddproductState.failure(e.toString()));
    }
  }

  Future<void> updateVariant(ProductModel product) async {
    emit(const AddproductState.loading());
    List<UpdateVariantDto> updatedVariants = [];
    for (int i = 0; i < sizes.length; i++) {
      final variant = product.productVariants[i];
      final size = sizes[i];
      log(size.price.text);
      updatedVariants.add(
        UpdateVariantDto(
          price: variant.price,
          size: variant.size,
          color: variant.color,
          quantity: variant.quantity.toInt(),
        ).copyWith(
          price: num.parse(size.price.text) == variant.price
              ? null
              : num.parse(size.price.text),
          quantity: int.parse(size.quantity.text) == variant.quantity
              ? null
              : int.parse(size.quantity.text),
        ),
      );
    }
    final result = await _product.updateVariant(
      UpdateVariantsModel(
        productId: product.id,
        updateVariantsDto: product.productVariants
            .map(
              (e) => UpdateVariantDto(
                price: e.price,
                size: e.size,
                color: e.color,
                quantity: e.quantity.toInt(),
              ),
            )
            .toList(),
      ).copyWith(
        updateVariantsDto: updatedVariants,
      ),
    );
    result.fold((err) {
      emit(AddproductState.failure(err.errorMsg));
    }, (res) {
      HiveStorage.set(HiveKeys.tempVarients, null);
      emit(const AddproductState.success());
    });
    try {} catch (e) {
      emit(AddproductState.failure(e.toString()));
    }
  }

  void _updateExistingVariant() {
    final varients = HiveStorage.get<List>(HiveKeys.tempVarients);
    Variant productVarieants = _createProductVariant();
    addedVarients
        .removeWhere((element) => element.color == selectedColor.substring(2));
    varients.add(productVarieants);
    log(varients.map((e) => (e as Variant).sizes.first.quantity).toString());
    HiveStorage.set(HiveKeys.tempVarients, varients);
    addedVarients.add(productVarieants);
    log('update');
  }

  Future<void> handleSubmit() async {
    // HiveStorage.set(HiveKeys.tempVarients, null);
    emit(const AddproductState.initial());
    List<bool> isLeastOneQuantity = [];
    for (var e in sizes) {
      isLeastOneQuantity.add(e.quantity.text.isNotEmpty);
      log(e.quantity.text);
    }
    if (globalKey.currentState!.validate() &&
        sizeGuideImage.path.isNotEmpty &&
        images.isNotEmpty &&
        isLeastOneQuantity.contains(true)) {
      if (HiveStorage.get<List?>(HiveKeys.tempVarients) == null) {
        _saveNewVariant();
      } else {
        _updateExistingVariant();
      }
      isVarientAdded[selectedColor] = true;
      isVarientActive = false;
      isSubmit = false;

      _resetSizeControllersToDefault();
      initializeSizeControllers();

      AppLogs.infoLog(HiveStorage.get(HiveKeys.tempVarients).toString());
    } else {
      emit(const AddproductState.failure('please enter valid form'));
    }
  }

  void _saveNewVariant() {
    Variant productVarieants = _createProductVariant();

    addedVarients.removeWhere(
        (element) => (element.color == selectedColor.substring(2)));
    List<Variant> variants = [];
    variants.add(productVarieants);
    HiveStorage.set<List<Variant>>(HiveKeys.tempVarients, variants);
    addedVarients.add(productVarieants);
    log('save');
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
            size: e.size,
            price: num.parse(e.price.text.isEmpty ? priceC.text : e.price.text),
            quantity:
                int.parse(e.quantity.text.isEmpty ? '0' : e.quantity.text),
          ),
        ),
      ).toList(),
    );
  }

  void _resetSizeControllersToDefault() {
    images.clear();
    sizes = SizeTypes.values
        .map(
          (e) => SizeController(
            size: e.name,
            isEdit: false,
            quantity: TextEditingController(),
            price: TextEditingController(),
          ),
        )
        .toList();
  }

  bool _checkIfVarientEditable() => isVarientAdded[selectedColor]!;

  void onSelectedColor(
    index,
  ) {
    selectedIndex = index;
    selectedColor = colors[selectedIndex].toString();

    if (isEdit) {
      initializeVarientsEdit(productEdit);
    } else {
      initializeSizeControllers();
    }
    if (_checkIfVarientEditable()) {
      isSubmit = false;
      isVarientActive = false;
      isNotFirstTimeActivated = true;
    } else if (!_checkIfVarientEditable()) {
      isSubmit = false;
      isVarientActive = false;
      isNotFirstTimeActivated = true;
    } else {
      isVarientActive = false;
      isNotFirstTimeActivated = false;
      isSubmit = true;
    }
  }

  void addSize() {
    isVarientActive = true; // is add for activate variants widget
    isNotFirstTimeActivated =
        true; // check for first time variant activated or not
    isSubmit = true; // for submit or upload button only
    for (var item in sizes) {
      item.price.text = priceC.text;
    }
  }

  void editSize() {
    isVarientActive = true;
    isSubmit = true;
    isVarientAdded[selectedColor] = false;
    for (var item in sizes) {
      item.price.text = priceC.text;
    }
    removeNonEditableVariant();
  }

  void deleteVariant() {
    Variant? proVar;
    List varients = HiveStorage.get<List>(HiveKeys.tempVarients);
    for (var element in addedVarients) {
      if (selectedColor == element.color) {
        proVar = element;
      }
    }
    addedVarients.remove(proVar);
    varients.remove(proVar);
    HiveStorage.set(HiveKeys.tempVarients, varients);
    resetVarientWidget();

    if (addedVarients.isEmpty) {
      isNotFirstTimeActivated = false;
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
        .map((e) => e.quantity.text)
        .fold(0, (sum, controller) => sum + (int.tryParse(controller) ?? 0));
  }

  void initializeVarientsDraft(DraftProductModel product) {
    sizes = SizeTypes.values
        .map(
          (e) => SizeController(
            size: e.name,
            isEdit: false,
            quantity: TextEditingController(),
            price: TextEditingController(),
          ),
        )
        .toList();

    for (var variant in product.product.variants) {
      // if (variant.sizes.isNotEmpty) {
      if (variant.color == selectedColor.toLowerCase().substring(2)) {
        for (var item in variant.sizes) {
          for (int i = 0; i < sizes.length; i++) {
            sizes[i].quantity.text = item.quantity.toString();
            sizes[i].price.text = item.price.toString();
          }
        }
      }
    }
  }

  void initializeVarientsEdit(ProductModel product) async {
    sizes = SizeTypes.values
        .map(
          (e) => SizeController(
            size: e.name,
            isEdit: false,
            quantity: TextEditingController(),
            price: TextEditingController(),
          ),
        )
        .toList();
    priceC.text = product.productVariants.first.price.toString();
    productNameC.text = product.name;
    productDesC.text = product.description;
    isVarientActive = false;
    isNotFirstTimeActivated = true;
    isSubmit = true;
    productType = product.type;
    images = product.productImages.map((e) => File(e.url)).toList();
    sizeGuideImage = File(product.sizeguide);
    final variants =
        convertToVariant(product.productVariants, product.productImages);
    final varient = variants.firstWhere(
      (e) => e.color == selectedColor.toLowerCase().substring(2),
      orElse: () => Variant(
        color: selectedColor.substring(2),
        images: [],
        sizes: [],
      ),
    );

    if (varient.sizes.isNotEmpty) {
      for (int i = 0; i < sizes.length; i++) {
        sizes[i] = sizes[i].copyWith(
            quantity: TextEditingController(
                text: varient.sizes[i].quantity.toString()));
        sizes[i] = sizes[i].copyWith(
            price:
                TextEditingController(text: varient.sizes[i].price.toString()));
      }
    }
    for (int i = 0; i < variants.length; i++) {
      if (variants[i].sizes.every((e) => e.price != 0) ||
          variants[i].sizes.every((e) => e.quantity != 0)) {
        isVarientAdded['0x${variants[i].color.toUpperCase()}'] = true;
      }
    }
  }

  List<Variant> convertToVariant(
      List<ProductVariant> productVariants, List<ProductImage> productImages) {
    // Group product variants by color
    Map<String, List<ProductVariant>> groupedVariantsByColor = {};
    for (var variant in productVariants) {
      if (!groupedVariantsByColor.containsKey(variant.color)) {
        groupedVariantsByColor[variant.color] = [];
      }
      groupedVariantsByColor[variant.color]!.add(variant);
    }

    // Create a list of Variants from grouped variants
    List<Variant> variants = [];

    groupedVariantsByColor.forEach((color, variantsList) {
      // Extract sizes for each color
      List<SizeModel> sizes = variantsList
          .map((variant) => SizeModel(
                size: variant.size,
                price: variant.newPrice,
                quantity: variant.quantity.toInt(),
              ))
          .toList();

      // Extract images for the color from the ProductImage model
      List<String> images = productImages
          .where((image) => image.color == color)
          .map((image) => image.url)
          .toList();

      // Create a Variant object for this color
      variants.add(Variant(
        color: color,
        images: images,
        sizes: sizes,
      ));
    });

    return variants;
  }

  resetAll() {
    HiveStorage.set(HiveKeys.tempVarients, null);
    sizes = SizeTypes.values
        .map(
          (e) => SizeController(
            size: e.name,
            isEdit: false,
            quantity: TextEditingController(),
            price: TextEditingController(),
          ),
        )
        .toList();

    priceC.clear();
    productNameC.clear();
    productDesC.clear();
    productType = null;
    sizeGuideImage = File('');
    images.clear();
    isVarientAdded = {
      '0xFFD80000': false,
      '0xFF1F00DF': false,
      '0xFFFFCD1C': false,
      '0xFFFFFFFF': false,
      '0xFF101010': false,
      '0xFF170048': false,
      '0xFF165A11': false,
    };
  }

  void initializeSizeControllers() {
    sizes = SizeTypes.values
        .map(
          (e) => SizeController(
            size: e.name,
            isEdit: false,
            quantity: TextEditingController(),
            price: TextEditingController(),
          ),
        )
        .toList();

    final varient = addedVarients.firstWhere(
      (e) => e.color == selectedColor.substring(2),
      orElse: () => Variant(
        color: selectedColor.substring(2),
        images: [],
        sizes: [],
      ),
    );
    if (checkIfVarientAlreadyAdded(varient)) {
      initializeVarientWidget(varient);
    } else {
      resetVarientWidget();
    }
    // }
  }

  bool checkIfVarientAlreadyAdded(Variant variant) =>
      variant.color == selectedColor.substring(2);

  void initializeVarientWidget(Variant variant) async {
    images.clear();

    final Completer<File> result = Completer();
    for (var item in variant.images) {
      await convertBase64ToImage(item).then((value) async {
        result.complete(value);
        final image = await result.future;
        images.add(image);
        log(images.toString());
      });
    }
    if (variant.sizes.isNotEmpty) {
      for (int i = 0; i < sizes.length; i++) {
        sizes[i] = sizes[i].copyWith(
            quantity: TextEditingController(
                text: variant.sizes[i].quantity.toString()));
        sizes[i] = sizes[i].copyWith(
            price:
                TextEditingController(text: variant.sizes[i].price.toString()));
      }
    }
  }

  void resetVarientWidget() {
    images.clear();
    for (var item in sizes) {
      item.quantity.text = '0';
      item.price.text = priceC.text;
    }
  }
}
