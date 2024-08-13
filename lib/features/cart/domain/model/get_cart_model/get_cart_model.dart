import 'package:equatable/equatable.dart';

import 'result.dart';

class GetCartModel extends Equatable {
  final int? statusCode;
  final bool? isSuccess;
  final List<dynamic>? errorMessages;
  final CartResult? result;

  const GetCartModel({
    this.statusCode,
    this.isSuccess,
    this.errorMessages,
    this.result,
  });

  factory GetCartModel.fromJson(Map<String, dynamic> json) => GetCartModel(
        statusCode: json['statusCode'] as int?,
        isSuccess: json['isSuccess'] as bool?,
        errorMessages: json['errorMessages'] as List<dynamic>?,
        result: json['result'] == null
            ? null
            : CartResult.fromJson(json['result'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'isSuccess': isSuccess,
        'errorMessages': errorMessages,
        'result': result?.toJson(),
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
