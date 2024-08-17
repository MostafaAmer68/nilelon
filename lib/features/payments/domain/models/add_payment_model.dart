class AddPaymentModel {
  final String customerId;
  final String name;
  final String nonce;

  AddPaymentModel({
    required this.customerId,
    required this.name,
    required this.nonce,
  });

  factory AddPaymentModel.fromJson(Map<String, dynamic> json) {
    return AddPaymentModel(
      customerId: json['customerId'],
      name: json['name'],
      nonce: json['nonce'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customerId': customerId,
      'name': name,
      'nonce': nonce,
    };
  }
}
