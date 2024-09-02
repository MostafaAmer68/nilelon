// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  final int? quantity;
  final String? size;
  final String? color;
  final String? productId;
  final String? cartId;
  final num? price;
  final String? productName;

  const CartItem({
    this.quantity,
    this.size,
    this.color,
    this.productId,
    this.cartId,
    this.price,
    required this.productName,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        quantity: json['quantity'] as int?,
        size: json['size'] as String?,
        color: json['color'] as String?,
        productId: json['productId'] as String?,
        cartId: json['cartId'] as String?,
        price: json['price'] != null ? json['price'] as num : null,
        productName:
            json['productName'] != null ? json['productName'] as String : null,
      );

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
      quantity!,
      size!,
      color!,
      productId!,
      cartId!,
      price!,
    ];
  }
}
