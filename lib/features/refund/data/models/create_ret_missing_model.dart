class CreateRetMissingModel {
  final String orderId;
  final String productId;
  final String size;
  final String color;
  final String comment;

  CreateRetMissingModel(
    this.orderId,
    this.productId,
    this.size,
    this.color,
    this.comment,
  );

  factory CreateRetMissingModel.fromJson(Map<String, dynamic> json) {
    return CreateRetMissingModel(
      json['orderId'],
      json['productId'],
      json['size'],
      json['color'],
      json['comment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'productId': productId,
      'size': size,
      'color': color,
      'comment': comment,
    };
  }
}
