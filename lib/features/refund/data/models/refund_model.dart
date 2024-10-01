class RefundModel {
  final String id;
  final String orderId;
  final String date;
  final String reason;

  RefundModel({
    required this.id,
    required this.orderId,
    required this.date,
    required this.reason,
  });

  factory RefundModel.fromJson(Map<String, dynamic> json) {
    return RefundModel(
      id: json['id'],
      orderId: json['orderId'],
      date: json['date'],
      reason: json['reason'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderId': orderId,
      'date': date,
      'reason': reason,
    };
  }
}
