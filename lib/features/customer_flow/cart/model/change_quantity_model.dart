import 'package:equatable/equatable.dart';

class ChangeQuantityModel extends Equatable {
  final int? quantity;
  final int? color;
  final String? size;
  final String? productId;
  final String? customrId;

  const ChangeQuantityModel({
    this.quantity,
    this.color,
    this.size,
    this.productId,
    this.customrId,
  });

  factory ChangeQuantityModel.fromJson(Map<String, dynamic> json) {
    return ChangeQuantityModel(
      quantity: json['quantity'] as int?,
      color: json['color'] as int?,
      size: json['size'] as String?,
      productId: json['productId'] as String?,
      customrId: json['customrId'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'quantity': quantity,
        'color': color,
        'size': size,
        'productId': productId,
        'customrId': customrId,
      };

  @override
  List<Object?> get props {
    return [
      quantity,
      color,
      size,
      productId,
      customrId,
    ];
  }
}
