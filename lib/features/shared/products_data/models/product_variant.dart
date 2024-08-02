import 'package:equatable/equatable.dart';

import 'product_image.dart';

class ProductVariant extends Equatable {
  final String? id;
  final String? productId;
  final num? price;
  final String? size;
  final num? quantity;
  final num? color;
  final List<ProductImage>? productImages;

  const ProductVariant({
    this.id,
    this.productId,
    this.price,
    this.size,
    this.quantity,
    this.color,
    this.productImages,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) {
    return ProductVariant(
      id: json['id'] as String?,
      productId: json['productId'] as String?,
      price: json['price'] as num?,
      size: json['size'] as String?,
      quantity: json['quantity'] as num?,
      color: json['color'] as num?,
      productImages: (json['productImages'] as List<dynamic>?)
          ?.map((e) => ProductImage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'productId': productId,
        'price': price,
        'size': size,
        'quantity': quantity,
        'color': color,
        'productImages': productImages?.map((e) => e.toJson()).toList(),
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
      productImages,
    ];
  }
}
