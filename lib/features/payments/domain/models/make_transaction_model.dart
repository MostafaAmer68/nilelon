class MakeTransactionModel {
  final String customerId;
  final int amount;
  final int discount;
  final String nonce;
  final String currencyIsoCode;

  MakeTransactionModel({
    required this.customerId,
    required this.amount,
    required this.discount,
    required this.nonce,
    required this.currencyIsoCode,
  });

  factory MakeTransactionModel.fromJson(Map<String, dynamic> json) {
    return MakeTransactionModel(
      customerId: json['customerId'],
      amount: json['amount'],
      discount: json['discount'],
      nonce: json['nonce'],
      currencyIsoCode: json['currencyIsoCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customerId': customerId,
      'amount': amount,
      'discount': discount,
      'nonce': nonce,
      'currencyIsoCode': currencyIsoCode,
    };
  }
}
