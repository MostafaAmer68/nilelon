// ignore_for_file: public_member_api_docs, sort_constructors_first
class OrderCustomerModel {
  final String id;
  final DateTime date;
  final num total;
  final num discount;
  final String? promoCodeName;
  final String governate;
  final String status;
  final String paymentType;
  final String phoneNumber;
  final String shippingCost;
  final bool isPromoApplied;
  final String customerId;
  final List<OrderProductVariant> orderProductVariants;

  factory OrderCustomerModel.empty() => OrderCustomerModel(
        id: '',
        date: DateTime.now(),
        total: 0,
        discount: 0,
        paymentType: '',
        governate: '',
        status: '',
        isPromoApplied: false,
        phoneNumber: '',
        shippingCost: '0',
        customerId: '',
        orderProductVariants: [],
      );

  OrderCustomerModel({
    required this.id,
    required this.date,
    required this.total,
    required this.discount,
    this.promoCodeName,
    required this.governate,
    required this.status,
    required this.isPromoApplied,
    required this.paymentType,
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
      paymentType: json['paymentType'],
      governate: json['governate'],
      isPromoApplied: json['isPromoApplied'],
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
  final num productRate;
  final String size;
  final String color;
  final num quantity;
  final num price;
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
