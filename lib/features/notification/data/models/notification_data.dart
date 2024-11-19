// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class NotificationData extends Equatable {
  final String id;
  final String userId;
  final String message;
  final String targetId;
  final String type;
  final String date;
  const NotificationData({
    required this.id,
    required this.userId,
    required this.message,
    required this.targetId,
    required this.type,
    required this.date,
  });

  @override
  List<Object> get props {
    return [
      id,
      userId,
      message,
      targetId,
      type,
      date,
    ];
  }

  factory NotificationData.fromMap(Map<String, dynamic> map) {
    return NotificationData(
      id: map['id'] as String,
      userId: map['userId'] as String,
      message: map['message'] as String,
      targetId: map['targetId'] as String,
      type: map['type'] as String,
      date: map['date'] as String,
    );
  }
}
