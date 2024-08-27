// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:equatable/equatable.dart';

class AddToCartModel extends Equatable {
  final int quantity;
  final String size;
  final String color;
  final String productId;
  final String customerId;
  const AddToCartModel({
    required this.quantity,
    required this.size,
    required this.color,
    required this.productId,
    required this.customerId,
  });

  @override
  List<Object> get props {
    return [
      quantity,
      size,
      color,
      productId,
      customerId,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'quantity': quantity,
      'size': size,
      'color': color,
      'productId': productId,
      'customrId': customerId,
    };
  }

  factory AddToCartModel.fromMap(Map<String, dynamic> map) {
    return AddToCartModel(
      quantity: map['quantity'] as int,
      size: map['size'] as String,
      color: map['color'] as String,
      productId: map['productId'] as String,
      customerId: map['customerId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddToCartModel.fromJson(String source) =>
      AddToCartModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
