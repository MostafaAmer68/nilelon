import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'result.g.dart';

@HiveType(typeId: 4)
class Result extends Equatable {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String? image;

  const Result({this.id, this.name, this.image});

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json['id'] as String?,
        name: json['name'] as String?,
        image: json['image'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
      };

  @override
  List<Object?> get props => [id, name, image];
}
