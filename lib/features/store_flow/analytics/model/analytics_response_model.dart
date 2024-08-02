import 'package:equatable/equatable.dart';

class AnalyticsResponseModel extends Equatable {
  final int? statusCode;
  final bool? isSuccess;
  final List<dynamic>? errorMessages;
  final num? result;

  const AnalyticsResponseModel({
    this.statusCode,
    this.isSuccess,
    this.errorMessages,
    this.result,
  });

  factory AnalyticsResponseModel.fromJson(Map<String, dynamic> json) {
    return AnalyticsResponseModel(
      statusCode: json['statusCode'] as int?,
      isSuccess: json['isSuccess'] as bool?,
      errorMessages: json['errorMessages'] as List<dynamic>?,
      result: json['result'] as num?,
    );
  }

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'isSuccess': isSuccess,
        'errorMessages': errorMessages,
        'result': result,
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
