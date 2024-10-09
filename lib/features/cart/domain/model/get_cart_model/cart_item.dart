// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  final int quantity;
  final String size;
  final String color;
  final String productId;
  final String cartId;
  final num price;
  final String productName;

  const CartItem({
    required this.quantity,
    required this.size,
    required this.color,
    required this.productId,
    required this.cartId,
    required this.price,
    required this.productName,
  });

  Map<String, dynamic> toJson() => {
        'quantity': quantity,
        'size': size,
        'color': color,
        'productId': productId,
        'cartId': cartId,
      };

  @override
  List<Object> get props {
    return [
      quantity,
      size,
      color,
      productId,
      cartId,
      price,
    ];
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      quantity: map['quantity'] as int,
      size: map['size'] as String,
      color: map['color'] as String,
      productId: map['productId'] as String,
      cartId: map['cartId'] as String,
      price: map['price'] as num,
      productName: map['productName'] as String,
    );
  }

  CartItem copyWith({
    int? quantity,
    String? size,
    String? color,
    String? productId,
    String? cartId,
    num? price,
    String? productName,
  }) {
    return CartItem(
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
      color: color ?? this.color,
      productId: productId ?? this.productId,
      cartId: cartId ?? this.cartId,
      price: price ?? this.price,
      productName: productName ?? this.productName,
    );
  }
}
