// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../../../product/domain/models/product_model.dart';

class CartModel {
  final String id;
  final List<CartItem> items;

  CartModel({
    required this.id,
    required this.items,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      items: (json['items'] as List)
          .map((item) => CartItem.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

class CartItem extends Equatable {
  final int quantity;
  final String size;
  final String color;
  final num price;
  final String productName;
  final String productId;
  final List<ProductImage> productImages;
  final String cartId;

  const CartItem({
    required this.quantity,
    required this.size,
    required this.color,
    required this.price,
    required this.productName,
    required this.productId,
    required this.productImages,
    required this.cartId,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      quantity: json['quantity'],
      size: json['size'],
      color: json['color'],
      price: json['price'],
      productName: json['productName'],
      productId: json['productId'],
      productImages: (json['productImages'] as List)
          .map((image) => ProductImage.fromJson(image))
          .toList(),
      cartId: json['cartId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
      'size': size,
      'color': color,
      'price': price,
      'productName': productName,
      'productId': productId,
      'productImages': productImages.map((image) => image.toJson()).toList(),
      'cartId': cartId,
    };
  }

  @override
  List<Object> get props {
    return [
      quantity,
      size,
      color,
      price,
      productName,
      productId,
      productImages,
      cartId,
    ];
  }

  CartItem copyWith({
    int? quantity,
    String? size,
    String? color,
    int? price,
    String? productName,
    String? productId,
    List<ProductImage>? productImages,
    String? cartId,
  }) {
    return CartItem(
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
      color: color ?? this.color,
      price: price ?? this.price,
      productName: productName ?? this.productName,
      productId: productId ?? this.productId,
      productImages: productImages ?? this.productImages,
      cartId: cartId ?? this.cartId,
    );
  }
}

// class ProductImage {
//   final String productId;
//   final String url;
//   final String color;

//   ProductImage({
//     required this.productId,
//     required this.url,
//     required this.color,
//   });

//   factory ProductImage.fromJson(Map<String, dynamic> json) {
//     return ProductImage(
//       productId: json['productId'],
//       url: json['url'],
//       color: json['color'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'productId': productId,
//       'url': url,
//       'color': color,
//     };
//   }
// }
