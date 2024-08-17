// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:hive/hive.dart';

part 'add_product_model.g.dart';

@HiveType(typeId: 0)
class AddProductModel {
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

  AddProductModel({
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
}

@HiveType(typeId: 1)
class Variant {
  @HiveField(0)
  final int color;

  @HiveField(1)
  final List<String> images;

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
      'images': images.map((x) => x).toList(),
      'sizes': sizes.map((x) => x.toMap()).toList(),
    };
  }
}

@HiveType(typeId: 2)
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
}
