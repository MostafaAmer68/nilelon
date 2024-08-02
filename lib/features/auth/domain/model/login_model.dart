// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class LoginModel extends Equatable {
  final String? email;
  final String? password;
  final String? connectionId;

  const LoginModel({
    this.email,
    this.password,
    this.connectionId,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        email: json['email'] as String?,
        connectionId: json['connectionId'] as String?,
        password: json['password'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'connectionId': connectionId,
        'password': password,
      };

  @override
  List<Object?> get props => [email, password, connectionId];
}
