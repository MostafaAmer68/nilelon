// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:equatable/equatable.dart';

class ReturnModel extends Equatable {
  final String id;
  final String date;
  final String orderId;
  final String reason;
  const ReturnModel({
    required this.id,
    required this.date,
    required this.orderId,
    required this.reason,
  });

  @override
  List<Object> get props => [id, date, orderId, reason];

  factory ReturnModel.fromMap(Map<String, dynamic> map) {
    return ReturnModel(
      id: map['id'] as String,
      date: map['date'] as String,
      orderId: map['orderId'] as String,
      reason: map['reason'] as String,
    );
  }
}
