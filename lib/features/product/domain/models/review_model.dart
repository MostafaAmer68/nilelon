// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class ReviewModel extends Equatable {
  final String comment;
  final int rate;
  final String productId;
  final String customerName;
  final String profilePic;
  final String date;

  const ReviewModel({
    required this.comment,
    required this.rate,
    required this.productId,
    required this.customerName,
    required this.profilePic,
    required this.date,
  });

  @override
  List<Object> get props {
    return [
      comment,
      rate,
      productId,
      customerName,
      profilePic,
      date,
    ];
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      comment: map['comment'] as String,
      rate: map['rate'] as int,
      productId: map['productId'] as String,
      customerName: map['customerName'] as String,
      profilePic: map['profilePic'] ?? '',
      date: map['date'] as String,
    );
  }
}
