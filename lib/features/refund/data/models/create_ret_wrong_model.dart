class CreateRetWrongModel {
  final String orderId;
  final String productId;
  final String size;
  final String color;
  final String returnedSize;
  final String returnedColor;
  final String frontImage;
  final String backImage;
  final String damageImage;

  CreateRetWrongModel({
    required this.orderId,
    required this.productId,
    required this.size,
    required this.color,
    required this.returnedSize,
    required this.returnedColor,
    required this.frontImage,
    required this.backImage,
    required this.damageImage,
  });

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'productId': productId,
      'size': size,
      'color': color,
      'returnedSize': returnedSize,
      'returnedColor': returnedColor,
      'frontImage': frontImage,
      'backImage': backImage,
      'damageImage': damageImage,
    };
  }
}
