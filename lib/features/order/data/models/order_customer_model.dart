class OrderCustomerModel {
  final String id;
  final DateTime date;
  final int total;
  final int discount;
  final String? promoCodeName; // Nullable, since it's null in the JSON
  final String governate;
  final String status;
  final String phoneNumber;
  final String shippingCost;
  final String customerId;
  final List<OrderProductVariant> orderProductVariants;

  OrderCustomerModel({
    required this.id,
    required this.date,
    required this.total,
    required this.discount,
    this.promoCodeName,
    required this.governate,
    required this.status,
    required this.phoneNumber,
    required this.shippingCost,
    required this.customerId,
    required this.orderProductVariants,
  });

  factory OrderCustomerModel.fromJson(Map<String, dynamic> json) {
    return OrderCustomerModel(
      id: json['id'],
      date: DateTime.parse(json['date']),
      total: json['total'],
      discount: json['discount'],
      promoCodeName: json['promoCodeName'],
      governate: json['governate'],
      status: json['status'],
      phoneNumber: json['phoneNumber'],
      shippingCost: json['shippingCost'],
      customerId: json['customerId'],
      orderProductVariants: (json['orderProductVariants'] as List)
          .map((item) => OrderProductVariant.fromJson(item))
          .toList(),
    );
  }
}

class OrderProductVariant {
  final String orderId;
  final String productId;
  final String productName;
  final int productRate;
  final String size;
  final String color;
  final int quantity;
  final int price;
  final String storeName;
  final String storeId;
  final List<String> urls;

  OrderProductVariant({
    required this.orderId,
    required this.productId,
    required this.productName,
    required this.productRate,
    required this.size,
    required this.color,
    required this.quantity,
    required this.price,
    required this.storeName,
    required this.storeId,
    required this.urls,
  });

  factory OrderProductVariant.fromJson(Map<String, dynamic> json) {
    return OrderProductVariant(
      orderId: json['orderId'],
      productId: json['productId'],
      productName: json['productName'],
      productRate: json['productRate'],
      size: json['size'],
      color: json['color'],
      quantity: json['quantity'],
      price: json['price'],
      storeName: json['storeName'],
      storeId: json['storeId'],
      urls: List<String>.from(json['urls']),
    );
  }
}
