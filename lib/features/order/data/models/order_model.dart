// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class OrderModel extends Equatable {
  final String id;
  final String date;
  final String governate;
  final String status;
  final num total;

  const OrderModel({
    required this.id,
    required this.date,
    required this.governate,
    required this.status,
    required this.total,
  });

  @override
  List<Object> get props => [
        id,
        date,
        status,
        governate,
        total,
      ];

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] as String,
      date: (map['date'] as String).substring(0, 26),
      status: map['status'] as String,
      governate: map['governate'] as String,
      total: map['total'] as num,
    );
  }
}
