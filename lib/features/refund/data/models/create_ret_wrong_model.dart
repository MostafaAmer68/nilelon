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

  CreateRetWrongModel(
    this.orderId,
    this.productId,
    this.size,
    this.color,
    this.returnedSize,
    this.returnedColor,
    this.frontImage,
    this.backImage,
    this.damageImage,
  );

  factory CreateRetWrongModel.fromJson(Map<String, dynamic> json) {
    return CreateRetWrongModel(
      json['orderId'],
      json['productId'],
      json['size'],
      json['color'],
      json['returnedSize'],
      json['returnedColor'],
      json['frontImage'],
      json['backImage'],
      json['damageImage'],
    );
  }

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
