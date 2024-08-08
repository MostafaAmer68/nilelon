import 'package:equatable/equatable.dart';

import 'product_image.dart';

class ProductVariant extends Equatable {
  final String? id;
  final String? productId;
  final num? price;
  final String? size;
  final num? quantity;
  final num? color;

  const ProductVariant({
    this.id,
    this.productId,
    this.price,
    this.size,
    this.quantity,
    this.color,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) {
    return ProductVariant(
      id: json['id'] as String?,
      productId: json['productId'] as String?,
      price: json['price'] as num?,
      size: json['size'] as String?,
      quantity: json['quantity'] as num?,
      color: json['color'] as num?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'productId': productId,
        'price': price,
        'size': size,
        'quantity': quantity,
        'color': color,
      };

  @override
  List<Object?> get props {
    return [
      id,
      productId,
      price,
      size,
      quantity,
      color,
    ];
  }
}
