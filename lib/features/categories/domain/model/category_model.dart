import 'package:equatable/equatable.dart';

import 'result.dart';

class CategoryModel extends Equatable {
  final int? statusCode;
  final bool? isSuccess;
  final List<dynamic>? errorMessages;
  final List<Result>? result;

  const CategoryModel({
    this.statusCode,
    this.isSuccess,
    this.errorMessages,
    this.result,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      statusCode: json['statusCode'] as int?,
      isSuccess: json['isSuccess'] as bool?,
      errorMessages: json['errorMessages'] as List<dynamic>?,
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'isSuccess': isSuccess,
        'errorMessages': errorMessages,
        'result': result?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props {
    return [
      statusCode,
      isSuccess,
      errorMessages,
      result,
    ];
  }
}
