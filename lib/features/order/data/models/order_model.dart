// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class CustomerOrder extends Equatable {
  final String id;
  final String date;
  final double total;
  final double discount;
  final String promoCodeName;
  final String governate;
  final String status;
  final String phoneNumber;
  final String shippingCost;
  final String customerId;
  final List<OrderProductVariant> orderProductVariants;

  const CustomerOrder({
    required this.id,
    required this.date,
    required this.total,
    required this.discount,
    required this.promoCodeName,
    required this.governate,
    required this.status,
    required this.phoneNumber,
    required this.shippingCost,
    required this.customerId,
    required this.orderProductVariants,
  });

  @override
  List<Object> get props {
    return [
      id,
      date,
      total,
      discount,
      promoCodeName,
      governate,
      status,
      phoneNumber,
      shippingCost,
      customerId,
      orderProductVariants,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date,
      'total': total,
      'discount': discount,
      'promoCodeName': promoCodeName,
      'governate': governate,
      'status': status,
      'phoneNumber': phoneNumber,
      'shippingCost': shippingCost,
      'customerId': customerId,
      'orderProductVariants':
          orderProductVariants.map((x) => x.toMap()).toList(),
    };
  }

  factory CustomerOrder.fromMap(Map<String, dynamic> map) {
    return CustomerOrder(
      id: map['id'] as String,
      date: map['date'] as String,
      total: map['total'] as double,
      discount: map['discount'] as double,
      promoCodeName: map['promoCodeName'] as String,
      governate: map['governate'] as String,
      status: map['status'] as String,
      phoneNumber: map['phoneNumber'] as String,
      shippingCost: map['shippingCost'] as String,
      customerId: map['customerId'] as String,
      orderProductVariants: List<OrderProductVariant>.from(
        (map['orderProductVariants'] as List<int>).map<OrderProductVariant>(
          (x) => OrderProductVariant.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}

class StoreOrder extends Equatable {
  final String id;
  final String date;
  final List<OrderProductVariant> orderProductVariants;

  const StoreOrder({
    required this.id,
    required this.date,
    required this.orderProductVariants,
  });

  @override
  List<Object> get props => [id, date, orderProductVariants];

  factory StoreOrder.fromMap(Map<String, dynamic> map) {
    return StoreOrder(
      id: map['id'] as String,
      date: map['date'] as String,
      orderProductVariants: List<OrderProductVariant>.from(
        (map['orderProductVariants'] as List<int>).map<OrderProductVariant>(
          (x) => OrderProductVariant.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}

class OrderProductVariant extends Equatable {
  final String orderId;
  final String productId;
  final String productName;
  final double productRate;
  final String size;
  final String color;
  final int quantity;
  final double price;
  final String storeName;
  final String storeId;
  final List<String> urls;

  const OrderProductVariant({
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

  @override
  List<Object> get props {
    return [
      orderId,
      productId,
      productName,
      productRate,
      size,
      color,
      quantity,
      price,
      storeName,
      storeId,
      urls,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderId': orderId,
      'productId': productId,
      'productName': productName,
      'productRate': productRate,
      'size': size,
      'color': color,
      'quantity': quantity,
      'price': price,
      'storeName': storeName,
      'storeId': storeId,
      'urls': urls,
    };
  }

  factory OrderProductVariant.fromMap(Map<String, dynamic> map) {
    return OrderProductVariant(
      orderId: map['orderId'] as String,
      productId: map['productId'] as String,
      productName: map['productName'] as String,
      productRate: map['productRate'] as double,
      size: map['size'] as String,
      color: map['color'] as String,
      quantity: map['quantity'] as int,
      price: map['price'] as double,
      storeName: map['storeName'] as String,
      storeId: map['storeId'] as String,
      urls: List<String>.from(map['urls'] as List<String>),
    );
  }
}
