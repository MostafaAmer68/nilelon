import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/sizes_consts.dart';
import '../../../domain/models/add_product/add_product_model.dart';

part 'addproduct_state.dart';
part 'addproduct_cubit.freezed.dart';

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
  String? selectedValue;
  bool isSubmit = true;
  bool isActivated = false;
  bool isAdd = false;

  List<String> items = ['Male', 'Female', 'Both'];

  AddproductCubit() : super(const AddproductState.initial()) {}
}
