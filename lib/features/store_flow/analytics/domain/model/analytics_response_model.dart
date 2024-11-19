// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class DashboardModel {
  final num storeFollowers;
  final List<ProductBetSeller> storeBestseller;
  final num storeNumberOfItemsSold;
  final num storeNumberOfNotifications;
  final num storeOrdersNumber;
  final num storeTotalIncome;
  final num storeRate;

  DashboardModel({
    required this.storeFollowers,
    required this.storeBestseller,
    required this.storeNumberOfItemsSold,
    required this.storeNumberOfNotifications,
    required this.storeOrdersNumber,
    required this.storeTotalIncome,
    required this.storeRate,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      storeFollowers: json['storeFollowers'],
      storeBestseller: (json['storeBestseller'] as List)
          .map((e) => ProductBetSeller.fromMap(e))
          .toList(),
      storeNumberOfItemsSold: json['storeNumberOfItemsSold'],
      storeNumberOfNotifications: json['storeNumberOfNotifications'],
      storeOrdersNumber: json['storeOrdersNumber'],
      storeTotalIncome: json['storeTotalIncome'],
      storeRate: json['storeRate'],
    );
  }
  factory DashboardModel.empty() {
    return DashboardModel(
      storeFollowers: 0,
      storeBestseller: [],
      storeNumberOfItemsSold: 0,
      storeNumberOfNotifications: 0,
      storeOrdersNumber: 0,
      storeTotalIncome: 0,
      storeRate: 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'storeFollowers': storeFollowers,
      'storeBestseller': storeBestseller,
      'storeNumberOfItemsSold': storeNumberOfItemsSold,
      'storeNumberOfNotifications': storeNumberOfNotifications,
      'storeOrdersNumber': storeOrdersNumber,
      'storeTotalIncome': storeTotalIncome,
      'storeRate': storeRate,
    };
  }
}

class ProductBetSeller extends Equatable {
  final String productId;
  final num price;
  final String size;
  final int quantity;
  final num rating;
  final String color;
  final String productIMages;
  const ProductBetSeller({
    required this.productId,
    required this.price,
    required this.size,
    required this.quantity,
    required this.rating,
    required this.color,
    required this.productIMages,
  });

  @override
  List<Object> get props {
    return [
      productId,
      price,
      size,
      quantity,
      rating,
      color,
      productIMages,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'price': price,
      'size': size,
      'quantity': quantity,
      'rating': rating,
      'color': color,
      'productIMages': productIMages,
    };
  }

  factory ProductBetSeller.fromMap(Map<String, dynamic> map) {
    return ProductBetSeller(
      productId: map['productId'] as String,
      price: map['price'] as num,
      size: map['size'] as String,
      quantity: map['quantity'] as int,
      rating: map['rating'] as num,
      color: map['color'] as String,
      productIMages: (map['productIMages'] as String?) ?? '',
    );
  }
}
