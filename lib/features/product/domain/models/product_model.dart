// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

import 'product_image.dart';
import 'product_variant.dart';

class ProductModel extends Equatable {
  final String? id;
  final String? name;
  final String? description;
  final String? categoryId;
  final String? sizeguide;
  final DateTime? createdOn;
  final bool? isInCloset;
  final num? rating;
  final num? inStock;
  final String? storeName;
  final String? storeId;
  final List<ProductVariant>? productVariants;
  final List<ProductImage>? productImages;

  const ProductModel({
    this.id,
    this.name,
    this.description,
    this.categoryId,
    this.sizeguide,
    this.createdOn,
    this.isInCloset,
    this.rating,
    this.inStock,
    this.storeName,
    this.storeId,
    this.productVariants,
    this.productImages,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'] as String?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        categoryId: json['categoryID'] as String?,
        sizeguide: json['sizeguide'] as String?,
        createdOn: json['createdOn'] == null
            ? null
            : DateTime.parse(json['createdOn'] as String),
        isInCloset: json['isInCloset'] as bool?,
        rating: json['rating'] as num?,
        inStock: json['inStock'] as num?,
        storeName: json['storeName'] as String?,
        storeId: json['storeId'] as String?,
        productVariants: (json['productVariants'] as List<dynamic>?)
            ?.map((e) => ProductVariant.fromJson(e as Map<String, dynamic>))
            .toList(),
        productImages: (json['productImages'] as List<dynamic>?)
            ?.map((e) => ProductImage.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'categoryID': categoryId,
        'sizeguide': sizeguide,
        'createdOn': createdOn?.toIso8601String(),
        'isInCloset': isInCloset,
        'rating': rating,
        'inStock': inStock,
        'storeName': storeName,
        'storeId': storeId,
        'productVariants': productVariants?.map((e) => e.toJson()).toList(),
        'productImages': productImages?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props {
    return [
      id,
      name,
      description,
      categoryId,
      sizeguide,
      createdOn,
      isInCloset,
      rating,
      inStock,
      storeName,
      storeId,
      productVariants,
      productImages
    ];
  }
}
