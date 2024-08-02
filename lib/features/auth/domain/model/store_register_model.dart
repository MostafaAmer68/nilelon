import 'package:equatable/equatable.dart';

class StoreRegisterModel extends Equatable {
  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final String? profileLink;
  final String? websiteLink;
  final String? repName;
  final String? repPhone;
  final String? warehouseAddress;
  final String? password;
  final String? confirmPassword;

  const StoreRegisterModel({
    this.fullName,
    this.email,
    this.phoneNumber,
    this.profileLink,
    this.websiteLink,
    this.repName,
    this.repPhone,
    this.warehouseAddress,
    this.password,
    this.confirmPassword,
  });

  factory StoreRegisterModel.fromJson(Map<String, dynamic> json) {
    return StoreRegisterModel(
      fullName: json['fullName'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      profileLink: json['profileLink'] as String?,
      websiteLink: json['websiteLink'] as String?,
      repName: json['repName'] as String?,
      repPhone: json['repPhone'] as String?,
      warehouseAddress: json['warehouseAddress'] as String?,
      password: json['password'] as String?,
      confirmPassword: json['confirmPassword'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'email': email,
        'phoneNumber': phoneNumber,
        'profileLink': profileLink,
        'websiteLink': websiteLink,
        'repName': repName,
        'repPhone': repPhone,
        'warehouseAddress': warehouseAddress,
        'password': password,
        'confirmPassword': confirmPassword,
      };

  @override
  List<Object?> get props {
    return [
      fullName,
      email,
      phoneNumber,
      profileLink,
      websiteLink,
      repName,
      repPhone,
      warehouseAddress,
      password,
      confirmPassword,
    ];
  }
}
