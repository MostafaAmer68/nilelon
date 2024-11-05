// import 'dart:async';
// import 'dart:developer';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:nilelon/core/helper.dart';
// import 'package:nilelon/core/data/hive_stroage.dart';
// import 'package:nilelon/features/auth/domain/model/user_model.dart';
// import 'package:nilelon/features/product/data/repositories/products_repos_impl.dart';
// import 'package:nilelon/features/product/domain/models/product_data/draft_product_model.dart';
// import 'package:nilelon/features/product/domain/models/product_model.dart';
// import 'package:nilelon/features/product/domain/models/size_variant_controller.dart';
// import 'package:nilelon/features/product/domain/models/update_variant_model.dart';

// part 'add_product_state.dart';
// part 'add_product_cubit.freezed.dart';

// class AddProductCubit extends Cubit<AddproductState> {
//   static AddProductCubit get(context) => BlocProvider.of<AddProductCubit>(context);
  
//   final ProductsReposImpl _product;
//   final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  
//   TextEditingController priceC = TextEditingController();
//   TextEditingController productNameC = TextEditingController();
//   TextEditingController productDesC = TextEditingController();
  
//   List<Map<String, dynamic>> quantityControllers = [];
//   List<Map<String, dynamic>> priceControllers = [];
//   List<String> colors = ['0xFFD80000', '0xFF1F00DF', '0xFFFFCD1C', '0xFFFFFFFF', '0xFF101010', '0xFF170048', '0xFF165A11'];
//   Map<String, bool> isVarientAdded = { for (var color in colors) color: false };
//   List<String> items = ['Male', 'Female', 'UniSex'];
  
//   File sizeGuideImage = File('');
//   List<File> images = [];
//   List<Variant> addedVarients = [];
//   List<SizeController> sizes = [];
//   ProductModel productEdit = ProductModel.empty();
  
//   String selectedColor = '0xFFD80000';
//   String? productType;
//   String categoryId = '';
//   bool isEdit = false, isSubmit = true, isNotFirstTimeActivated = false, isVarientActive = false;
//   int selectedIndex = 0;

//   AddProductCubit(this._product) : super(const AddproductState.initial());

//   List<Map<String, bool>> generateIsEditableList(List<String> colors, List<bool> isEditable) =>
//       [for (int i = 0; i < colors.length; i++) {colors[i]: isEditable[i]}];

//   Future<void> saveDraft(BuildContext context) async {
//     emit(const AddproductState.loading());
//     try {
//       final List<Variant> variants = HiveStorage.get(HiveKeys.tempVarients) ?? [];
//       final List productDataList = HiveStorage.get(HiveKeys.draftProduct) ?? [];
//       final newProductData = DraftProductModel(
//         productPrice: priceC.text,
//         product: AddProductModel(
//           categoryID: categoryId,
//           name: productNameC.text,
//           type: productType ?? 'UniSex',
//           description: productDesC.text,
//           variants: variants,
//           sizeguide: await convertImageToBase64(sizeGuideImage),
//           storeId: HiveStorage.get<UserModel>(HiveKeys.userModel).id,
//         ),
//         isEditable: generateIsEditableList(colors, isVarientAdded.values.toList()),
//       );
//       productDataList.add(newProductData);
//       HiveStorage.set(HiveKeys.draftProduct, productDataList);
//       HiveStorage.set(HiveKeys.varients, isVarientAdded);
//       HiveStorage.remove(HiveKeys.tempVarients);
//       emit(const AddproductState.success());
//     } catch (e) {
//       emit(AddproductState.failure(e.toString()));
//     }
//   }

//   Future<void> createProduct(DraftProductModel? product) async {
//     emit(const AddproductState.loading());
//     final sizeGuid = await convertImageToBase64(sizeGuideImage);
//     final variant = product == null ? HiveStorage.get<List>(HiveKeys.tempVarients) : product.product.variants;
//     final result = await _product.createProduct(
//       AddProductModel(
//         name: productNameC.text,
//         description: productDesC.text,
//         type: productType!,
//         storeId: HiveStorage.get<UserModel>(HiveKeys.userModel).id,
//         categoryID: product?.product.categoryID ?? categoryId,
//         sizeguide: sizeGuid,
//         variants: List<Variant>.from(variant.map((e) => Variant(color: e.color, images: e.images, sizes: e.sizes))),
//       ),
//     );
//     result.fold((err) => emit(AddproductState.failure(err.errorMsg)), (_) {
//       HiveStorage.set(HiveKeys.tempVarients, null);
//       emit(const AddproductState.success());
//     });
//   }

//   Future<void> updateProduct(ProductModel product) async {
//     emit(const AddproductState.loading());
//     final sizeGuid = sizeGuideImage.path.contains('https') ? product.sizeguide : await convertImageToBase64(sizeGuideImage);
//     final result = await _product.updateProduct(
//       UpdateProduct(
//         name: product.name,
//         description: product.description,
//         type: productType!,
//         categoryID: categoryId,
//         sizeguide: sizeGuid,
//         productId: product.id,
//       ).copyWith(
//         name: product.name == productNameC.text ? null : productNameC.text,
//         description: product.description == productDesC.text ? null : productDesC.text,
//         type: product.type == productType! ? null : productType!,
//       ),
//     );
//     result.fold((err) => emit(AddproductState.failure(err.errorMsg)), (_) {
//       HiveStorage.set(HiveKeys.tempVarients, null);
//       emit(const AddproductState.success());
//     });
//   }

//   Future<void> handleSubmit() async {
//     emit(const AddproductState.initial());
//     if (globalKey.currentState!.validate() && sizeGuideImage.path.isNotEmpty && images.isNotEmpty) {
//       if (HiveStorage.get<List?>(HiveKeys.tempVarients) == null) _saveNewVariant();
//       else _updateExistingVariant();
//       isVarientAdded[selectedColor] = true;
//       isVarientActive = false;
//       isSubmit = false;
//       _resetSizeControllersToDefault();
//     } else {
//       emit(const AddproductState.failure('Please enter valid form data'));
//     }
//   }

//   void _saveNewVariant() {
//     final productVariant = _createProductVariant();
//     addedVarients.removeWhere((v) => v.color == selectedColor.substring(2));
//     HiveStorage.set(HiveKeys.tempVarients, [productVariant]);
//     addedVarients.add(productVariant);
//   }

//   Variant _createProductVariant() {
//     List<String> convertedImages = [];
//     for (var img in images) convertImageToBase64(img).then((value) => convertedImages.add(value));
//     return Variant(
//       color: selectedColor.substring(2),
//       images: convertedImages,
//       sizes: sizes.map((e) => SizeModel(size: e.size, price: num.parse(e.price.text), quantity: int.parse(e.quantity.text))).toList(),
//     );
//   }

//   void _resetSizeControllersToDefault() {
//     images.clear();
//     sizes = SizeTypes.values.map((e) => SizeController(size: e.name, isEdit: false, quantity: TextEditingController(), price: TextEditingController())).toList();
//   }

//   void onSelectedColor(int index) {
//     selectedIndex = index;
//     selectedColor = colors[selectedIndex];
//     if (_checkIfVarientEditable()) {
//       isSubmit = false;
//       isVarientActive = false;
//       isNotFirstTimeActivated = true;
//     }
//   }

//   bool _checkIfVarientEditable() => isVarientAdded[selectedColor]!;
// }
