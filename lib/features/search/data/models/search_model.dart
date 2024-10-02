// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class SearchModel extends Equatable {
  final String id;
  final String name;
  final bool isStore;
  final String picture;
  const SearchModel({
    required this.id,
    required this.name,
    required this.isStore,
    required this.picture,
  });

  factory SearchModel.fromMap(Map<String, dynamic> map) {
    return SearchModel(
      id: map['id'] as String,
      isStore: map['isStore'] as bool,
      name: map['name'] as String,
      picture: map['picture'] ?? '',
    );
  }

  @override
  List<Object> get props => [id, name, picture, isStore];
}
