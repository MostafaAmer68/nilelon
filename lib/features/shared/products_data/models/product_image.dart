import 'package:equatable/equatable.dart';

class ProductImage extends Equatable {
  final String? productId;
  final String? url;
  final dynamic description;
  final String? size;
  final num? color;

  const ProductImage({
    this.productId,
    this.url,
    this.description,
    this.size,
    this.color,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
        productId: json['productId'] as String?,
        url: json['url'] as String?,
        description: json['description'] as dynamic,
        size: json['size'] as String?,
        color: json['color'] as num?,
      );

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'url': url,
        'description': description,
        'size': size,
        'color': color,
      };

  @override
  List<Object?> get props => [productId, url, description, size, color];
}
