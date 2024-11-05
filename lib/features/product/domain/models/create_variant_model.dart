// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class CreateVariant extends Equatable {
  final String productId;
  final List<UpdateVariant> updateVariantsDto;
  const CreateVariant({
    required this.productId,
    required this.updateVariantsDto,
  });

  // Factory method to create an instance from a map
  factory CreateVariant.fromMap(Map<String, dynamic> map) {
    return CreateVariant(
      productId: map['productId'] as String,
      updateVariantsDto: List<UpdateVariant>.from(
        (map['updateVariantsDto'] as List<int>).map<UpdateVariant>(
          (x) => UpdateVariant.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  // Method to convert an instance to a map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'updateVariantsDto': updateVariantsDto.map((x) => x.toMap()).toList(),
    };
  }

  @override
  List<Object> get props => [productId, updateVariantsDto];

  CreateVariant copyWith({
    String? productId,
    List<UpdateVariant>? updateVariantsDto,
  }) {
    return CreateVariant(
      productId: productId ?? this.productId,
      updateVariantsDto: updateVariantsDto ?? this.updateVariantsDto,
    );
  }
}

class UpdateVariant extends Equatable {
  final num price;
  final String size;
  final String color;
  final int quantity;
  const UpdateVariant({
    required this.price,
    required this.size,
    required this.color,
    required this.quantity,
  });

  @override
  List<Object> get props => [price, size, color, quantity];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'price': price,
      'size': size,
      'color': color,
      'quantity': quantity,
    };
  }

  factory UpdateVariant.fromMap(Map<String, dynamic> map) {
    return UpdateVariant(
      price: map['price'] as num,
      size: map['size'] as String,
      color: map['color'] as String,
      quantity: map['quantity'] as int,
    );
  }

  UpdateVariant copyWith({
    num? price,
    String? size,
    String? color,
    int? quantity,
  }) {
    return UpdateVariant(
      price: price ?? this.price,
      size: size ?? this.size,
      color: color ?? this.color,
      quantity: quantity ?? this.quantity,
    );
  }
}
