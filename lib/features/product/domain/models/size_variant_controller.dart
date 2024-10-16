import 'package:flutter/material.dart';

class SizeController {
  final TextEditingController quantity;
  final TextEditingController price;
  final bool isEdit;
  final String size;
  SizeController({
    required this.quantity,
    required this.price,
    required this.isEdit,
    required this.size,
  }) {
    // log(quantity.text, name: 'contsractor');
  }

  SizeController copyWith({
    TextEditingController? quantity,
    TextEditingController? price,
    bool? isEdit,
    String? size,
  }) {
    return SizeController(
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      isEdit: isEdit ?? this.isEdit,
      size: size ?? this.size,
    );
  }
}
