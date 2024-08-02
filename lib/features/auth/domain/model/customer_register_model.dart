import 'package:equatable/equatable.dart';

class CustomerRegisterModel extends Equatable {
  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final String? birthDate;
  final bool? gender;
  final String? password;
  final String? confirmPassword;

  const CustomerRegisterModel({
    this.fullName,
    this.email,
    this.phoneNumber,
    this.birthDate,
    this.gender,
    this.password,
    this.confirmPassword,
  });

  factory CustomerRegisterModel.fromJson(Map<String, dynamic> json) =>
      CustomerRegisterModel(
        fullName: json["fullName"],
        email: json['email'],
        phoneNumber: json["phoneNumber"],
        birthDate: json['birthDate'],
        gender: json["gender"],
        password: json['password'],
        confirmPassword: json["confirmPassword"],
      );

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'email': email,
        'phoneNumber': phoneNumber,
        'birthDate': birthDate,
        'gender': gender,
        'password': password,
        'confirmPassword': confirmPassword,
      };

  @override
  List<Object?> get props => [
        fullName,
        email,
        phoneNumber,
        birthDate,
        gender,
        password,
        confirmPassword,
      ];
}
