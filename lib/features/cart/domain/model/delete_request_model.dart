import 'package:equatable/equatable.dart';

class DeleteRequestModel extends Equatable {
  final String? color;
  final String? size;
  final String? productId;
  final String? customrId;

  const DeleteRequestModel({
    this.color,
    this.size,
    this.productId,
    this.customrId,
  });

  factory DeleteRequestModel.fromJson(Map<String, dynamic> json) {
    return DeleteRequestModel(
      color: json['color'] as String?,
      size: json['size'] as String?,
      productId: json['productId'] as String?,
      customrId: json['customrId'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'color': color,
        'size': size,
        'productId': productId,
        'customrId': customrId,
      };

  @override
  List<Object?> get props => [color, size, productId, customrId];
}
