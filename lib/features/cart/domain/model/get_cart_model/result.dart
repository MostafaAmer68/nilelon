import 'package:equatable/equatable.dart';

import 'cart_item.dart';

class CartResult extends Equatable {
  final String? id;
  final String? createdTime;
  final List<CartItem>? items;

  const CartResult({this.id, this.createdTime, this.items});

  factory CartResult.fromJson(Map<String, dynamic> json) => CartResult(
        id: json['id'] as String?,
        createdTime: json['createdTime'] as String?,
        items: (json['items'] as List<dynamic>?)
            ?.map((e) => CartItem.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'createdTime': createdTime,
        'items': items?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [id, createdTime, items];
}
