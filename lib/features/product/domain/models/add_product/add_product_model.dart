// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';

part 'add_product_model.g.dart';

@HiveType(typeId: 0)
class ProductModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final String type;

  @HiveField(3)
  final String storeId;

  @HiveField(4)
  final String categoryID;

  @HiveField(5)
  final String sizeguide;

  @HiveField(6)
  final List<Variant> variants;

  ProductModel({
    required this.name,
    required this.description,
    required this.type,
    required this.storeId,
    required this.categoryID,
    required this.sizeguide,
    required this.variants,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'type': type,
      'storeId': storeId,
      'categoryID': categoryID,
      'sizeguide': sizeguide,
      'variants': variants.map((x) => x.toMap()).toList(),
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map['name'] as String,
      description: map['description'] as String,
      type: map['type'] as String,
      storeId: map['storeId'] as String,
      categoryID: map['categoryID'] as String,
      sizeguide: map['sizeguide'] as String,
      variants: List<Variant>.from(
        (map['variants'] as List<int>).map<Variant>(
          (x) => Variant.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}

@HiveType(typeId: 1)
class Variant {
  @HiveField(0)
  final int color;

  @HiveField(1)
  final List<ImageModel> images;

  @HiveField(2)
  final List<SizeModel> sizes;

  Variant({
    required this.color,
    required this.images,
    required this.sizes,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'color': color,
      'images': images.map((x) => x.toMap()).toList(),
      'sizes': sizes.map((x) => x.toMap()).toList(),
    };
  }

  factory Variant.fromMap(Map<String, dynamic> map) {
    return Variant(
      color: map['color'] as int,
      images: List<ImageModel>.from(
        (map['images'] as List<int>).map<ImageModel>(
          (x) => ImageModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      sizes: List<SizeModel>.from(
        (map['sizes'] as List<int>).map<SizeModel>(
          (x) => SizeModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}

@HiveType(typeId: 2)
class ImageModel {
  @HiveField(0)
  final String image;

  ImageModel({
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
    };
  }

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      image: map['image'] as String,
    );
  }
}

@HiveType(typeId: 3)
class SizeModel {
  @HiveField(0)
  final String size;

  @HiveField(1)
  final num price;

  @HiveField(2)
  final int quantity;

  SizeModel({
    required this.size,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'size': size,
      'price': price,
      'quantity': quantity,
    };
  }

  factory SizeModel.fromMap(Map<String, dynamic> map) {
    return SizeModel(
      size: map['size'] as String,
      price: map['price'] as num,
      quantity: map['quantity'] as int,
    );
  }
}
