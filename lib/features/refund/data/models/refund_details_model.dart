class ReturnDetailsModel {
  final String returnedSize;
  final String returnedColor;
  final String frontImage;
  final String backImage;
  final String damageImage;
  final String productName;
  final String productImage;
  final double price;
  final String size;
  final String color;

  ReturnDetailsModel({
    required this.returnedSize,
    required this.returnedColor,
    required this.frontImage,
    required this.backImage,
    required this.damageImage,
    required this.productName,
    required this.productImage,
    required this.price,
    required this.size,
    required this.color,
  });

  factory ReturnDetailsModel.fromJson(Map<String, dynamic> json) {
    return ReturnDetailsModel(
      returnedSize: json['returnedSize'] ?? '',
      returnedColor: json['returnedColor'] ?? '',
      frontImage: json['frontImage'],
      backImage: json['backImage'],
      damageImage: json['damageImage'] ?? '',
      productName: json['productName'],
      productImage: json['productImage'],
      price: json['price'],
      size: json['size'],
      color: json['color'],
    );
  }
  factory ReturnDetailsModel.empty() {
    return ReturnDetailsModel(
      returnedSize: '',
      returnedColor: '',
      frontImage: '',
      backImage: '',
      damageImage: '',
      productName: '',
      productImage: '',
      price: 0,
      size: '',
      color: '',
    );
  }
}
