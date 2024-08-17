class DeleteVariant {
  final String size;
  final String color;
  final String productId;

  DeleteVariant({
    required this.size,
    required this.color,
    required this.productId,
  });

  // Factory method to create an instance from a map
  factory DeleteVariant.fromMap(Map<String, dynamic> map) {
    return DeleteVariant(
      size: map['size'],
      color: map['color'],
      productId: map['productId'],
    );
  }

  // Method to convert an instance to a map
  Map<String, dynamic> toMap() {
    return {
      'size': size,
      'color': color,
      'productId': productId,
    };
  }
}
