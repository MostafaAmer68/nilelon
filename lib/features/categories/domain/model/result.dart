// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'result.g.dart';

@HiveType(typeId: 4)
class CategoryModel extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String image;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.image,
  });
  factory CategoryModel.empty() =>
      const CategoryModel(id: '', name: 'All', image: '');
  @override
  List<Object> get props => [id, name, image];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as String,
      name: map['name'] as String,
      image: map['image'] as String,
    );
  }
}
