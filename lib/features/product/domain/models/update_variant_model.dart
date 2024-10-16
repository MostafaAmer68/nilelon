// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class UpdateVariantDto extends Equatable {
  final num price;
  final String size;
  final String color;
  final int quantity;

  const UpdateVariantDto({
    required this.price,
    required this.size,
    required this.color,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'price': price,
      'size': size,
      'color': color,
      'quantity': quantity,
    };
  }

  factory UpdateVariantDto.fromMap(Map<String, dynamic> map) {
    return UpdateVariantDto(
      price: map['price'] as double,
      size: map['size'] as String,
      color: map['color'] as String,
      quantity: map['quantity'] as int,
    );
  }

  @override
  List<Object> get props => [price, size, color, quantity];

  UpdateVariantDto copyWith({
    num? price,
    String? size,
    String? color,
    int? quantity,
  }) {
    return UpdateVariantDto(
      price: price ?? this.price,
      size: size ?? this.size,
      color: color ?? this.color,
      quantity: quantity ?? this.quantity,
    );
  }
}

class UpdateVariantsModel extends Equatable {
  final String productId;
  final List<UpdateVariantDto> updateVariantsDto;

  const UpdateVariantsModel({
    required this.productId,
    required this.updateVariantsDto,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'updateVariantsDto': updateVariantsDto.map((x) => x.toMap()).toList(),
    };
  }

  factory UpdateVariantsModel.fromMap(Map<String, dynamic> map) {
    return UpdateVariantsModel(
      productId: map['productId'] as String,
      updateVariantsDto: List<UpdateVariantDto>.from(
        (map['updateVariantsDto'] as List<int>).map<UpdateVariantDto>(
          (x) => UpdateVariantDto.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  UpdateVariantsModel copyWith({
    String? productId,
    List<UpdateVariantDto>? updateVariantsDto,
  }) {
    return UpdateVariantsModel(
      productId: productId ?? this.productId,
      updateVariantsDto: updateVariantsDto ?? this.updateVariantsDto,
    );
  }

  @override
  List<Object> get props => [productId, updateVariantsDto];
}
