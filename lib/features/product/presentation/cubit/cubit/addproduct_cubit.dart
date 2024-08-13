import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/models/add_product/add_product_model.dart';

part 'addproduct_state.dart';
part 'addproduct_cubit.freezed.dart';

class AddproductCubit extends Cubit<AddproductState> {
  static AddproductCubit get(context) =>
      BlocProvider.of<AddproductCubit>(context);
  TextEditingController xsController = TextEditingController();
  TextEditingController sController = TextEditingController();
  TextEditingController mController = TextEditingController();
  TextEditingController lController = TextEditingController();
  TextEditingController xlController = TextEditingController();
  TextEditingController xxlController = TextEditingController();
  TextEditingController xxxlController = TextEditingController();
  TextEditingController xsPriceController = TextEditingController();
  TextEditingController sPriceController = TextEditingController();
  TextEditingController mPriceController = TextEditingController();
  TextEditingController lPriceController = TextEditingController();
  TextEditingController xlPriceController = TextEditingController();
  TextEditingController xxlPriceController = TextEditingController();
  TextEditingController xxxlPriceController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  File? image;
  File? image1;
  File? image2;
  File? image3;
  File? sizeGuideImage;

  List<int> colors = [
    0xFFD80000,
    0xFF1F00DF,
    0xFFFFCD1C,
    0xFFFFFFFF,
    0xFF101010,
    0xFF170048,
    0xFF165A11,
  ];
  List<bool> isNonEditable = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  int selectedColor = 0xFFD80000;
  List<Variant> nonEditableVarients = [];
  List<Map<String, dynamic>> sizes = [
    {
      'size': 'XS',
      "isEdit": false,
    },
    {
      'size': 'S',
      "isEdit": false,
    },
    {
      'size': 'M',
      "isEdit": false,
    },
    {
      'size': 'L',
      "isEdit": false,
    },
    {
      'size': 'XL',
      "isEdit": false,
    },
    {
      'size': 'XXL',
      "isEdit": false,
    },
    {
      'size': 'XXXL',
      "isEdit": false,
    },
  ];
  int selectedIndex = 0;
  String? selectedValue;
  bool isSubmit = true;
  bool isActivated = false;
  bool isAdd = false;
  List<String> items = ['Male', 'Female', 'Both'];

  AddproductCubit() : super(AddproductState.initial());
}
