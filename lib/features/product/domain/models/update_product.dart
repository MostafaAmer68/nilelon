// ignore_for_file: public_member_api_docs, sort_constructors_first
class UpdateProduct {
  final String productId;
  final String name;
  final String description;
  final String categoryID;
  final String type;
  final String sizeguide;

  UpdateProduct({
    required this.productId,
    required this.name,
    required this.description,
    required this.categoryID,
    required this.type,
    required this.sizeguide,
  });

  factory UpdateProduct.fromJson(Map<String, dynamic> json) {
    return UpdateProduct(
      productId: json['productId'],
      name: json['name'],
      description: json['description'],
      categoryID: json['categoryID'],
      type: json['type'],
      sizeguide: json['sizeguide'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'name': name,
      'description': description,
      'categoryID': categoryID,
      'type': type,
      'sizeguide': sizeguide,
    };
  }

  UpdateProduct copyWith({
    String? productId,
    String? name,
    String? description,
    String? categoryID,
    String? type,
    String? sizeguide,
  }) {
    return UpdateProduct(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      description: description ?? this.description,
      categoryID: categoryID ?? this.categoryID,
      type: type ?? this.type,
      sizeguide: sizeguide ?? this.sizeguide,
    );
  }
}
