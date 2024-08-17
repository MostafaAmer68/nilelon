class DeleteVariantImage {
  final String productId;
  final String color;
  final List<String> urLs;

  DeleteVariantImage({
    required this.productId,
    required this.color,
    required this.urLs,
  });

  // Factory method to create an instance from a map
  factory DeleteVariantImage.fromMap(Map<String, dynamic> map) {
    return DeleteVariantImage(
      productId: map['productId'],
      color: map['color'],
      urLs: List<String>.from(map['urLs']),
    );
  }

  // Method to convert an instance to a map
  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'color': color,
      'urLs': urLs,
    };
  }
}
