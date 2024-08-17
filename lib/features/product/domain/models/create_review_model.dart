class CreateReviewModel {
  final String comment;
  final int rate;
  final String productId;
  final String customerId;

  CreateReviewModel({
    required this.comment,
    required this.rate,
    required this.productId,
    required this.customerId,
  });

  // Method to convert an instance to a map
  Map<String, dynamic> toMap() {
    return {
      'comment': comment,
      'rate': rate,
      'productId': productId,
      'customerId': customerId,
    };
  }
}
