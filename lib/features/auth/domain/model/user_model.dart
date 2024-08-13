import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';
import 'dart:convert';

// Register the adapters for Hive
part 'user_model.g.dart';

@HiveType(typeId: 5)
class UserModel<T extends BaseUserData> extends Equatable {
  @HiveField(0)
  final String token;
  @HiveField(1)
  final String role;
  @HiveField(2)
  final T userData;

  const UserModel({
    required this.token,
    required this.role,
    required this.userData,
  });

  @override
  List<Object> get props => [
        token,
        role,
      ];

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      token: map['token'] as String,
      role: map['role'] as String,
      userData: map['role'] == 'Store'
          ? StoreModel.fromMap(map['storeDto'] as Map<String, dynamic>) as T
          : CustomerModel.fromMap(map['customerDto'] as Map<String, dynamic>)
              as T,
    );
  }
}

@HiveType(typeId: 6)
class BaseUserData extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String phoneNumber;
  @HiveField(3)
  final String profilePic;

  const BaseUserData({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.profilePic,
  });

  @override
  List<Object> get props => [name, email, phoneNumber, profilePic];
}

@HiveType(typeId: 7)
class StoreModel extends BaseUserData {
  @HiveField(5)
  final String repName;
  @HiveField(6)
  final String storeSlogan;
  @HiveField(7)
  final String repPhone;
  @HiveField(8)
  final String warehouseAddress;

  const StoreModel({
    required super.name,
    required super.email,
    required super.phoneNumber,
    required this.repName,
    required this.storeSlogan,
    required this.repPhone,
    required this.warehouseAddress,
    required super.profilePic,
  });

  @override
  List<Object> get props {
    return [
      name,
      email,
      phoneNumber,
      repName,
      storeSlogan,
      repPhone,
      warehouseAddress,
      profilePic,
    ];
  }

  factory StoreModel.fromMap(Map<String, dynamic> map) {
    return StoreModel(
      name: map['name'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
      repName: map['repName'] as String,
      storeSlogan: map['storeSlogan'] as String,
      repPhone: map['repPhone'] as String,
      warehouseAddress: map['warehouseAddress'] as String,
      profilePic: map['profilePic'] as String,
    );
  }
}

@HiveType(typeId: 8)
class CustomerModel extends BaseUserData {
  @HiveField(9)
  final String dateOfBirth;
  @HiveField(10)
  final String gender;
  @HiveField(11)
  final String productsChoice;

  const CustomerModel({
    required super.name,
    required super.email,
    required super.phoneNumber,
    required this.dateOfBirth,
    required this.gender,
    required this.productsChoice,
    required super.profilePic,
  });

  @override
  List<Object> get props {
    return [
      name,
      email,
      phoneNumber,
      dateOfBirth,
      gender,
      productsChoice,
      profilePic,
    ];
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      name: map['name'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
      dateOfBirth: map['dateOfBirth'] as String,
      gender: map['gender'] as String,
      productsChoice: map['productsChoice'] as String,
      profilePic: map['profilePic'] as String,
    );
  }
}
