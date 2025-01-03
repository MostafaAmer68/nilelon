// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

// Register the adapters for Hive
part 'user_model.g.dart';

@HiveType(typeId: 5)
class UserModel<T extends BaseUserData> extends Equatable {
  @HiveField(0)
  final String token;
  @HiveField(1)
  final String id;
  @HiveField(2)
  final String role;
  @HiveField(3)
  final T userData;

  const UserModel({
    required this.id,
    required this.token,
    required this.role,
    required this.userData,
  });

  @override
  List<Object> get props => [
        id,
        token,
        role,
      ];

  TModel getUserData<TModel>() => userData as TModel;

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      token: map['token'] as String,
      role: map['role'] as String,
      userData: map['role'] == 'Store'
          ? StoreModel.fromMap(map['data'] as Map<String, dynamic>) as T
          : CustomerModel.fromMap(map['data'] as Map<String, dynamic>) as T,
      id: map['id'] as String,
    );
  }

  UserModel<T> copyWith({
    String? token,
    String? id,
    String? role,
    T? userData,
  }) {
    return UserModel<T>(
      token: token ?? this.token,
      id: id ?? this.id,
      role: role ?? this.role,
      userData: userData ?? this.userData,
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
      storeSlogan: map['storeSlogan'] ?? '',
      repPhone: map['repPhone'] as String,
      warehouseAddress: map['warehouseAddress'] as String,
      profilePic: map['profilePic'] ?? '',
    );
  }

  StoreModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? prfile,
    String? repName,
    String? storeSlogan,
    String? repPhone,
    String? warehouseAddress,
  }) {
    return StoreModel(
      name:name?? super.name,
      email:email?? super.email,
      phoneNumber:phone?? super.phoneNumber,
      profilePic: prfile ?? super.profilePic,
      repName: repName ?? this.repName,
      storeSlogan: storeSlogan ?? this.storeSlogan,
      repPhone: repPhone ?? this.repPhone,
      warehouseAddress: warehouseAddress ?? this.warehouseAddress,
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
      profilePic: map['profilePic'] ?? '',
    );
  }

  CustomerModel copyWith({
    String? dateOfBirth,
    String? gender,
    String? productsChoice,
    String? name,
    String? email,
    String? phone,
    String? profilePic,
  }) {
    return CustomerModel(
      name: name ?? super.name,
      email: email ?? super.email,
      phoneNumber: phone ?? super.phoneNumber,
      profilePic: profilePic ?? super.profilePic,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      productsChoice: productsChoice ?? this.productsChoice,
    );
  }
}
