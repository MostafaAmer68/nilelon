// ignore_for_file: public_member_api_docs, sort_constructors_first

class CreatePromo {
  final DateTime startDate;
  final DateTime endDate;
  final double discountRate;
  final List<String> productIds;

  CreatePromo({
    required this.startDate,
    required this.endDate,
    required this.discountRate,
    required this.productIds,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'startDate': startDate.millisecondsSinceEpoch,
      'endDate': endDate.millisecondsSinceEpoch,
      'discountRate': discountRate,
      'productIds': productIds,
    };
  }
}