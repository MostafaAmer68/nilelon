class CreateVariant {
  final String productId;
  final int price;
  final String size;
  final String color;
  final int quantity;

  CreateVariant({
    required this.productId,
    required this.price,
    required this.size,
    required this.color,
    required this.quantity,
  });

  // Factory method to create an instance from a map
  factory CreateVariant.fromMap(Map<String, dynamic> map) {
    return CreateVariant(
      productId: map['productId'],
      price: map['price'],
      size: map['size'],
      color: map['color'],
      quantity: map['quantity'],
    );
  }

  // Method to convert an instance to a map
  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'price': price,
      'size': size,
      'color': color,
      'quantity': quantity,
    };
  }
}
