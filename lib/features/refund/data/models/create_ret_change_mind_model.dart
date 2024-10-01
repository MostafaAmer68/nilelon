class CreateRetChangeMindModel {
  final String orderId;
  final String productId;
  final String size;
  final String color;
  final String frontImage;
  final String backImage;

  CreateRetChangeMindModel(
    this.orderId,
    this.productId,
    this.size,
    this.color,
    this.frontImage,
    this.backImage,
  );

  factory CreateRetChangeMindModel.fromJson(Map<String, dynamic> json) {
    return CreateRetChangeMindModel(
      json['orderId'],
      json['productId'],
      json['size'],
      json['color'],
      json['frontImage'],
      json['backImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'productId': productId,
      'size': size,
      'color': color,
      'frontImage': frontImage,
      'backImage': backImage,
    };
  }
}
