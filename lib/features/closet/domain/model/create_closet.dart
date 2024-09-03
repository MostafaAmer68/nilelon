// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:equatable/equatable.dart';

class CreateCloset extends Equatable {
  final String name;
  final String CustomerId;
  const CreateCloset({
    required this.name,
    required this.CustomerId,
  });

  @override
  List<Object> get props => [name, CustomerId];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'CustomerId': CustomerId,
    };
  }

  factory CreateCloset.fromMap(Map<String, dynamic> map) {
    return CreateCloset(
      name: map['name'] as String,
      CustomerId: map['CustomerId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateCloset.fromJson(String source) =>
      CreateCloset.fromMap(json.decode(source) as Map<String, dynamic>);
}
