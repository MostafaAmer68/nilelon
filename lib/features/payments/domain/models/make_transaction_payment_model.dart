class MakeTransactionWithPaymentModel {
  final String paymentToken;
  final int amount;
  final int discount;
  final String currencyIsoCode;

  MakeTransactionWithPaymentModel({
    required this.paymentToken,
    required this.amount,
    required this.discount,
    required this.currencyIsoCode,
  });

  factory MakeTransactionWithPaymentModel.fromJson(Map<String, dynamic> json) {
    return MakeTransactionWithPaymentModel(
      paymentToken: json['paymentToken'],
      amount: json['amount'],
      discount: json['discount'],
      currencyIsoCode: json['currencyIsoCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'paymentToken': paymentToken,
      'amount': amount,
      'discount': discount,
      'currencyIsoCode': currencyIsoCode,
    };
  }
}
