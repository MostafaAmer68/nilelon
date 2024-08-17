class CreateVariantImage {
  final String productId;
  final String color;
  final List<String> images;

  CreateVariantImage({
    required this.productId,
    required this.color,
    required this.images,
  });

  // Factory method to create an instance from a map
  factory CreateVariantImage.fromMap(Map<String, dynamic> map) {
    return CreateVariantImage(
      productId: map['productId'],
      color: map['color'],
      images: List<String>.from(map['images']),
    );
  }

  // Method to convert an instance to a map
  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'color': color,
      'images': images,
    };
  }
}
