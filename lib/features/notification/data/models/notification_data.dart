// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:equatable/equatable.dart';

class NotificationData extends Equatable {
  final String id;
  final String userId;
  final String message;
  final String targetId;
  final bool isRead;
  final String type;
  final String date;
  const NotificationData({
    required this.id,
    required this.userId,
    required this.message,
    required this.targetId,
    required this.isRead,
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
      isRead: map['isRead'] as bool,
      type: map['type'] as String,
      date: map['date'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'message': message,
      'targetId': targetId,
      'isRead': isRead,
      'type': type,
      'date': date,
    };
  }

  NotificationData copyWith({
    String? id,
    String? userId,
    String? message,
    String? targetId,
    bool? isRead,
    String? type,
    String? date,
  }) {
    return NotificationData(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      message: message ?? this.message,
      targetId: targetId ?? this.targetId,
      isRead: isRead ?? this.isRead,
      type: type ?? this.type,
      date: date ?? this.date,
    );
  }
}
