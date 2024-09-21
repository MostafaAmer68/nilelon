// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class StoreProfile extends Equatable {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String repName;
  final String? storeSlogan;
  final String repPhone;
  final String warehouseAddress;
  final String? profilePic;

  const StoreProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.repName,
    this.storeSlogan,
    required this.repPhone,
    required this.warehouseAddress,
    required this.profilePic,
  });

  @override
  List<Object> get props {
    return [
      id,
      name,
      email,
      phoneNumber,
      repName,
      storeSlogan!,
      repPhone,
      warehouseAddress,
      profilePic!,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'repName': repName,
      'storeSlogan': storeSlogan,
      'repPhone': repPhone,
      'warehouseAddress': warehouseAddress,
      'profilePic': profilePic,
    };
  }

  factory StoreProfile.fromMap(Map<String, dynamic> map) {
    return StoreProfile(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
      repName: map['repName'] as String,
      storeSlogan:
          map['storeSlogan'] != null ? map['storeSlogan'] as String : null,
      repPhone: map['repPhone'] as String,
      warehouseAddress: map['warehouseAddress'] as String,
      profilePic:
          map['profilePic'] != null ? map['profilePic'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory StoreProfile.fromJson(String source) =>
      StoreProfile.fromMap(json.decode(source) as Map<String, dynamic>);
}
