// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:equatable/equatable.dart';

class ClosetModel extends Equatable {
  final String id;
  final String name;
  const ClosetModel({
    required this.id,
    required this.name,
  });

  @override
  List<Object> get props => [id, name];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory ClosetModel.fromMap(Map<String, dynamic> map) {
    return ClosetModel(
      id: map['id'].toString(),
      name: map['name'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ClosetModel.fromJson(String source) =>
      ClosetModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
