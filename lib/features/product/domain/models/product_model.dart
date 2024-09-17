// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductModel {
  final String id;
  final String name;
  final String description;
  final String type;

  final String categoryID;
  final String sizeguide;
  final bool isInCloset;
  final num rating;
  final num inStock;
  final String storeName;
  final String storeId;
  final List<ProductVariant> productVariants;
  final List<ProductImage> productImages;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.categoryID,
    required this.sizeguide,
    required this.isInCloset,
    required this.rating,
    required this.inStock,
    required this.storeName,
    required this.storeId,
    required this.productVariants,
    required this.productImages,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      type: json['type'],
      categoryID: json['categoryId'],
      sizeguide: json['sizeGuide'] ?? '',
      isInCloset: json['isInCloset'],
      rating: json['rating'],
      inStock: json['inStock'],
      storeName: json['storeName'] ?? '',
      storeId: json['storeId'],
      productVariants: (json['productVariants'] as List)
          .map((i) => ProductVariant.fromJson(i))
          .toList(),
      productImages: (json['productImages'] as List)
          .map((i) => ProductImage.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'categoryID': categoryID,
      'sizeguide': sizeguide,
      'isInCloset': isInCloset,
      'rating': rating,
      'inStock': inStock,
      'storeName': storeName,
      'storeId': storeId,
      'productVariants': productVariants.map((i) => i.toJson()).toList(),
      'productImages': productImages.map((i) => i.toJson()).toList(),
    };
  }

  ProductModel copyWith({
    String? id,
    String? name,
    String? description,
    String? type,
    String? categoryID,
    String? sizeguide,
    bool? isInCloset,
    num? rating,
    num? inStock,
    String? storeName,
    String? storeId,
    List<ProductVariant>? productVariants,
    List<ProductImage>? productImages,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      categoryID: categoryID ?? this.categoryID,
      sizeguide: sizeguide ?? this.sizeguide,
      isInCloset: isInCloset ?? this.isInCloset,
      rating: rating ?? this.rating,
      inStock: inStock ?? this.inStock,
      storeName: storeName ?? this.storeName,
      storeId: storeId ?? this.storeId,
      productVariants: productVariants ?? this.productVariants,
      productImages: productImages ?? this.productImages,
    );
  }
}

class ProductVariant {
  final String productId;
  final num price;
  final num discountRate;
  final num newPrice;
  final String size;
  final num quantity;
  final String color;

  ProductVariant({
    required this.productId,
    required this.price,
    required this.discountRate,
    required this.newPrice,
    required this.size,
    required this.quantity,
    required this.color,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) {
    return ProductVariant(
      productId: json['productId'],
      price: json['price'],
      discountRate: json['discountRate'],
      newPrice: json['newPrice'],
      size: json['size'],
      quantity: json['quantity'],
      color: json['color'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'price': price,
      'discountRate': discountRate,
      'newPrice': newPrice,
      'size': size,
      'quantity': quantity,
      'color': color,
    };
  }
}

class ProductImage {
  final String productId;
  final String url;
  final String description;
  final String color;

  ProductImage({
    required this.productId,
    required this.url,
    required this.description,
    required this.color,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      productId: json['productId'],
      url: json['url'],
      description: json['description'] ?? '',
      color: json['color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'url': url,
      'description': description,
      'color': color,
    };
  }
}
