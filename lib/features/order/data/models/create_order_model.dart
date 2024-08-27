// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class OrderModel extends Equatable {
  final int total;
  final String phoneNum;
  final num discount;
  final String type;
  final String shippingMethodId;
  final String customerId;
  final String governate;
  final String transactionId;
  final Map<String, dynamic> customerAddressDTO;
  final List<Map<String, dynamic>> orderProductVeriants;
  const OrderModel({
    required this.total,
    required this.phoneNum,
    required this.discount,
    required this.type,
    required this.shippingMethodId,
    required this.customerId,
    required this.governate,
    required this.transactionId,
    required this.customerAddressDTO,
    required this.orderProductVeriants,
  });

  @override
  List<Object> get props {
    return [
      total,
      phoneNum,
      discount,
      type,
      shippingMethodId,
      customerId,
      governate,
      transactionId,
      customerAddressDTO,
      orderProductVeriants,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'total': total,
      'phoneNum': phoneNum,
      'discount': discount,
      'type': type,
      'shippingMethodId': shippingMethodId,
      'customerId': customerId,
      'governate': governate,
      'transactionId': transactionId,
      'customerAddressDTO': customerAddressDTO,
      'orderProductVeriants': orderProductVeriants,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      total: map['total'] as int,
      phoneNum: map['phoneNum'] as String,
      discount: map['discount'] as num,
      type: map['type'] as String,
      shippingMethodId: map['shippingMethodId'] as String,
      customerId: map['customerId'] as String,
      governate: map['governate'] as String,
      transactionId: map['transactionId'] as String,
      customerAddressDTO: Map<String, dynamic>.from(
          (map['customerAddressDTO'] as Map<String, dynamic>)),
      orderProductVeriants: List<Map<String, dynamic>>.from(
        map['orderProductVeriants'].map<Map<String, dynamic>>((x) => x),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
