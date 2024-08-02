import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  final int? quantity;
  final String? size;
  final int? color;
  final String? productId;
  final String? cartId;

  const CartItem({
    this.quantity,
    this.size,
    this.color,
    this.productId,
    this.cartId,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        quantity: json['quantity'] as int?,
        size: json['size'] as String?,
        color: json['color'] as int?,
        productId: json['productId'] as String?,
        cartId: json['cartId'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'quantity': quantity,
        'size': size,
        'color': color,
        'productId': productId,
        'cartId': cartId,
      };

  @override
  List<Object?> get props => [quantity, size, color, productId, cartId];
}
