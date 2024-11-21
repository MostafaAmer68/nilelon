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
      storeBestseller: json['storeBestseller'] != null
          ? (json['storeBestseller'] as List)
              .map((e) => ProductBetSeller.fromMap(e))
              .toList()
          : [],
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
  final String productName;
  final String description;
  final int quantity;
  final int soledItems;
  final num rating;
  final String color;
  final String productIMages;
  const ProductBetSeller({
    required this.productId,
    required this.price,
    required this.size,
    required this.productName,
    required this.description,
    required this.quantity,
    required this.soledItems,
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
      productName,
      description,
      quantity,
      soledItems,
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
      'productName': productName,
      'description': description,
      'quantity': quantity,
      'soledItems': soledItems,
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
      productName: map['productName'] as String,
      description: map['description'] as String,
      quantity: map['quantity'] as int,
      soledItems: map['soledItems'] as int,
      rating: map['rating'] as num,
      color: map['color'] as String,
      productIMages: (map['productIMages'] as String?) ?? '',
    );
  }

  ProductBetSeller copyWith({
    String? productId,
    num? price,
    String? size,
    String? productName,
    String? description,
    int? quantity,
    int? soledItems,
    num? rating,
    String? color,
    String? productIMages,
  }) {
    return ProductBetSeller(
      productId: productId ?? this.productId,
      price: price ?? this.price,
      size: size ?? this.size,
      productName: productName ?? this.productName,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      soledItems: soledItems ?? this.soledItems,
      rating: rating ?? this.rating,
      color: color ?? this.color,
      productIMages: productIMages ?? this.productIMages,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductBetSeller.fromJson(String source) =>
      ProductBetSeller.fromMap(json.decode(source) as Map<String, dynamic>);
}
